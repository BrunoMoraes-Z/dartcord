import 'package:bot/contants.dart';
import 'package:bot/utilities/lavalink/player.dart';
import 'package:nyxx/nyxx.dart';
import 'package:nyxx_lavalink/lavalink.dart';

import './extensions/extensions.dart';
import '../commands/commands.dart';

late Cluster? cluster;

void registerCommands(Nyxx bot) {
  bot.onMessageReceived.listen((event) async {
    if (event.message.content.startsWith(config.prefix)) {
      var cmdPrefix = event.message.content.split(' ')[0];
      var cmd = cmdPrefix.replaceFirst(config.prefix, '').toLowerCase();
      var command = commands.where((element) => element.commandName == cmd);

      if (command.isEmpty) {
        command = commands.where((element) => element.aliases.contains(cmd));
      }

      if (command.isEmpty) {
        await event.message
            .reply(content: 'Nenhum comando encontrado com o nome **$cmd**.')
            .deleteAfter();
      } else {
        command.first.onExecute(
          event.message,
          event.message.content.replaceAll(cmdPrefix, '').trim().split(' '),
          bot,
        );
      }
    }
  });
}

Future<void> registerCluster(NodeOptions options) async {
  cluster = Cluster(bot, config.botId);
  if (cluster != null) {
    await cluster!.addNode(options);
  }

  player = Player();

  if (cluster != null) {
    cluster!.onTrackStart.listen((event) {
      var np = event.node.players.values.first.nowPlaying;
      if (np != null) {
        bot.setPresence(
          PresenceBuilder.of(
            status: UserStatus.online,
            activity: ActivityBuilder.listening(
              np.track.info!.title,
            ),
          ),
        );
      }
    });
    cluster!.onTrackEnd.listen((event) {
      bot.setPresence(
        PresenceBuilder.of(
          status: UserStatus.online,
        ),
      );
    });
  }
}

import 'package:bot/contants.dart';
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
      var args =
          event.message.content.replaceAll(cmdPrefix, '').trim().split(' ');
      args = args.toString() == '[]' ? [] : args;

      if (command.isEmpty) {
        await event.message
            .reply(content: 'Nenhum comando encontrado com o nome **$cmd**.')
            .deleteAfter();
      } else {
        var member = await event.message.getAuthorMember();
        if (command.first.roles.isNotEmpty) {
          if (member.containsRole(command.first.roles) ||
              config.owner == member.id) {
            await command.first.onExecute(
              event.message,
              args,
              bot,
            );
          } else {
            await event.message
                .reply(
                  content:
                      'Você não possui permissão para utilizar este comando.',
                )
                .deleteAfter();
          }
        } else {
          await command.first.onExecute(
            event.message,
            args,
            bot,
          );
        }
      }
    }
  });
}

Future<void> registerCluster(NodeOptions options) async {
  cluster = Cluster(bot, config.botId);
  if (cluster != null) {
    await cluster!.addNode(options);
  }

  if (cluster != null) {
    // On Track Start
    cluster!.onTrackStart.listen((event) {
      if (players.isNotEmpty) {
        bot.setPresence(
          PresenceBuilder.of(
            status: UserStatus.online,
            activity: ActivityBuilder.game(
              'In ${players.length} Servers',
            ),
          ),
        );
      }
    });

    // On Track End
    cluster!.onTrackEnd.listen((event) {
      var guild = event.guildId;
      var player = players[guild]!;

      if (player.queue().isEmpty) {
        player.disconnect();
        players.remove(guild);
      } else {
        var song = player.queue().first;
        player.text.sendMessage(
          MessageBuilder.content(
            '🎶 Tocando **${song.track.info!.title}**.',
          ),
        );
      }

      if (players.isEmpty) {
        bot.setPresence(
          PresenceBuilder.of(
            status: UserStatus.online,
          ),
        );
      }
    });
  }
}

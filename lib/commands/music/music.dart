import 'package:bot/contants.dart';
import 'package:bot/interfaces/icommand.dart';
import 'package:nyxx/nyxx.dart';
import 'package:nyxx_lavalink/lavalink.dart';

class MusicCommand implements ICommand {
  @override
  List<String> aliases = ['p'];

  @override
  String commandName = 'music';

  @override
  void onExecute(Message message, List<String> args, Nyxx bot) async {
    if (message.author.id == config.owner) {
      final cluster = Cluster(bot, Snowflake('BOT_ID'));
      final guildID = Snowflake(message.getGuild().id);

      await cluster.addNode(NodeOptions());

      if (args[0] == 'join') {
        var user = await message.getAuthorMember();
        if (user.isVoiceConnected) {
          var channel = user.voiceState!.channel!.getFromCache();
          var vchannel = await bot.fetchChannel<VoiceGuildChannel>(channel!.id);
          cluster.getOrCreatePlayerNode(guildID);
          vchannel.connect(selfMute: true);
        } else {
          await message
              .reply(content: 'Você deve estar conectado a um canal de voz.')
              .deleteAfter();
        }
      }
    } else {
      await message
          .reply(content: 'Você não tem permissao para utilizar este comando.')
          .deleteAfter();
    }
  }
}

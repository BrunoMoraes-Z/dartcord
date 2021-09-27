import 'package:bot/contants.dart';
import 'package:bot/interfaces/icommand.dart';
import 'package:bot/utilities/register.dart';
import 'package:nyxx/nyxx.dart';

class MusicCommand implements ICommand {
  @override
  List<String> aliases = ['p'];

  @override
  String commandName = 'music';

  @override
  void onExecute(Message message, List<String> args, Nyxx bot) async {
    if (message.author.id == config.owner) {
      final guildID = Snowflake(message.getGuild().id);

      if (args.isEmpty) {
        await message
            .reply(
              content: '${config.prefix}music <join, quit, play>.',
            )
            .deleteAfter(
              duration: Duration(seconds: 10),
            );
        return;
      }
      var node = cluster!.getOrCreatePlayerNode(guildID);

      if (args[0] == 'join') {
        var user = await message.getAuthorMember();
        if (user.isVoiceConnected) {
          var channel = user.voiceState!.channel!.getFromCache();
          var vchannel = await bot.fetchChannel<VoiceGuildChannel>(channel!.id);
          node.createPlayer(guildID);
          vchannel.connect(selfDeafen: true);
        } else {
          await message
              .reply(content: 'Você deve estar conectado a um canal de voz.')
              .deleteAfter();
        }
      }
      if (args[0] == 'quit') {
        node.destroy(guildID);
        await message
            .reply(
              content: 'PlayList limpa.',
            )
            .deleteAfter();
      }
      if (args[0] == 'play') {
        if (args.length == 1) {
        } else {
          var tracks = await node.searchTracks(args[1]);
          var track = tracks.tracks[0];
          node.play(guildID, track).queue();
          node.setPause(guildID, false);

          var ch = await message.channel.download();
          await ch.sendMessage(
            MessageBuilder.content(
              'Adicionado a PlayList **${track.info!.title}**',
            ),
          );
        }
      }
    } else {
      await message
          .reply(content: 'Você não tem permissao para utilizar este comando.')
          .deleteAfter();
    }
  }
}

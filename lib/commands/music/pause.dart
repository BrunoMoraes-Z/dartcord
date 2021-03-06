import 'package:bot/contants.dart';
import 'package:bot/interfaces/icommand.dart';
import 'package:nyxx/nyxx.dart';

class PauseCommand implements ICommand {
  @override
  String commandName = 'pause';
  @override
  List<String> roles = ['DJ'];
  @override
  List<String> aliases = [];

  @override
  Future<void> onExecute(Message message, List<String> args, Nyxx bot) async {
    var member = await message.getAuthorMember();
    if (member.isVoiceConnected) {
      if (players.containsKey(message.getGuild())) {
        var player = players[message.getGuild()];
        var ch = await member.getVoiceChannel;
        if (ch.name == player!.voice.name) {
          if (player.isPlaying) {
            player.pause();
            await message.reply(
              content:
                  'Pausada a música **${player.song.track.info!.title}**, `${prefix}resume`.',
            );
          } else {
            await message
                .reply(
                  content:
                      'Não estou tocando nenhuma música no momento `${prefix}resume`.',
                )
                .deleteAfter();
          }
        } else {
          await message
              .reply(
                content: 'Você precisa estar no mesmo canal de voz que o bot.',
              )
              .deleteAfter();
        }
      } else {
        await message
            .reply(
              content: 'Nenhuma música esta sendo tocada no momento.',
            )
            .deleteAfter();
      }
    } else {
      await message
          .reply(
            content:
                'Você precisa estar conectado para poder utilizar este comando.',
          )
          .deleteAfter();
    }
  }
}

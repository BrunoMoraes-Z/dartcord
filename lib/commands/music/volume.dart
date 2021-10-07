import 'package:bot/contants.dart';
import 'package:bot/interfaces/icommand.dart';
import 'package:nyxx/nyxx.dart';

class VolumeCommand implements ICommand {
  @override
  String commandName = 'volume';
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
          if (args.isEmpty) {
            await message.channel.sendMessage(
              MessageBuilder.content(
                '🔊 Volume `${player.volume}/1000`.',
              ),
            );
            return;
          }

          int volume;
          try {
            volume = int.parse(args[0]);
          } catch (e) {
            await message
                .reply(
                  content: 'Você precisa informar um número inteiro.',
                )
                .deleteAfter();
            return;
          }

          if (volume < 0 || volume > 1000) {
            await message
                .reply(
                  content: 'Você precisa informar um número entre `1 - 1000`.',
                )
                .deleteAfter();
            return;
          } else {
            player.setVolume(volume);
            await message.channel.sendMessage(
              MessageBuilder.content(
                '🔊 Volume `${player.volume}/1000`.',
              ),
            );
            return;
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

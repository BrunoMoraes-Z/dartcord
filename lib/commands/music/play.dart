import 'package:bot/contants.dart';
import 'package:bot/interfaces/icommand.dart';
import 'package:bot/utilities/common.dart';
import 'package:bot/utilities/lavalink/player.dart';
import 'package:bot/utilities/register.dart';
import 'package:nyxx/nyxx.dart';

class PlayCommand implements ICommand {
  @override
  String commandName = 'play';
  @override
  List<String> roles = ['DJ'];
  @override
  List<String> aliases = ['p'];

  @override
  Future<void> onExecute(Message message, List<String> args, Nyxx bot) async {
    if (args.isEmpty) {
      await message.channel.sendMessage(
        MessageBuilder.content(
          '🎵 Comando para Tocar:\n\n`- ${prefix}play <url>.`',
        ),
      );
      return;
    }
    final user = await message.getAuthorMember();

    if (!user.isVoiceConnected) {
      await message
          .reply(
            content: 'Você precisa esta em algum canal de voz.',
          )
          .deleteAfter();
      return;
    }
    var songName = args.join(' ');
    var guild = message.getGuild();
    var voice = await user.getVoiceChannel;

    final player = players[guild.id] ??
        Player.create(
          guild: guild,
          voice: voice,
          node: cluster!.getOrCreatePlayerNode(guild.id),
          text: await bot.fetchChannel<TextChannel>(message.channel.id),
        );

    if (!players.containsKey(guild.id)) {
      players[guild.id] = player;
    }

    if (!player.isConnected) {
      player.connect();
    }

    if (await player.play(songName)) {
      var song = player.queue().last;
      await message.channel.sendMessage(
        MessageBuilder.content(
          '🎶 Adicionado **${song.track.info!.title}** `${song.track.info!.stream ? "STREAM" : durationText(Duration(milliseconds: song.track.info!.length))}` - `${player.queue().length}º`',
        ),
      );
    } else {
      await message.channel.sendMessage(
        MessageBuilder.content(
          '❌ Não foi possivel encontrar esta música.',
        ),
      );
    }
  }
}

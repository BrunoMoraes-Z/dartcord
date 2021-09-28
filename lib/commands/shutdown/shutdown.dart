import 'package:bot/contants.dart';
import 'package:nyxx/nyxx.dart';

import '../../interfaces/icommand.dart';

class ShutdownCommand implements ICommand {
  @override
  String commandName = 'stop';
  @override
  List<String> roles = [];
  @override
  List<String> aliases = ['shutdown'];

  @override
  Future<void> onExecute(Message message, List<String> args, Nyxx bot) async {
    if (message.author.id == config.owner) {
      await message.reply(content: '😢 Desligando...');
      bot.setPresence(
        PresenceBuilder.of(
          status: UserStatus.offline,
        ),
      );
      players.forEach((key, value) => value.disconnect());
      lavalinkProcess.kill();
      await bot.dispose();
    } else {
      await message
          .reply(content: 'Você não tem permissao para utilizar este comando.')
          .deleteAfter();
    }
  }
}

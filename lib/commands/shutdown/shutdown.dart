import 'package:bot/contants.dart';
import 'package:nyxx/nyxx.dart';

import '../../interfaces/icommand.dart';

class ShutdownCommand implements ICommand {
  @override
  String commandName = 'stop';
  @override
  List<String> aliases = [];

  @override
  void onExecute(Message message, List<String> args, Nyxx bot) async {
    if (message.author.id == config.owner) {
      await message.reply(content: '😢 Desligando...');
      bot.setPresence(
        PresenceBuilder.of(
          status: UserStatus.offline,
        ),
      );
      await bot.dispose();
    } else {
      await message
          .reply(content: 'Você não tem permissao para utilizar este comando.')
          .deleteAfter();
    }
  }
}

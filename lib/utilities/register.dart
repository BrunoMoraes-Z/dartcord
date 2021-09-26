import 'package:bot/contants.dart';
import 'package:nyxx/nyxx.dart';

import './extensions/extensions.dart';
import '../commands/commands.dart';

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

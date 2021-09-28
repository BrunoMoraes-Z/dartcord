import 'package:bot/interfaces/icommand.dart';
import 'package:nyxx/nyxx.dart';

class PauseCommand implements ICommand {
  @override
  String commandName = 'pause';
  @override
  List<String> roles = [
    'DJ',
  ];
  @override
  List<String> aliases = [];

  @override
  Future<void> onExecute(Message message, List<String> args, Nyxx bot) async {
    var member = await message.getAuthorMember();
    print(member.containsRole(roles));
  }
}

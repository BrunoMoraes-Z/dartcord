import 'package:bot/interfaces/icommand.dart';
import 'package:nyxx/nyxx.dart';

class QuitCommand implements ICommand {
  @override
  String commandName = 'quit';
  @override
  List<String> roles = ['DJ'];
  @override
  List<String> aliases = [];

  @override
  Future<void> onExecute(Message message, List<String> args, Nyxx bot) {
    // TODO: implement onExecute
    throw UnimplementedError();
  }
}

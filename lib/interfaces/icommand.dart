import 'package:nyxx/nyxx.dart';
export '../utilities/extensions/extensions.dart';

abstract class ICommand {
  late String commandName;
  late List<String> aliases = [];
  late List<String> roles = [];

  Future<void> onExecute(Message message, List<String> args, Nyxx bot) async {}
}

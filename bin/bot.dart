import 'package:bot/contants.dart';
import 'package:bot/utilities/config/config_file_generator.dart';
import 'package:bot/utilities/register.dart';
import 'package:nyxx/nyxx.dart';

void main(List<String> arguments) async {
  config = readConfig();
  prefix = config.prefix;

  if (config.token.isEmpty) {
    print('---------------------------------------------------');
    print(' ');
    print('Configure the config.json file before starting Bot.');
    print(' ');
    print('---------------------------------------------------');
  } else {
    bot = Nyxx(config.token, GatewayIntents.allUnprivileged);

    // Register all Bot Commands
    registerCommands(bot);
  }
}

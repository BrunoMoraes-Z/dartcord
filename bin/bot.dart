import 'package:bot/contants.dart';
import 'package:bot/utilities/config/config_file_generator.dart';
import 'package:bot/utilities/lavalink/lavalink.dart';
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
    if (!inDebug && !existApllicationFile) {
      print('---------------------------------------------------');
      print(' ');
      print('Configure the application.yml file before starting Bot.');
      print(' ');
      print(
          'https://github.com/freyacodes/Lavalink/blob/master/LavalinkServer/application.yml.example');
      print(' ');
      print('---------------------------------------------------');
    } else {
      var port = applicationContent['server']['port'] as int;
      var host = applicationContent['server']['address'];
      var password = applicationContent['lavalink']['server']['password'];

      var link =
          LavaLink(host == '0.0.0.0' ? '127.0.0.1' : host, port, password);
      var options = await link.start();

      bot = Nyxx(config.token, GatewayIntents.allUnprivileged);

      // Register all Bot Commands
      registerCommands(bot);

      // Create Cluster
      await registerCluster(options);
    }
  }
}

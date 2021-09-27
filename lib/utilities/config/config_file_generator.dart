import 'dart:convert';
import 'dart:io';

import 'package:yaml/yaml.dart';

import 'config.dart';

final sysDir = Directory.fromUri(Uri.parse(Platform.script.path)).parent;
final _configFile = File.fromUri(
  Uri.file(
    '${sysDir.path}${Platform.pathSeparator}config.json',
  ),
);
final _apllicationFile = File.fromUri(
  Uri.file(
    '${sysDir.path}${Platform.pathSeparator}..${Platform.pathSeparator}application.yml',
  ),
);

bool get existConfigFile => _configFile.existsSync();

Config readConfig() {
  if (!existConfigFile) {
    _configFile.createSync();
    _configFile.writeAsStringSync(json.encode(
      {
        'token': '',
        'owner_id': 0,
        'bot_id': 0,
        'prefix': '\$',
        'default_duration_time': 3,
      },
    ));
  }
  var content = _configFile.readAsStringSync();
  return Config.fromJson(content);
}

bool get inDebug => File.fromUri(
      Uri.file(
        '${sysDir.path}${Platform.pathSeparator}bot.dart',
      ),
    ).existsSync();

dynamic get applicationContent => loadYaml(_apllicationFile.readAsStringSync());

bool get existApllicationFile => _apllicationFile.existsSync();

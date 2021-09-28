import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:bot/contants.dart';
import 'package:bot/utilities/config/config_file_generator.dart';
import 'package:nyxx_lavalink/lavalink.dart';

class LavaLink {
  final String host;
  final int port;
  final String password;

  LavaLink(this.host, this.port, this.password);

  Future<NodeOptions> start() async {
    var limiter = inDebug
        ? '${Platform.pathSeparator}..${Platform.pathSeparator}'
        : '${Platform.pathSeparator}';
    final app = File.fromUri(
      Uri.file(
        '${sysDir.path}${limiter}Lavalink.jar',
      ),
    );

    if (!app.existsSync()) {
      throw Exception('Lavalink.jar not found.');
    }

    var completer = Completer<NodeOptions>();

    lavalinkProcess = await Process.start(
      'java',
      ['-jar', 'Lavalink.jar'],
      workingDirectory: app.path.replaceFirst(
        '${Platform.pathSeparator}Lavalink.jar',
        '',
      ),
    );

    lavalinkProcess.stdout.transform(latin1.decoder).listen((data) {
      if (!completer.isCompleted) {
        data.split('\r\n').forEach((element) {
          element = element.trim();
          if (element.isNotEmpty) {
            print(element);
          }
        });
        if (data.contains(
            'You can safely ignore the big red warning about illegal reflection')) {
          completer.complete(
            NodeOptions(
              host: host,
              password: password,
              port: port,
            ),
          );
        }
      }
    });

    return completer.future;
  }
}

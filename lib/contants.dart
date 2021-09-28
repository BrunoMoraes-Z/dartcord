import 'dart:io';

import 'package:bot/utilities/config/config.dart';
import 'package:bot/utilities/lavalink/player.dart';
import 'package:nyxx/nyxx.dart';

late Config config;
late String prefix;
late Nyxx bot;
late Process lavalinkProcess;
final Map<Snowflake, Player> players = {};

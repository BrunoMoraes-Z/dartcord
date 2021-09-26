import 'package:bot/commands/music/music.dart';

import '../interfaces/icommand.dart';
import 'shutdown/shutdown.dart';

List<ICommand> commands = [
  ShutdownCommand(),
  MusicCommand(),
];

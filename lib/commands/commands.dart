import 'package:bot/commands/music/pause.dart';
import 'package:bot/commands/music/play.dart';

import '../interfaces/icommand.dart';
import 'shutdown/shutdown.dart';

List<ICommand> commands = [
  // Administrative
  ShutdownCommand(),
  // Music
  PlayCommand(),
  PauseCommand(),
];

import 'package:bot/commands/music/pause.dart';
import 'package:bot/commands/music/play.dart';
import 'package:bot/commands/music/resume.dart';
import 'package:bot/commands/music/volume.dart';

import '../interfaces/icommand.dart';
import 'shutdown/shutdown.dart';

List<ICommand> commands = [
  // Administrative
  ShutdownCommand(),
  // Music
  PlayCommand(),
  PauseCommand(),
  ResumeCommand(),
  VolumeCommand(),
];

import 'package:bot/contants.dart';
import 'package:nyxx/nyxx.dart';
import 'package:nyxx_lavalink/lavalink.dart';

class Player {
  late Guild guild;
  late VoiceGuildChannel voice;
  late TextChannel text;
  late Node node;
  late bool _connected = false;
  late bool _playing = false;
  late int _volume = 500;

  Player.create({
    required this.guild,
    required this.voice,
    required this.node,
    required this.text,
  }) {
    players[guild.id] = this;
  }

  bool get isConnected => _connected;

  bool get isPlaying => _playing;

  QueuedTrack get song => queue().first;

  int get volume => _volume;

  void connect() {
    node.createPlayer(guild.id);
    voice.connect(
      selfDeafen: true,
    );
    _connected = true;
    _playing = true;
  }

  void disconnect() {
    node.disconnect();
    // voice.disconnect();
  }

  Future<bool> play(String input) async {
    var results = await node.searchTracks(input);
    if (results.tracks.isNotEmpty) {
      node.play(guild.id, results.tracks[0]).queue();
    }

    return results.tracks.isNotEmpty;
  }

  List<QueuedTrack> queue() {
    return node.players[guild.id]!.queue;
  }

  void pause() {
    _playing = false;
    node.pause(guild.id);
  }

  void resume() {
    _playing = true;
    node.resume(guild.id);
  }

  void setVolume(int volume) {
    if (volume > 0 && volume < 1000) {
      _volume = volume;
      node.volume(guild.id, volume);
    }
  }
}

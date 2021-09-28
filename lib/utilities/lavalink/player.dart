import 'package:bot/contants.dart';
import 'package:nyxx/nyxx.dart';
import 'package:nyxx_lavalink/lavalink.dart';

class Player {
  late Guild guild;
  late VoiceGuildChannel voice;
  late TextChannel text;
  late Node node;
  late bool _connected = false;

  Player.create({
    required this.guild,
    required this.voice,
    required this.node,
    required this.text,
  }) {
    players[guild.id] = this;
  }

  void connect() {
    node.createPlayer(guild.id);
    voice.connect(
      selfDeafen: true,
    );
    _connected = true;
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

  bool get isConnected => _connected;
}

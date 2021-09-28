import 'package:bot/contants.dart';
import 'package:nyxx/nyxx.dart';

extension MemberAddons on Member {
  bool get isVoiceConnected => voiceState != null;

  Future<VoiceGuildChannel> get getVoiceChannel =>
      bot.fetchChannel<VoiceGuildChannel>(voiceState!.channel!.id);

  List<Role?> fetchRoles() {
    return roles.toList().map((e) => e.getFromCache()).toList();
  }

  bool hasRole(String roleName) {
    var mRoles = fetchRoles();
    return mRoles.where((element) => element!.name == roleName).isNotEmpty;
  }

  bool containsRole(dynamic roleOrRoles) {
    if (roleOrRoles is List<String>) {
      return (roleOrRoles).map((e) => hasRole(e)).contains(true);
    } else if (roleOrRoles is String) {
      return hasRole(roleOrRoles);
    }
    return false;
  }
}

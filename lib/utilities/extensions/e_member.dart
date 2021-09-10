import 'package:nyxx/nyxx.dart';

extension MemberAddons on Member {
  bool get isVoiceConnected => voiceState != null;
}

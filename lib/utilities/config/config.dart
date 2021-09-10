import 'dart:convert';

import 'package:nyxx/nyxx.dart';

class Config {
  final String token;
  final String prefix;
  final Snowflake owner;
  final int defaultDuration;

  Config({
    required this.token,
    required this.prefix,
    required this.owner,
    required this.defaultDuration,
  });

  factory Config.fromJson(String json) => Config._fromMap(jsonDecode(json));

  factory Config._fromMap(Map<String, dynamic> map) {
    return Config(
      token: map['token'],
      prefix: map['prefix'],
      owner: Snowflake(map['owner_id']),
      defaultDuration: map['default_duration_time'],
    );
  }

  Map<String, dynamic> toMap() => {
        'token': token,
        'owner_id': owner.id,
        'prefix': prefix,
        'default_duration_time': defaultDuration,
      };

  String toJson() => jsonEncode(toMap());
}

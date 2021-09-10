import 'package:bot/contants.dart';
import 'package:nyxx/nyxx.dart';

extension MessageAddons on Message {
  Future<Message> reply({MessageBuilder? builder, String? content}) async {
    builder = builder ?? MessageBuilder.content(content ?? '');
    builder.replyBuilder = ReplyBuilder.fromMessage(this);
    return channel.sendMessage(builder);
  }

  void deleteAfter({Duration? duration, String? audit}) async {
    await Future.delayed(duration ?? Duration(seconds: config.defaultDuration));
    await delete(auditReason: audit);
  }

  Future<User> getAuthorUser() async {
    return bot.fetchUser(author.id);
  }

  Guild getGuild() {
    var guild = bot.guilds.values.toList().where((element) {
      var channels =
          element.channels.where((chs) => chs.channelType == ChannelType.text);
      var chM = channels.where((ch) => ch.id == channel.id);
      return chM.isNotEmpty;
    });
    return guild.first;
  }

  Future<Member> getAuthorMember() async {
    var guild = getGuild();
    return guild.fetchMember(author.id);
  }
}

extension FutureMessageAddons on Future<Message> {
  Future<Message> reply({MessageBuilder? builder, String? content}) async {
    var msg = await this;
    builder = builder ?? MessageBuilder.content(content ?? '');
    builder.replyBuilder = ReplyBuilder.fromMessage(msg);
    return msg.channel.sendMessage(builder);
  }

  Future<void> deleteAfter({Duration? duration, String? audit}) async {
    var msg = await this;
    await Future.delayed(duration ?? Duration(seconds: config.defaultDuration));
    return msg.delete(auditReason: audit);
  }
}

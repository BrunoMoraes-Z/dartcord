String durationText(Duration duration) {
  String twoDigits(int n) {
    if (n >= 10) return '$n';
    return '0$n';
  }

  var twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
  var twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));

  var msg = duration.inHours > 0
      ? '${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds'
      : '$twoDigitMinutes:$twoDigitSeconds';

  return msg;
}

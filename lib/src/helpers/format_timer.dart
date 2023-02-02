String formatTimer(int duration) {
  // String minute = ((duration / 60) % 60).floor().toString();
  // String second = (duration % 60).floor().toString().padLeft(2, '0');
  // return '$minute:$second';

  int seconds = (duration / 1000).truncate();
  String minutes = (seconds / 60).truncate().toString().padLeft(2, '0');
  String stringifiedSecond = (seconds % 60).toString().padLeft(2, '0');
  return "$minutes:$stringifiedSecond";
}

double formatTimeline(int duration, int maxDuration) {
  return double.parse(((duration * 100) / maxDuration).toStringAsFixed(1));
}

double formatListItemLine(int duration, int maxDuration) {
  return (duration / maxDuration);
}

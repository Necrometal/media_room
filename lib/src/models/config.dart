class Config {
  Config({
    required this.random,
    required this.loop
  });

  bool random;
  bool loop;

  @override
  String toString() {
    return 'Config{loop: $loop, random: $random}';
  }
}

enum ConfigState {
  loop,
  random
}
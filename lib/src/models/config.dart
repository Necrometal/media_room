class Config {
  Config({
    required this.random,
    required this.loop
  });

  final bool random;
  final bool loop;
}

enum ConfigState {
  loop,
  random
}
part of 'player_bloc.dart';

abstract class PlayerEvent extends Equatable {
  const PlayerEvent();

  @override
  List<Object> get props => [];
}

class PlayerStarted extends PlayerEvent {
  const PlayerStarted({
    required this.duration,
    required this.current
  });
  final int duration;
  final dynamic current;
}

class PlayerPaused extends PlayerEvent {
  const PlayerPaused();
}

class PlayerResumed extends PlayerEvent {
  const PlayerResumed();
}

class PlayerReset extends PlayerEvent {
  const PlayerReset();
}

class PlayerGoTo extends PlayerEvent {
  const PlayerGoTo({ required this.duration });
  final int duration;
}

class PlayerTicked extends PlayerEvent {
  const PlayerTicked({required this.duration});
  final int duration;
}

class PlayerConfigLoop extends PlayerEvent {
  const PlayerConfigLoop({ 
    required this.loop 
  });
  final bool loop;
}

class PlayerConfigRandom extends PlayerEvent {
  const PlayerConfigRandom({ 
    required this.random 
  });
  final bool random;
}

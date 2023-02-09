part of 'player_bloc.dart';

abstract class PlayerState extends Equatable {
  const PlayerState(this.duration, this.current, this.config);

  final int duration;
  final Media? current;
  final Config config;

  @override
  List<Object?> get props => [duration, current, config];
}

class PlayerInitial extends PlayerState {
  const PlayerInitial(super.duration, super.current, super.config);

  @override
  String toString() => 'PlayerInitial { duration: $duration }';
}

class PlayerRunPause extends PlayerState {
  const PlayerRunPause(super.duration, super.current, super.config);

  @override
  String toString() => 'PlayerRunPause { duration: $duration }';
}

class PlayerRunInProgress extends PlayerState {
  const PlayerRunInProgress(super.duration, super.current, super.config);

  @override
  String toString() => 'PlayerRunInProgress { duration: $duration }';
}

// class PlayerRunComplete extends PlayerState {
//   const PlayerRunComplete() : super(0, null, config);
// }

part of 'player_bloc.dart';

abstract class PlayerState extends Equatable {
  const PlayerState(this.duration, this.current);

  final int duration;
  final Media? current;

  @override
  List<Object?> get props => [duration, current];
}

class PlayerInitial extends PlayerState {
  const PlayerInitial(super.duration, super.current);

  @override
  String toString() => 'PlayerInitial { duration: $duration }';
}

class PlayerRunPause extends PlayerState {
  const PlayerRunPause(super.duration, super.current);

  @override
  String toString() => 'PlayerRunPause { duration: $duration }';
}

class PlayerRunInProgress extends PlayerState {
  const PlayerRunInProgress(super.duration, super.current);

  @override
  String toString() => 'PlayerRunInProgress { duration: $duration }';
}

class PlayerRunComplete extends PlayerState {
  const PlayerRunComplete() : super(0, null);
}

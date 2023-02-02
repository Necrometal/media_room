part of 'player_bloc.dart';

abstract class PlayerState extends Equatable {
  const PlayerState(this.duration);

  final int duration;

  @override
  List<Object> get props => [duration];
}

class PlayerInitial extends PlayerState {
  const PlayerInitial(super.duration);

  @override
  String toString() => 'PlayerInitial { duration: $duration }';
}

class PlayerRunPause extends PlayerState {
  const PlayerRunPause(super.duration);

  @override
  String toString() => 'PlayerRunPause { duration: $duration }';
}

class PlayerRunInProgress extends PlayerState {
  const PlayerRunInProgress(super.duration);

  @override
  String toString() => 'PlayerRunInProgress { duration: $duration }';
}

class PlayerRunComplete extends PlayerState {
  const PlayerRunComplete() : super(0);
}

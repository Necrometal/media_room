import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:media_room/src/models/media.dart';
import 'package:media_room/src/streamer/ticker.dart';

part 'player_event.dart';
part 'player_state.dart';

class PlayerBloc extends Bloc<PlayerEvent, PlayerState> {
  final Ticker _ticker;
  static const int _duration = 0;

  StreamSubscription<int>? _tickerSubscription;

  PlayerBloc({
    required Ticker ticker
  }) 
  : _ticker = ticker,
  super(const PlayerInitial(_duration, null)) {
    on<PlayerStarted>(_onStarted);
    on<PlayerPaused>(_onPaused);
    on<PlayerResumed>(_onResumed);
    on<PlayerReset>(_onReset);
    on<PlayerGoTo>(_onGoTo);
    on<PlayerTicked>(_onTicked);
  }

  @override
  Future<void> close(){
    _tickerSubscription?.cancel();
    return super.close();
  }

  void _onStarted(PlayerStarted event, Emitter<PlayerState> emit){
    emit(PlayerRunInProgress(event.duration, event.current));
    _tickerSubscription?.cancel();
    _tickerSubscription = _ticker
      .tick(ticks: event.duration)
      .listen((duration) => add(PlayerTicked(duration: duration)));
  }

  void _onPaused(PlayerPaused event, Emitter<PlayerState> emit){
    if(state is PlayerRunInProgress){
      _tickerSubscription?.pause();
      emit(PlayerRunPause(state.duration, state.current));
    }
  }

  void _onResumed(PlayerResumed event, Emitter<PlayerState> emit){
    if(state is PlayerRunPause){
      _tickerSubscription?.resume();
      emit(PlayerRunInProgress(state.duration, state.current));
    }
  }

  void _onReset(PlayerReset event, Emitter<PlayerState> emit){
    _tickerSubscription?.cancel();
    emit(const PlayerInitial(_duration, null));
  }

  void _onGoTo(PlayerGoTo event, Emitter<PlayerState> emit){
    add(PlayerStarted(duration: event.duration, current: null));
  }

  void _onTicked(PlayerTicked event, Emitter<PlayerState> emit){
    emit(
      event.duration < 120
        ? PlayerRunInProgress(event.duration, state.current)
        : const PlayerRunComplete()
    );

    if(event.duration == 120) {
      add(const PlayerReset());
    }
  }
}

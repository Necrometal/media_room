import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:media_room/src/bloc/playlist_bloc.dart';
import 'package:media_room/src/models/media.dart';
import 'package:media_room/src/streamer/audioplayer.dart';

part 'player_event.dart';
part 'player_state.dart';

class PlayerBloc extends Bloc<PlayerEvent, PlayerState> {
  final Player player;
  static const int _duration = 0;

  StreamSubscription<dynamic>? playing;
  StreamSubscription<dynamic>? statePlayer;
  StreamSubscription<dynamic>? isCompleted;

  PlayerBloc({
    required this.player
  }) : 
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
    playing?.cancel();
    statePlayer?.cancel();
    isCompleted?.cancel();
    player.stop();
    return super.close();
  }

  Future<void> _onStarted(PlayerStarted event, Emitter<PlayerState> emit) async {
    emit(PlayerRunInProgress(event.duration, event.current));
    playing?.cancel();
    isCompleted?.cancel();
    await player.stop();
    player.play(event.current.path);
    playing = player.listenPlaying().listen((e){
      add(PlayerTicked(duration: e.inMilliseconds));
    });
    isCompleted = player.listenComplete().listen((e) => {});
  }

  void _onPaused(PlayerPaused event, Emitter<PlayerState> emit){
    if(state is PlayerRunInProgress){
      player.pause();
      emit(PlayerRunPause(state.duration, state.current));
    }
  }

  void _onResumed(PlayerResumed event, Emitter<PlayerState> emit){
    if(state is PlayerRunPause){
      player.resume();
      emit(PlayerRunInProgress(state.duration, state.current));
    }
  }

  void _onReset(PlayerReset event, Emitter<PlayerState> emit){
    player.stop();
    emit(const PlayerInitial(_duration, null));
  }

  void _onGoTo(PlayerGoTo event, Emitter<PlayerState> emit){
    add(PlayerStarted(duration: event.duration, current: state.current));
    player.seek(Duration(milliseconds: event.duration));
  }

  void _onTicked(PlayerTicked event, Emitter<PlayerState> emit){
    emit(PlayerRunInProgress(event.duration, state.current));
  }
}

import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:media_room/src/models/config.dart';
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
  super(PlayerInitial(
    _duration, 
    null, 
    Config(loop: false, random: false)
  )) {
    on<PlayerStarted>(_onStarted);
    on<PlayerPaused>(_onPaused);
    on<PlayerResumed>(_onResumed);
    on<PlayerReset>(_onReset);
    on<PlayerGoTo>(_onGoTo);
    on<PlayerTicked>(_onTicked);
    on<PlayerConfigLoop>(_onConfigLoopChange);
    on<PlayerConfigRandom>(_onConfigRandomChange);
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
    emit(PlayerRunInProgress(event.duration, event.current, state.config));
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
      emit(PlayerRunPause(state.duration, state.current, state.config));
    }
  }

  void _onResumed(PlayerResumed event, Emitter<PlayerState> emit){
    if(state is PlayerRunPause){
      player.resume();
      emit(PlayerRunInProgress(state.duration, state.current, state.config));
    }
  }

  void _onReset(PlayerReset event, Emitter<PlayerState> emit){
    player.stop();
    emit(PlayerInitial(_duration, null, state.config));
  }

  void _onGoTo(PlayerGoTo event, Emitter<PlayerState> emit){
    add(PlayerGoTo(duration: event.duration));
    print(event.duration);
    // player.seek(Duration(milliseconds: event.duration));
  }

  void _onTicked(PlayerTicked event, Emitter<PlayerState> emit){
    emit(PlayerRunInProgress(event.duration, state.current, state.config));
  }

  void _onConfigLoopChange(PlayerConfigLoop event, Emitter<PlayerState> emit){
    Config config = Config(
      loop: event.loop,
      random: state.config.random
    );
    emitConfigState(
      config,
      state,
      emit
    );
  }

  void _onConfigRandomChange(PlayerConfigRandom event, Emitter<PlayerState> emit){
    Config config = Config(
      random: event.random,
      loop: state.config.loop
    );
    emitConfigState(
      config,
      state,
      emit
    );
  }
}

void emitConfigState(
  Config config,
  PlayerState state,
  Emitter<PlayerState> emit
){
  if(state is PlayerInitial){
    emit(PlayerInitial(state.duration, state.current, config));
  }else if(state is PlayerRunInProgress){
    emit(PlayerRunInProgress(state.duration, state.current, config));
  }else if(state is PlayerRunPause){
    emit(PlayerRunPause(state.duration, state.current, config));
  }
}

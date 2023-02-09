part of 'playlist_bloc.dart';

class PlaylistState extends Equatable {

  final defaultState = const {
    'action': null,
    'index': null
  };

  const PlaylistState({
    this.playlist = const <Media>[],
    this.action = const {
      'action': null,
      'index': null
    }
  });

  final List<Media> playlist;
  final Map<String, dynamic> action;

  PlaylistState copyWith({
    List<Media>? playlist,
    Media? current,
    Map<String, dynamic>? action
  }){
    return PlaylistState(
      playlist: playlist ?? this.playlist,
      action: action ?? defaultState
    );
  }
  
  @override
  List<Object?> get props => [playlist, action];
}

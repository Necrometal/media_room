part of 'playlist_bloc.dart';

class PlaylistState extends Equatable {
  const PlaylistState({
    this.playlist = const <Media>[],
    this.current
  });

  final List<Media> playlist;
  final Media? current;

  PlaylistState copyWith({
    List<Media>? playlist,
    Media? current
  }){
    return PlaylistState(
      playlist: playlist ?? this.playlist,
      current: current ?? this.current,
    );
  }
  
  @override
  List<Object?> get props => [playlist, current];
}

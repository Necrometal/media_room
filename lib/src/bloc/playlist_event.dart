part of 'playlist_bloc.dart';

abstract class PlaylistEvent extends Equatable {
  const PlaylistEvent();

  @override
  List<Object> get props => [];
}

class MediaPicked extends PlaylistEvent {}
class MediaResetAction extends PlaylistEvent {}

class MediaDeleted extends PlaylistEvent {
  const MediaDeleted({
    required this.index
  });
  final int index;
}

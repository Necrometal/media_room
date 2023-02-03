import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_media_metadata/flutter_media_metadata.dart';
import 'package:media_room/src/constantes/enum.dart';
import 'package:media_room/src/models/media.dart';

part 'playlist_event.dart';
part 'playlist_state.dart';

class PlaylistBloc extends Bloc<PlaylistEvent, PlaylistState> {
  PlaylistBloc() : super(const PlaylistState()) {
    on<MediaPicked>(_onPicked);
    on<MediaDeleted>(_onDeleted);
  }

  Future<void> _onPicked(MediaPicked event, Emitter<PlaylistState> emit) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['mp3']
    );

    if(result != null){
      MediaTmp media = MediaTmp(
        name: result.files.single.name,
        path: result.files.single.path
      );
      
      final path = media.path;

      if(path != null){
        final metadata = await MetadataRetriever.fromFile(File(path));
        media.artist = metadata.albumArtistName;
        media.album = metadata.albumName;
        media.trackDuration = metadata.trackDuration;
        media.albumArt = metadata.albumArt;
      }

      return emit(state.copyWith(
        current: state.current,
        playlist: List.of(state.playlist)..add(media.copyToReal()),
        action: {
          'action': PlaylistItemAction.add,
          'index': state.playlist.length
        }
      ));
    }
  }

  Future<void> _onDeleted(MediaDeleted event, Emitter<PlaylistState> emit) async {
    final List<Media> playlist = List.of(state.playlist);
    
    final removedItem = playlist.removeAt(event.index);

    return emit(state.copyWith(
      current: state.current,
      playlist: List.of(playlist),
      action: {
        'action': PlaylistItemAction.delete,
        'index': event.index,
        'item': removedItem
      }
    ));
  }
}

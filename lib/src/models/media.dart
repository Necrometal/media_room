import 'dart:typed_data';
import 'package:equatable/equatable.dart';

class Media extends Equatable {
  const Media({
    required this.name,
    required this.path,
    this.artist,
    this.trackDuration,
    this.album,
    this.albumArt
  });

  final String name;
  final String? path;
  final String? artist;
  final int? trackDuration;
  final String? album;
  final Uint8List? albumArt;

  @override
  List<Object?> get props => [
    name, 
    path, 
    artist, 
    trackDuration, 
    album,
    albumArt
  ];
}

class MediaTmp{
  MediaTmp({
    required this.name,
    required this.path,
    this.artist,
    this.trackDuration,
    this.album,
    this.albumArt
  });

  String name;
  String? path;
  String? artist;
  int? trackDuration;
  String? album;
  Uint8List? albumArt;

  Media copyToReal(){
    return Media(
      name: name,
      path: path,
      artist: artist,
      trackDuration: trackDuration,
      album: album,
      albumArt: albumArt
    );
  }
}

import 'package:audioplayers/audioplayers.dart';
import 'package:media_room/src/models/media.dart';

class Player {
  Player() : player = AudioPlayer();

  final AudioPlayer player;

  Future<void> play(path) async => await player.play(DeviceFileSource(path));

  Future<void> pause() async => await player.pause();

  Future<void> resume() async =>  await player.resume();

  Future<void> seek(Duration time) async => await player.seek(time);

  Future<void> stop() async =>  await player.stop();

  Stream listenPlaying() => player.onPositionChanged;
  Stream listenComplete() =>  player.onPlayerComplete;
}
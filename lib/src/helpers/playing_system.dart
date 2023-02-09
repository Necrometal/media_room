import 'dart:math';

import 'package:media_room/src/models/config.dart';
import 'package:media_room/src/models/media.dart';

class PlayingSystem {
  PlayingSystem({
    required this.list
  }) : config = Config(random: false, loop: false);

  final List<Media> list;
  final List<Media> looping = [];
  final Config config;
  Media? current;
  Random random = Random();

  Media getFirstPlay(Media media){
    looping.clear();
    current = media;
    looping.add(media);
    return media;
  }

  Media getNextSong(){
    Media nextSong;
    List<Media> list;

    if(
      config.loop == true
      && this.list.length == looping.length
    ){
      list = List.from(looping);
    }else{
      list = List.from(this.list);
    }

    if(current == null){
      int i;
      if(config.random == false){
        i = 0;
      }else{
        i = random.nextInt(list.length);
      }

      current = list[i];
      nextSong = list[i];

      if(!looping.contains(current)){
        looping.add(current as Media);
      }
    }else{
      int i;
      if(config.random == false){
        i = list.last == current
          ? 0
          : list.indexOf(current as Media) + 1;
      }else{
        Media tmp;
        if(looping.length < list.length){
          List<Media> medias = List.from(this.list);
          medias.removeWhere((element) => looping.contains(element));
          int t = random.nextInt(medias.length);
          tmp = medias[t];
        }else{
          int t = list.last == current
            ? 0
            : list.indexOf(current as Media) + 1;
          tmp = list[t];
        }
        i = list.indexOf(tmp);
      }

      current = list[i];
      nextSong = list[i];

      if(!looping.contains(current)){
        looping.add(current as Media);
      }
    }

    return nextSong;
  }

  Media getPreviousSong(){
    Media prevSong;

    if(current == null){
      if(config.random == false){
        current = list[0];
        prevSong = list[0];
      }else{
        int i = random.nextInt(list.length);
        current = list[i];
        prevSong = list[i];
      }

      looping.add(current as Media);
    }else{
      if(config.random == false){
        looping.clear();
        int i = list[0] == current
          ? list.length - 1
          : list.indexOf(current as Media) - 1;
        current = list[i];
        prevSong = list[i];
        looping.add(current as Media);
      }else{
        if(looping.length == 1){
          List<Media> medias = List.from(list);
          medias.removeWhere((element) => element == current);
          int i = random.nextInt(medias.length);
          looping.clear();
          current = medias[i];
          prevSong = medias[i];
          looping.add(current as Media);
        }else{
          int i = looping.length - 2;
          current = looping[i];
          prevSong = looping[i];
          looping.removeLast();
        }
      }
    }

    return prevSong;
  }

  void addNewSong(Media media){
    list.add(media);
  }

  void removeSong(Media media){
    list.remove(media);
  }

  void updateConfig(Config config){
    this.config.loop = config.loop;
    this.config.random = config.random;
  }
}

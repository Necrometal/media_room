import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:media_room/src/bloc/player_bloc.dart';
import 'package:media_room/src/bloc/playlist_bloc.dart';
import 'package:media_room/src/constantes/colors.dart';
import 'package:media_room/src/custom/slider_track.dart';
import 'package:media_room/src/helpers/checker.dart';
import 'package:media_room/src/helpers/format_timer.dart';
import 'package:media_room/src/models/config.dart';
import 'package:media_room/src/models/media.dart';
import 'package:media_room/src/widgets/back_button.dart';
import 'package:media_room/src/widgets/page_container.dart';

class MediaPlayerPage extends StatefulWidget {
  const MediaPlayerPage({Key? key}) : super(key: key);

  @override
  State<MediaPlayerPage> createState() => _MediaPlayerPageState();
}

class _MediaPlayerPageState extends State<MediaPlayerPage> {
  bool liked = false;
  static int defaultDuration = 0;
  late bool disabled;

  void _like() {
    setState(() {
      liked = !liked;
    });
  }

  void handlePlay(BuildContext ctx, int duration, dynamic current){
    ctx.read<PlayerBloc>().add(PlayerStarted(
      duration: duration,
      current: current
    ));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PlaylistBloc, PlaylistState>(
      buildWhen: (prev, state) => prev.runtimeType != state.runtimeType,
      builder: (context, playlistState) {
        return BlocBuilder<PlayerBloc, PlayerState>(
          buildWhen: (prev, state) => prev.runtimeType != state.runtimeType,
          builder: (context, state) {
            final listMedia = context.select((PlaylistBloc bloc) => bloc.state.playlist);
            final current = context.select((PlayerBloc bloc) => bloc.state.current);
            final time = context.select((PlayerBloc bloc) => bloc.state.duration);
            final isCompleted = context.select((PlayerBloc bloc) => bloc.isCompleted);
            final config = context.select((PlayerBloc bloc) => bloc.state.config);
            final playingState = context.select((PlayerBloc bloc) => bloc.state);
            final playingSystem = context.select((PlaylistBloc bloc) => bloc.playingSystem);
            final duration = formatTimer(time);
            final maxDuration = formatTimer(current?.trackDuration ?? defaultDuration);
            final timelines = formatTimeline(time, current?.trackDuration ?? defaultDuration);
            final maxTimelines = double.parse((current?.trackDuration ?? defaultDuration).toStringAsFixed(1));
            final divisions = current?.trackDuration;
            disabled = listMedia.isNotEmpty ? false : true;

            // handle press play/pause button
            void _play(){
              if(playingState is PlayerInitial){
                if(listMedia.isNotEmpty){
                  // Media media = listMedia[0];
                  Media media = playingSystem.getNextSong();
                  handlePlay(context, 0, media);
                }
              }else if(playingState is PlayerRunPause){
                context.read<PlayerBloc>().add(const PlayerResumed());
              }else if(playingState is PlayerRunInProgress){
                context.read<PlayerBloc>().add(const PlayerPaused());
              }
            }

            // handle press next button
            void _next(){
              // final item = getNextItem(listMedia, current, config.random);
              // if(item != null) handlePlay(context, 0, item);
              if(listMedia.isNotEmpty){
                final item = playingSystem.getNextSong();
                handlePlay(context, 0, item);
              }
            }

            // handle press previous button
            void _previous(){
              // final item = getPreviousItem(listMedia, current, config.random);
              // if(item != null) handlePlay(context, 0, item);
              if(listMedia.isNotEmpty){
                final item = playingSystem.getPreviousSong();
                handlePlay(context, 0, item);
              }
            }

            // handle press config button
            void _toggleConfig(ConfigState type){
              switch(type){
                case ConfigState.loop:
                  context.read<PlayerBloc>().add(
                    PlayerConfigLoop(loop: !config.loop)
                  );
                  playingSystem.updateConfig(Config(
                    loop: !config.loop,
                    random: config.random
                  ));
                  break;
                case ConfigState.random:
                  context.read<PlayerBloc>().add(
                    PlayerConfigRandom(random: !config.random)
                  );
                  playingSystem.updateConfig(Config(
                    loop: config.loop,
                    random: !config.random
                  ));
                  break;
              }
            }
            
            // handle timeline changing
            void _timelineChanging(double value) {
              if(current != null){
                context.read<PlayerBloc>().add(
                  PlayerGoTo(duration: value.round())
                );
              }
            }

            // listen if playing is completed
            isCompleted?.onData((e){
              if(listMedia.last == current){
                if(config.loop == false){
                  context.read<PlayerBloc>().add(const PlayerReset());
                }else{
                  _next();
                }
              }else{
                handlePlay(
                  context, 
                  0, 
                  playlistState.playlist[playlistState.playlist.indexOf(current as Media) + 1]
                );
              }
            });

            return PageContainer(
              child: Scaffold(
                backgroundColor: Colors.transparent,
                appBar: AppBar(
                  title: Container(
                    color: Colors.transparent,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const <Widget>[
                        CustomBackButton(),
                        Expanded(
                          flex: 1,
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              'Player',
                              style: TextStyle(color: grey, fontSize: 15),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  backgroundColor: const Color.fromARGB(0, 0, 0, 0),
                  shadowColor: const Color.fromARGB(0, 0, 0, 0),
                  elevation: 0,
                ),
                body: BodyPageContainer(
                  child: Column(
                    children: <Widget>[
                      ClipRRect(
                        borderRadius: BorderRadius.circular(30),
                        child: Image(
                          image: imagePlayer(current, 'lib/src/assets/images/music-2.jpg'),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              titleName(current),
                              style: const TextStyle(fontSize: 25, color: Colors.white)
                            ),
                            IconButton(
                              icon: Icon(
                                // CupertinoIcons.heart,
                                liked
                                    ? CupertinoIcons.heart_fill
                                    : CupertinoIcons.heart,
                                size: 25,
                                color: liked ? Colors.cyan : Colors.white,
                              ),
                              onPressed: _like,
                            )
                          ],
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          artisteName(current), 
                          style: const TextStyle(color: grey)
                        ),
                      ),
                      Expanded(
                        child: Align(
                          alignment: Alignment.center,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                margin: const EdgeInsets.only(top: 15),
                                child: SliderTheme(
                                  data: SliderTheme.of(context).copyWith(
                                    trackHeight: 1.0,
                                    trackShape: CustomTrackShape(),
                                    activeTrackColor: cyan,
                                    inactiveTrackColor: grey,
                                    thumbShape: const CircleThumbShape(
                                      thumbRadius: 4,
                                    ),
                                    thumbColor: cyan,
                        
                                    // overlayColor: Colors.pink.withOpacity(0.2),
                                    overlayShape: const RoundSliderOverlayShape(overlayRadius: 15.0),
                                  ),
                                  child: Slider(
                                    // if timeline default has value use it for reference ui
                                    // else use the playing timeline value
                                    value: timelines, 
                                    max: maxTimelines,
                                    divisions: divisions,
                                    onChanged: _timelineChanging
                                  ),
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(duration, style: const TextStyle(color: grey, fontSize: 10)),
                                  Text(maxDuration, style: const TextStyle(color: grey, fontSize: 10))
                                ],
                              )
                            ],
                          ),
                        )
                      ),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            IconButton(
                              icon: Icon(
                                Icons.shuffle,
                                size: 20,
                                color: config.random == true ? cyan : grey,
                              ),
                              tooltip: '',
                              onPressed: () {
                                _toggleConfig(ConfigState.random);
                              },
                            ),
                            IconButton(
                              icon: const Icon(
                                // CupertinoIcons.heart,
                                CupertinoIcons.backward_fill,
                                size: 20,
                                color: Colors.white,
                              ),
                              tooltip: '',
                              onPressed: disabled ? null :  _previous,
                            ),
                            Container(
                              height: (MediaQuery.of(context).size.width) / 5,
                              width: (MediaQuery.of(context).size.width) / 5,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                gradient: LinearGradient(
                                  begin: Alignment.centerLeft,
                                  end: Alignment.centerRight,
                                  colors: [
                                    cyan,
                                    Color.fromARGB(255, 95, 233, 251)
                                  ]
                                ),
                              ),
                              child: IconButton(
                                icon: Icon(
                                  (state is PlayerInitial || state is PlayerRunPause)
                                    ? CupertinoIcons.play_fill 
                                    : CupertinoIcons.pause_fill,
                                  size: 25,
                                  color: Colors.black,
                                ),
                                tooltip: '',
                                onPressed: disabled ? null :  _play,
                              ),
                            ),
                            IconButton(
                              icon: const Icon(
                                // CupertinoIcons.heart,
                                CupertinoIcons.forward_fill,
                                size: 20,
                                color: Colors.white,
                              ),
                              tooltip: '',
                              onPressed: disabled ? null : _next,
                            ),
                            IconButton(
                              icon: Icon(
                                // CupertinoIcons.heart,
                                Icons.sync_sharp,
                                size: 20,
                                color: config.loop == true ? cyan : grey,
                              ),
                              tooltip: '',
                              onPressed: (){
                                _toggleConfig(ConfigState.loop);
                              },
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          }
        );
      },
    );
  }
}
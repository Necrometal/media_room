import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:media_room/src/bloc/player_bloc.dart';
import 'package:media_room/src/bloc/playlist_bloc.dart';
import 'package:media_room/src/constantes/colors.dart';
import 'package:media_room/src/custom/slider_track.dart';
import 'package:media_room/src/helpers/format_timer.dart';
import 'package:media_room/src/widgets/back_button.dart';
import 'package:media_room/src/widgets/page_container.dart';

class MediaPlayerPage extends StatefulWidget {
  const MediaPlayerPage({Key? key}) : super(key: key);

  @override
  State<MediaPlayerPage> createState() => _MediaPlayerPageState();
}

class _MediaPlayerPageState extends State<MediaPlayerPage> {
  bool liked = false;
  double timeline = 0.0;
  bool played = false;

  void _like() {
    setState(() {
      liked = !liked;
    });
  }

  void _timelineChanged(double value) {
    setState(() {
      timeline = value;
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PlaylistBloc, PlaylistState>(
      buildWhen: (prev, state) => prev.runtimeType != state.runtimeType,
      builder: (context, playlistState) {
        return BlocBuilder<PlayerBloc, PlayerState>(
          buildWhen: (prev, state) => prev.runtimeType != state.runtimeType,
          builder: (context, state) {
            final time = context.select((PlayerBloc bloc) => bloc.state.duration);
            final duration = formatTimer(time * 1000);
            final maxDuration = formatTimer(120 * 1000);
            final timelines = formatTimeline(time, 120);

            void _play(){
              if(state is PlayerInitial){
                if(state.current == null && playlistState.playlist.isNotEmpty){
                  context.read<PlayerBloc>().add(PlayerStarted(
                    duration: state.duration,
                    current: playlistState.playlist[0]
                  ));
                }
              }else if(state is PlayerRunPause){
                context.read<PlayerBloc>().add(const PlayerResumed());
              }else if(state is PlayerRunInProgress){
                context.read<PlayerBloc>().add(const PlayerPaused());
              }
            }

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
                        child: const Image(
                          image: AssetImage('lib/src/assets/images/music-2.jpg'),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            const Text('Space Station',
                                style: TextStyle(fontSize: 25, color: Colors.white)),
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
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Text('House', style: TextStyle(color: grey)),
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
                                    value: timelines,
                                    max: 100,
                                    divisions: 100,
                                    onChanged: _timelineChanged
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
                              icon: const Icon(
                                // CupertinoIcons.heart,
                                Icons.shuffle,
                                size: 20,
                                color: grey,
                              ),
                              tooltip: '',
                              onPressed: () {},
                            ),
                            IconButton(
                              icon: const Icon(
                                // CupertinoIcons.heart,
                                CupertinoIcons.backward_fill,
                                size: 20,
                                color: Colors.white,
                              ),
                              tooltip: '',
                              onPressed: () {},
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
                                onPressed: _play,
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
                              onPressed: () {},
                            ),
                            IconButton(
                              icon: const Icon(
                                // CupertinoIcons.heart,
                                Icons.sync_sharp,
                                size: 20,
                                color: grey,
                              ),
                              tooltip: '',
                              onPressed: () {},
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
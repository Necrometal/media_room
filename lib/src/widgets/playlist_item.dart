import 'dart:typed_data';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:media_room/src/bloc/player_bloc.dart';
import 'package:media_room/src/bloc/playlist_bloc.dart';
import 'package:media_room/src/constantes/colors.dart';
import 'package:media_room/src/constantes/enum.dart';
import 'package:media_room/src/constantes/text.dart';
import 'package:media_room/src/helpers/format_timer.dart';
import 'package:media_room/src/models/media.dart';

class PlaylistItem extends StatelessWidget {
  const PlaylistItem({
    Key? key,
    required this.item,
    required this.index
  }) : super(key: key);

  final Media item;
  final int index;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PlaylistBloc, PlaylistState>(
      buildWhen: (prev, state) => prev.runtimeType != state.runtimeType,
      builder: (context, playlistState){
        return BlocBuilder<PlayerBloc, PlayerState>(
          buildWhen: (prev, state) => prev.runtimeType != state.runtimeType,
          builder: (context, playerState){
            final time = context.select((PlayerBloc bloc) => bloc.state.duration);
            final timelines = formatListItemLine(time, 120);
            final maxDuration = formatTimer(item.trackDuration ?? 0);


            void _deleteFile(int i) async {
              context.read<PlaylistBloc>().add(MediaDeleted(index: i));
            }

            return Card(
              color: cyantranparent,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 5
                ),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: Stack(
                        alignment: Alignment.center,
                        children: <Widget>[
                          SizedBox(
                            width: 50,
                            height: 50,
                            child: CircleAvatar(
                              backgroundColor: Colors.red,
                              radius: 25,
                              backgroundImage: item.albumArt != null
                                ? MemoryImage(item.albumArt as Uint8List) as ImageProvider
                                : const AssetImage('lib/src/assets/images/music.jpg')
                            ),
                          ),
                          SizedBox(
                            width: 50,
                            height: 50,
                            child: CircularProgressIndicator(
                              value: timelines,
                              color: Colors.pink,
                              strokeWidth: 3.5,
                            ),
                          ),
                        ],
                      )
                    ),
                    Expanded(
                      flex: 3,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                item.name,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 14
                                )
                              ),
                              Text(
                                item.artist ?? unknown,
                                style: const TextStyle(
                                  color: greyViolet,
                                  fontSize: 13,
                                )
                              )
                            ],
                          ),
                          Text(
                            maxDuration,
                            style: const TextStyle(
                              color: greyViolet,
                              fontSize: 12
                            )
                          ),
                        ],
                      )
                    ),
                    Expanded(
                      flex: 1,
                      child: Row(
                        children: <Widget>[
                          SizedBox(
                            width: 25,
                            child: IconButton(
                              splashRadius: 15,
                              icon: const Icon(
                                CupertinoIcons.play,
                                size: 17,
                                color: Colors.white,
                              ),
                              onPressed: (){},
                            ),
                          ),
                          SizedBox(
                            width: 25,
                            child: PopupMenuButton(
                              onSelected: (item){
                                switch(item){
                                  case PlaylistItemAction.delete: 
                                    _deleteFile(index);
                                    break;
                                  default: 
                                    print('autre');
                                    break;
                                }
                              },
                              itemBuilder: (BuildContext context) => <PopupMenuEntry>[
                                const PopupMenuItem(
                                  value: PlaylistItemAction.delete,
                                  child: Text('Delete music'),
                                ),
                              ],
                              icon: const Icon(
                                Icons.more_vert_outlined,
                                size: 20,
                                color: Colors.white
                              ),
                            )
                          )
                        ]
                      )
                    )
                  ]
                )
              )
            );
          }
        );
      }
    );
  }
}


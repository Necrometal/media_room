import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:media_room/src/bloc/player_bloc.dart';
import 'package:media_room/src/bloc/playlist_bloc.dart';
import 'package:media_room/src/constantes/colors.dart';
import 'package:media_room/src/widgets/page_container.dart';
import 'package:media_room/src/widgets/playlist_item.dart';

class MediaPlaylistPage extends StatefulWidget {
  const MediaPlaylistPage({Key? key}) : super(key: key);

  @override
  State<MediaPlaylistPage> createState() => _MediaPlaylistPageState();
}

class _MediaPlaylistPageState extends State<MediaPlaylistPage> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PlaylistBloc, PlaylistState>(
      buildWhen: (prev, state) => prev.runtimeType != state.runtimeType,
      builder: (context, playlistState) {
        void _addFile() async {
          context.read<PlaylistBloc>().add(MediaPicked());
        }

        final list = context.select((PlaylistBloc bloc) => bloc.state.playlist);

        return PageContainer(
          child: Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              backgroundColor: const Color.fromARGB(0, 0, 0, 0),
              shadowColor: const Color.fromARGB(0, 0, 0, 0),
              elevation: 0,
              toolbarHeight: 200,
              flexibleSpace: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    colorFilter: ColorFilter.mode(
                      Colors.black.withOpacity(0.2), 
                      BlendMode.dstATop
                    ),
                    image: const AssetImage('lib/src/assets/images/music-6.jpg'),
                  )
                ),
                height: (MediaQuery.of(context).size.height),
                child: Column(children: <Widget>[
                  const Expanded(
                    flex: 1,
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        'Playlist',
                        style: TextStyle(color: Colors.white)
                      )
                    )
                  ),
                  Expanded(
                    flex: 1,
                    child: Align(
                      alignment: Alignment.center,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: const <Widget>[
                            Text(
                              'Title',
                              style: TextStyle(color: Colors.white, fontSize: 30)
                            ),
                            Text(
                              'Artist',
                              style: TextStyle(color: grey)
                            )
                          ]
                        ),
                      )
                    )
                  ),
                ])
              ),
            ),
            body: BodyPageContainer(
              child: Stack(
                children: <Widget>[
                  ListView.builder(
                    itemCount: list.length,
                    itemBuilder: (context, index) {
                      final item = list[index];
                      return PlaylistItem(item: item, index: index);
                    },
                  ),
                  Stack(
                    alignment: Alignment.bottomCenter,
                    children: <Widget>[
                      IgnorePointer(
                        child: Container(
                          height: MediaQuery.of(context).size.height,
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Colors.transparent,
                                Colors.transparent,
                                Colors.transparent,
                                Color.fromARGB(91, 0, 0, 0),
                                Colors.black
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  )
                ]
              )
            ),
            floatingActionButton: FloatingActionButton.small(
              onPressed: _addFile,
              backgroundColor: cyan,
              tooltip: 'Add music',
              child: const Icon(Icons.add)
            ),
            floatingActionButtonLocation: FloatingActionButtonLocation.miniCenterDocked,
          )
        );
      }
    );
  }
}

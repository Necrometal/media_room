import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:media_room/src/bloc/player_bloc.dart';
import 'package:media_room/src/bloc/playlist_bloc.dart';
import 'package:media_room/src/constantes/colors.dart';
import 'package:media_room/src/constantes/enum.dart';
import 'package:media_room/src/models/media.dart';
import 'package:media_room/src/widgets/page_container.dart';
import 'package:media_room/src/widgets/playlist_item.dart';

class MediaPlaylistPage extends StatefulWidget {
  const MediaPlaylistPage({Key? key}) : super(key: key);

  @override
  State<MediaPlaylistPage> createState() => _MediaPlaylistPageState();
}

class _MediaPlaylistPageState extends State<MediaPlaylistPage> {

  final GlobalKey<AnimatedListState> mediaKey = GlobalKey<AnimatedListState>();
  late List<Media> listMedia;
  late List<Media> previousList = [];
  late Map<String, dynamic> action;

  void animateItem(
    Map<String, dynamic> action,
    List<Media> listMedia
  ){
    switch(action['action']){
      case PlaylistItemAction.add:
        mediaKey.currentState!.insertItem(action['index']);
        break;
      case PlaylistItemAction.delete:
        mediaKey.currentState!.removeItem(
          action['index'],
          (BuildContext ctxAnimate, Animation<double> animation) => buildItem(
            action['item'],
            action['index'],
            animation,
            () => {}
          )
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PlaylistBloc, PlaylistState>(
      buildWhen: (prev, state) => prev.runtimeType != state.runtimeType,
      builder: (context, playlistState) {
        void _addFile() {
          context.read<PlaylistBloc>().add(MediaPicked());
        }

        void _deleteFile(int i) async {
          context.read<PlaylistBloc>().add(MediaDeleted(index: i));
        }

        listMedia = context.select((PlaylistBloc bloc) => bloc.state.playlist);
        action = context.select((PlaylistBloc bloc) => bloc.state.action);

        animateItem(action, listMedia);

        return PageContainer(
          child: Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              backgroundColor: const Color.fromARGB(0, 0, 0, 0),
              shadowColor: const Color.fromARGB(0, 0, 0, 0),
              elevation: 0,
              toolbarHeight: 200,
              flexibleSpace: const AppBarPlaylist(),
            ),
            body: BodyPageContainer(
              child: Stack(
                children: <Widget>[
                  // ListView.builder(
                  //   itemCount: list.length,
                  //   itemBuilder: (context, index) {
                  //     final item = list[index];
                  //     return PlaylistItem(item: item, index: index);
                  //   },
                  // ),
                  AnimatedList(
                    key: mediaKey,
                    initialItemCount: listMedia.length,
                    itemBuilder: (ctxAnimation, index, animation) => buildItem(
                      listMedia[index],
                      index,
                      animation,
                      _deleteFile
                    ),
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

class AppBarPlaylist extends StatelessWidget {
  const AppBarPlaylist({
    Key? key
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
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
    );
  }
}

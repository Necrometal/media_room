import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:media_room/src/constantes/colors.dart';
import 'package:media_room/src/constantes/playlists.dart';
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
    return PageContainer(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          // title: Container(
          //   color: Colors.transparent,
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //     children: <Widget>[
          //       const Expanded(
          //         child: Align(
          //           alignment: Alignment.center,
          //           child: Text(
          //             'Playlist',
          //             style: TextStyle(color: grey, fontSize: 15),
          //           ),
          //         ),
          //       ),
          //       IconButton(
          //         splashRadius: 15,
          //         icon: const Icon(
          //           CupertinoIcons.add,
          //           size: 25,
          //           color: Colors.white,
          //         ),
          //         onPressed: (){},
          //         tooltip: 'Add new music to playlist',
          //       )
          //     ],
          //   ),
          // ),
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
                // fit: BoxFit.fill
              )
            ),
            height: (MediaQuery.of(context).size.height),
            child: Column(
              children: <Widget>[
                const Expanded(
                  flex: 1,
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      'Playlist',
                      style: TextStyle(
                        color: Colors.white
                      )
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
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 30
                            )
                          ),
                          Text(
                            'Artist',
                            style: TextStyle(
                              color: grey
                            )
                          )
                        ]
                      ),
                    )
                  )
                ),
              ]
            )
          ),
        ),
        body: BodyPageContainer(
          child: Stack(
            children: <Widget>[
              ListView.builder(
                itemCount: playlists.length,
                itemBuilder: (context, index) {
                  final item = playlists[index];
                  return PlaylistItem(item: item);
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
          onPressed: () {
            // Add your onPressed code here!
          },
          backgroundColor: cyan,
          tooltip: 'Add music',
          child: const Icon(Icons.add)
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.miniCenterDocked,
      )
    );
  }
}

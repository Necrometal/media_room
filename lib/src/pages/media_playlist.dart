import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:media_room/src/constantes/colors.dart';
import 'package:media_room/src/constantes/playlists.dart';
import 'package:media_room/src/widgets/back_button.dart';
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
          title: Container(
            color: Colors.transparent,
            child: const Align(
              alignment: Alignment.center,
              child: Text(
                'Playlist',
                style: TextStyle(
                  color: grey, 
                  fontSize: 15,
                ),
              )
            )
            // child: Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   children: const <Widget>[
            //     // CustomBackButton(),
            //     Expanded(
            //       child: Align(
            //         alignment: Alignment.center,
            //         child: Text(
            //           'Playlist',
            //           style: TextStyle(
            //             color: grey, 
            //             fontSize: 15,
            //           ),
            //         )
            //       )
            //     ),
            //     Icon(
            //       CupertinoIcons.search,
            //       color: grey,
            //       size: 25,
            //     ),
            //   ],
            // ),
          ),
          backgroundColor: const Color.fromARGB(0, 0, 0, 0),
          shadowColor: const Color.fromARGB(0, 0, 0, 0),
          elevation: 0,
        ),
        body: BodyPageContainer(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: ListView.builder(
                  itemCount: playlists.length,
                  itemBuilder: (context, index) {
                    final item = playlists[index];
                    return PlaylistItem(item: item);
                  },
                )
              )
            ]
          )
        )
      )
    );
  }
}

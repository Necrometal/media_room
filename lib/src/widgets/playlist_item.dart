import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:media_room/src/constantes/colors.dart';
import 'package:media_room/src/constantes/enum.dart';

class PlaylistItem extends StatelessWidget {
  const PlaylistItem({
    Key? key,
    required this.item
  }) : super(key: key);

  final Map item;

  @override
  Widget build(BuildContext context) {
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
                children: const <Widget>[
                  SizedBox(
                    width: 50,
                    height: 50,
                    child: CircleAvatar(
                      backgroundColor: Colors.red,
                      radius: 25,
                      backgroundImage: AssetImage('lib/src/assets/images/music.jpg'),
                    ),
                  ),
                  SizedBox(
                    width: 50,
                    height: 50,
                    child: CircularProgressIndicator(
                      value: 0.45,
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
                        item['title'],
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14
                        )
                      ),
                      Text(
                        item['artist'],
                        style: const TextStyle(
                          color: greyViolet,
                          fontSize: 13,
                        )
                      )
                    ],
                  ),
                  Text(
                    item['time'],
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
                        // action 
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
}


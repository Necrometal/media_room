import 'package:flutter/material.dart';
import 'package:media_room/src/constantes/colors.dart';
import 'package:media_room/src/constantes/enum.dart';
import 'package:media_room/src/constantes/font.dart';
import 'package:media_room/src/widgets/tooltips.dart';

class MemberListItem extends StatelessWidget {
  const MemberListItem({
    Key? key,
    required this.item
  }) : super(key: key);

  final Map item;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shadowColor: cyan,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15)
      ),
      child: Container(
        decoration: BoxDecoration(
          image: const DecorationImage(
            image: AssetImage('lib/src/assets/images/third-wall.jpg'),
            fit: BoxFit.cover
          ),
          borderRadius: BorderRadius.circular(15)
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: double.infinity,
              height: 30,
              decoration: const BoxDecoration(
                color: Color.fromARGB(89, 162, 165, 162),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15),
                  topRight: Radius.circular(15)
                ),
              ),
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  item['name'],
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Colors.white,
                    fontFamily: handlee
                  )
                ),
              )
            ),
            Container(
              width: double.infinity,
              height: 40,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(15),
                  bottomRight: Radius.circular(15)
                ),
              ),
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      item['role'],
                      style: const TextStyle(
                        color: Colors.white,
                      )
                    ),
                    PopupMenuButton(
                      shape: const TooltipShape(),
                      onSelected: (item){
                        // action 
                      },
                      itemBuilder: (BuildContext context) => <PopupMenuEntry>[
                        const PopupMenuItem(
                          value: MemberlistItemAction.setadmin,
                          child: Text('Set as admin'),
                        ),
                        const PopupMenuItem(
                          value: MemberlistItemAction.delete,
                          child: Text('Delete member'),
                        ),
                      ],
                      icon: const Icon(
                        Icons.settings,
                        size: 20,
                        color: Colors.white
                      ),
                    )
                  ]
                ),
              )
            )
          ],
        )
      ),
      
    );
  }
}
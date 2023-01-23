import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:media_room/src/constantes/colors.dart';
import 'package:media_room/src/constantes/member.dart';
import 'package:media_room/src/widgets/back_button.dart';
import 'package:media_room/src/widgets/member_list_item.dart';
import 'package:media_room/src/widgets/page_container.dart';

class MemberList extends StatefulWidget {
  const MemberList({Key? key}) : super(key: key);

  @override
  State<MemberList> createState() => _MemberListState();
}

class _MemberListState extends State<MemberList> {
  @override
  Widget build(BuildContext context) {
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
                Text(
                  'List member',
                  style: TextStyle(color: grey, fontSize: 15),
                ),
                Icon(
                  CupertinoIcons.search,
                  color: grey,
                  size: 25,
                ),
              ],
            ),
          ),
          backgroundColor: const Color.fromARGB(0, 0, 0, 0),
          shadowColor: const Color.fromARGB(0, 0, 0, 0),
          elevation: 0,
        ),
        body: BodyPageContainer(
          child: GridView.count(
            crossAxisCount: 2,
            mainAxisSpacing: 10,
            crossAxisSpacing: 1,
            children: memberlists.map((item){
              return MemberListItem(item: item);
            }).toList(),
          )
        )
      )
    );
  }
}
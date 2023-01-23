import 'package:flutter/material.dart';
import 'package:media_room/src/constantes/colors.dart';
import 'package:media_room/src/constantes/font.dart';
import 'package:media_room/src/widgets/page_container.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  Widget build(BuildContext context) {
    return PageContainer(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: BodyPageContainer(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.symmetric(
                    vertical: 50,
                    horizontal: 15
                  ),
                  child: Column(
                    children: const <Widget>[
                      Text(
                        'MEDIA ROOM',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontFamily: handlee,
                          fontWeight: FontWeight.w700
                        )
                      ),
                      Text(
                        'share and enjoy music with friends',
                        style: TextStyle(
                          color: grey
                        )
                      )
                    ]
                  )
                ),
                CircleAvatar(
                  backgroundImage: const AssetImage('lib/src/assets/images/music.jpg'),
                  radius: MediaQuery.of(context).size.width / 3,
                ),
                Container(
                  margin: const EdgeInsets.symmetric(
                    vertical: 50,
                    horizontal: 15
                  ),
                  width: MediaQuery.of(context).size.width / 2,
                  height: 50,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        cyan,
                        Color.fromARGB(255, 95, 251, 186)
                      ]
                    ),
                    borderRadius: BorderRadius.circular(35)
                  ),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.transparent, // background
                      onPrimary: Colors.transparent, 
                      shadowColor: Colors.transparent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(35)
                      )// foreground
                    ),
                    onPressed: () { },
                    child: const Text(
                      'Get started',
                      style: TextStyle(
                        color: Colors.white
                      )
                    ),
                  ),
                )
              ]
            )
          )
        )
      )
    );
  }
}
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:media_room/src/constantes/colors.dart';

class CustomBackButton extends StatelessWidget {
  const CustomBackButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      splashRadius: 25,
      onPressed: (){},
      icon: const Icon(
        CupertinoIcons.chevron_left,
        color: grey,
        size: 25,
      ),
    );
  }
}
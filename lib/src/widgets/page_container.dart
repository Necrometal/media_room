import 'package:flutter/material.dart';

class PageContainer extends StatelessWidget {
  const PageContainer({
    Key? key, 
    required this.child
  }) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('lib/src/assets/images/second-wall.jpg'),
          fit: BoxFit.cover
        )
      ),
      child: Padding(
        padding: const EdgeInsets.only(bottom: 60),
        child: child
      )
    );
  }
}

class BodyPageContainer extends StatelessWidget {
  const BodyPageContainer({
    Key? key,
    required this.child
  }) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 15),
      decoration: const BoxDecoration(color: Colors.transparent),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: child
      )
    );
  }
}

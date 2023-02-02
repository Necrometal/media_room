import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:media_room/src/observer/playlist_observer.dart';
import 'package:media_room/src/widgets/bottom_navigation_bar.dart';

void main() {
  Bloc.observer = PlaylistObserver();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MediaNavigationBar(),
    );
  }
}

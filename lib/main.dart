import 'package:flutter/material.dart';
import 'package:youtube_downloader_flutter/screens/video_player_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Youtube Video Downloader',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const VideoPlayerScreen(),
    );
  }
}

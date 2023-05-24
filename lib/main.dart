import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  
  late FlickManager flickManager;



  List<String> videoUrls = [
    'http://localhost:8090/uploads/190301_1_25_12/190301_1_25_12.mp4',
    'http://localhost:8090/uploads/190301_1_25_11/190301_1_25_11.mp4',
  ];
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    
    flickManager = FlickManager(
        videoPlayerController: VideoPlayerController.network(videoUrls[0]));

    flickManager.flickVideoManager!.addListener(() {
      if(flickManager.flickVideoManager!.isVideoEnded){
        int currentIndex = videoUrls.indexOf(flickManager.flickVideoManager!.videoPlayerController!.dataSource);
        int nextIndex = currentIndex +1;

        if(nextIndex < videoUrls.length){
          flickManager.handleChangeVideo(VideoPlayerController.network(videoUrls[nextIndex]));
        }
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    flickManager.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(

        child: Container(
          child: FlickVideoPlayer(
            flickManager: flickManager,
          ),
        ),
      ),// This trailing comma makes auto-formatting nicer for build methods.
    );
  }

}

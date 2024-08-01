import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart'; // Eklenen kütüphane

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  ImagePicker? imagePicker;
  File? videoFile;
  VideoPlayerController? controller;

  @override
  void initState() {
    super.initState();
    imagePicker = ImagePicker();
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Video Player Uygulaması"),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: buildPickVideo(),
          ),
        ],
      ),
      body: controller != null ? GestureDetector(
        onTap: (){
          if(controller!.value.isPlaying){
            controller!.pause();
          }else{
            controller!.play();
          }


        },
        child: AspectRatio(aspectRatio: controller!.value.aspectRatio,
          child: VideoPlayer(controller!),),
      )
      : Container(),
    );
  }

  IconButton buildPickVideo() {
    return IconButton(
            onPressed: () async {
              var video = await imagePicker!.pickVideo(source: ImageSource.gallery);
              if (video != null) {
                videoFile = File(video.path);
                controller = VideoPlayerController.file(videoFile!)
                  ..initialize()
                  ..addListener( () {})
                  ..play()
                  ..setLooping(true);
                setState(() {

                });
              }
            },
            icon: const Icon(Icons.add_circle),
          );
  }
}

import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

import '../tools.dart';

class TaranaPlayingScreen extends StatefulWidget {
  final String song;
  final String image;
  final String name;
  final String artist;

  const TaranaPlayingScreen(
      {Key? key,
      required this.song,
      required this.image,
      required this.name,
      required this.artist})
      : super(key: key);

  @override
  _TaranaPlayingScreenState createState() => _TaranaPlayingScreenState();
}

var audio = AudioPlayer();

class _TaranaPlayingScreenState extends State<TaranaPlayingScreen> {
  bool playing = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: appblackColor,
          title: Text(appName),
        ),
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(
                  "https://w0.peakpx.com/wallpaper/659/210/HD-wallpaper-colors-of-nature-close-up-colorful-creative-dark-glow-glowing-green-hasaka-leaves-light-lock-screen-minimal-neon-neon-light-graphy-purple-simple-surreal-trending-yellow.jpg"),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(20.0),
                    child: Image.network(
                      widget.image,
                    )),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Icon(
                  //   Icons.fast_rewind_rounded,
                  //   size: 100,
                  //   color: appRedColor,
                  // ),
                  InkWell(
                      child: Icon(
                        playing == false
                            ? Icons.play_arrow_rounded
                            : Icons.pause,
                        color: appWhiteColor,
                        size: 100,
                      ),
                      onTap: () {
                        if (playing == false) {
                          audio.play(widget.song);
                          setState(() {
                            playing = true;
                          });
                        } else if (playing == true) {
                          audio.pause();
                          setState(() {
                            playing = false;
                          });
                        }
                      }),
                  // Icon(
                  //   Icons.fast_forward_rounded,
                  //   size: 100,
                  //   color: appRedColor,
                  // ),
                ],
              ),
            ],
          ),
        ));
  }
}

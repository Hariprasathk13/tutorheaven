import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tutorheaven/app/modules/Summary/Views/SummaryPage.dart';
import 'package:tutorheaven/app/modules/Transcript/controllers/TranscriptController.dart';
import 'package:tutorheaven/app/data/models/Transcript/Transcript.dart';
// import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class YoutubePlayerScreen extends StatefulWidget {
  const YoutubePlayerScreen({super.key});

  @override
  State<YoutubePlayerScreen> createState() => _YoutubePlayerScreenState();
}

class _YoutubePlayerScreenState extends State<YoutubePlayerScreen> {
  final TranscriptController transcriptController = Get.find();

  late final List<Transcript> transcripts;
  late final YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();
    transcripts = transcriptController.transcript;
    print(transcriptController.transcript.toString());
    _controller = YoutubePlayerController.fromVideoId(
      videoId:
          transcriptController.videoid, // Replace with your YouTube video ID
      autoPlay: false,
      params: const YoutubePlayerParams(
        showControls: true,
        showFullscreenButton: true,
      ),
    );
    // _controller.playVideo();
  }

  @override
  void dispose() {
    _controller.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: DefaultTabController(
          length: 2,
          child: Column(
            children: [
              YoutubePlayer(
                controller: _controller,
                aspectRatio: 16 / 9,
              ),
              const TabBar(tabs: [
                Tab(
                  icon: Icon(Icons.subtitles_rounded,
                      color: Color.fromARGB(255, 8, 46, 88)),
                ),
                Tab(
                  icon: Icon(
                    Icons.summarize,
                    color: Color.fromARGB(255, 14, 52, 91),
                  ),
                ),
              ]),
              Expanded(
                child: TabBarView(children: [TranscriptPage(), SummaryPage()]),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: const Color(0xFF1976D2).withOpacity(0.08),
          elevation: 0,
          onPressed: () {},
          child: IconButton(
              color: const Color(0xFF1976D2).withOpacity(0.8),
              onPressed: () {
                Get.toNamed('/quiz');
              },
              icon: const Icon(Icons.quiz)),
        ),
      ),
    );
  }
}

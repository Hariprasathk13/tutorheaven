import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tutorheaven/app/modules/Transcript/controllers/TranscriptController.dart';
import 'package:tutorheaven/app/widgets/FeatureCard.dart';
import 'package:tutorheaven/app/widgets/Recent.dart';
import 'package:tutorheaven/common/utils/idParser.dart';
import 'package:tutorheaven/app/widgets/ErrorText.dart';
import 'package:tutorheaven/app/widgets/StateBuilder.dart';

// https://www.youtube.com/watch?v=YjFJ0WjTVTA
class HomePage extends StatelessWidget {
  HomePage({super.key});
  final TextEditingController _idController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final TranscriptController controller = Get.find<TranscriptController>();

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Hero / App Title
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          "assets/logo.png",
                          width: 72, // Slightly larger for better visibility
                          height: 72,
                        ),
                        const SizedBox(
                            height: 12), // Add spacing between logo and text
                        Text(
                          "TutorHeaven", // Capitalized for a professional brand appearance
                          style: TextStyle(
                            fontStyle: FontStyle.italic,
                            fontSize: 32,
                            fontWeight: FontWeight.w700,
                            fontFamily: 'Roboto', // Use a modern, readable font
                            color: Colors.blue.shade800,
                            letterSpacing: 1.2, // Adds a subtle refined spacing
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),

                    const SizedBox(height: 80),
                    Text(
                      "Watch. Summarize. Master.\nTurn every YouTube video into Proffesional course.",
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.grey.shade600,
                        fontWeight: FontWeight.w500,
                        height: 1.4,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 40),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        FeatureCard(
                            value: "summarize", icon: Icons.summarize_rounded),
                        FeatureCard(
                            value: "chat", icon: Icons.chat_bubble_rounded),
                        FeatureCard(value: "quiz", icon: Icons.quiz_rounded),
                      ],
                    ),
                    const SizedBox(height: 24),

                    // Input Field
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: const [
                          // BoxShadow(
                          //   color: Colors.black12,
                          //   offset: Offset(0, 4),
                          //   blurRadius: 10,
                          // ),
                        ],
                      ),
                      child: TextFormField(
                        controller: _idController,
                        decoration: InputDecoration(
                          hintText: "Paste YouTube URL here",
                          hintStyle: TextStyle(
                              letterSpacing: 1.25,
                              fontWeight: FontWeight.w500,
                              color: Colors.grey.shade500),
                          border: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.grey.withOpacity(0.1)),
                            borderRadius: BorderRadius.circular(24),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 18),
                          suffixIcon: IconButton(
                            padding: const EdgeInsets.only(right: 8),
                            icon: const Icon(Icons.clear),
                            onPressed: () => _idController.clear(),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),

              StateBuilder(
                  state: controller.state,
                  onInitial: () => Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: ElevatedButton(
                          onPressed: () {
                            if (_idController.text.isEmpty) return;
                            final videoId = idParser(_idController.text);

                            if (videoId != null) {
                              controller.getTranscripts(videoId);
                            } else if (videoId == null || videoId == 'null') {
                              Get.snackbar("Invalid URL",
                                  "Please enter a valid YouTube URL",
                                  borderColor: const Color(0xFF1976D2),
                                  snackPosition: SnackPosition.BOTTOM);
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 24),
                            backgroundColor: const Color(0xFF1976D2),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(36)),
                          ),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.play_arrow_rounded,
                                color: Colors.white,
                              ),
                              Text(
                                "Summarize & play",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      ),
                  onLoading: () => const CircularProgressIndicator(
                        color: Color(0xFF1976D2),
                      ),
                  onError: () =>
                      Errortext(errorMessage: controller.error.value),
                  onSuccess: () => Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: ElevatedButton(
                          onPressed: () => Get.toNamed('/player'),
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 24),
                            backgroundColor: const Color(0xFF1976D2),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(36)),
                          ),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.play_arrow,
                                color: Colors.white,
                              ),
                              Text("Continue to Summary",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold))
                            ],
                          ),
                        ),
                      )),

              const SizedBox(height: 30),
              RecentLearningsSection(),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        height: 70,
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.blue.shade800,
              Colors.blueAccent.shade400,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              offset: const Offset(0, -2),
              blurRadius: 6,
            ),
          ],
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
          ),
        ),
        child: const Center(
          child: Text(
            "✨ Made by Learner • For Learners ✨",
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: Colors.white,
              letterSpacing: 1.1,
              fontFamily: 'Poppins', // Modern, elegant typeface
              shadows: [
                Shadow(
                  blurRadius: 4,
                  color: Colors.black26,
                  offset: Offset(1, 1),
                ),
              ],
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}

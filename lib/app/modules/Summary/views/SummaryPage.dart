import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tutorheaven/app/data/models/Transcript/Transcript.dart';
import 'package:tutorheaven/app/modules/Summary/controllers/SummaryController.dart';
import 'package:tutorheaven/app/modules/Transcript/controllers/TranscriptController.dart';
import 'package:tutorheaven/app/widgets/ErrorText.dart';
import 'package:tutorheaven/app/widgets/StateBuilder.dart';

class SummaryPage extends StatefulWidget {
  @override
  State<SummaryPage> createState() => _SummaryPageState();
}

class _SummaryPageState extends State<SummaryPage> {
  final SummaryController _summaryController = Get.find<SummaryController>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _summaryController.onInit();
  }

  @override
  Widget build(BuildContext context) {
    print(_summaryController.state);
    print(_summaryController.summary.message);
    return StateBuilder(
      state: _summaryController.state,
      onInitial: () => const Text(""),
      onLoading: () => const Center(
        child: CircularProgressIndicator(),
      ),
      onSuccess: () => Card(
        color: Colors.white,
        elevation: 4,
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        shadowColor: Colors.black.withOpacity(0.08),
        child: Expanded(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                Row(
                  children: const [
                    Icon(Icons.auto_awesome,
                        color: Color(0xFF1976D2), size: 22),
                    SizedBox(width: 8),
                    Text(
                      'AI Generated Summary',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF0D1B2A),
                        letterSpacing: 0.3,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 14),

                // Summary Text
                Text(
                  _summaryController.summary.message,
                  style: const TextStyle(
                    fontSize: 16,
                    height: 1.6,
                    color: Color(0xFF37474F),
                    fontWeight: FontWeight.w400,
                    letterSpacing: 0.2,
                  ),
                ),
                const SizedBox(height: 24),

                // Divider line
                Container(
                  height: 1,
                  color: Colors.grey.withOpacity(0.15),
                  margin: const EdgeInsets.only(bottom: 20),
                ),

                // Continue Button
                Align(
                  alignment: Alignment.centerRight,
                  child: ElevatedButton.icon(
                    onPressed: () => Get.toNamed('/chat'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF1976D2),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24, vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 2,
                    ),
                    icon:
                        const Icon(Icons.chat_bubble_outline_rounded, size: 20),
                    label: const Text(
                      'Continue in Chat',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.4,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      onError: () => Errortext(errorMessage: _summaryController.error.value),
    );
  }
}

class TranscriptPage extends StatelessWidget {
  TranscriptController transcriptController = Get.find<TranscriptController>();

  TranscriptPage({super.key});

  String _formatTime(Duration time) {
    final minutes = time.inMinutes.remainder(60).toString().padLeft(2, '0');
    final seconds = time.inSeconds.remainder(60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }

  @override
  Widget build(BuildContext context) {
    List<Transcript> transcripts = transcriptController.transcript;
    return Expanded(
      child: ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemCount: transcripts.length,
        itemBuilder: (context, index) {
          final transcript = transcripts[index];

          return Card(
            color: Colors.white,
            elevation: 2,
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Time Badge
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    decoration: BoxDecoration(
                      color: const Color(0xFF1976D2).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      _formatTime(transcript.startTime),
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF1976D2),
                        fontSize: 13,
                        letterSpacing: 0.4,
                      ),
                    ),
                  ),

                  const SizedBox(width: 14),

                  // Transcript Text
                  Expanded(
                    child: Text(
                      transcript.text.trim(),
                      style: const TextStyle(
                        fontSize: 15,
                        color: Color(0xFF212121),
                        height: 1.5,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

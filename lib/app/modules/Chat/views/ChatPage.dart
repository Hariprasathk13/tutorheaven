import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tutorheaven/app/data/models/Messages/Message.dart';
import 'package:tutorheaven/app/data/models/Messages/UserMessage.dart';
import 'package:tutorheaven/app/data/models/States/states.dart';
import 'package:tutorheaven/app/modules/Chat/controllers/ChatController.dart';
import 'package:tutorheaven/app/widgets/ChatBubble.dart';

class ChatPage extends StatefulWidget {
  ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> with TickerProviderStateMixin {
  final ChatController chatController = Get.find<ChatController>();
  late AnimationController _controller;
  final TextEditingController inputController = TextEditingController();
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: const BoxDecoration(
            color: Colors.white,
          ),
          child: Row(
            children: [
              // Input Field
              Expanded(
                flex: 4,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(
                      color: Colors.blue.shade300,
                      width: 1.2,
                    ),
                  ),
                  child: TextField(
                    onChanged: (value) {
                      if (value.isNotEmpty) {
                        chatController.canSend.value = true;
                      } else {
                        chatController.canSend.value = false;
                      }
                    },
                    controller: inputController,
                    scrollPhysics: const ClampingScrollPhysics(),
                    decoration: InputDecoration(
                      hintText: "Type your message...",
                      hintStyle: TextStyle(
                        color: Colors.grey.shade500,
                        fontSize: 15,
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 16),
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),

              const SizedBox(width: 12),

              // Send Button
              Obx(() {
                final isActive = chatController.canSend.isTrue;
                return AnimatedContainer(
                  duration: const Duration(milliseconds: 250),
                  decoration: BoxDecoration(
                    gradient: isActive
                        ? const LinearGradient(
                            colors: [
                              Color(0xFF3A7BD5), // Primary blue
                              Color(0xFF00D2FF), // Cyan accent
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          )
                        : LinearGradient(
                            colors: [
                              Colors.grey.shade400,
                              Colors.grey.shade500,
                            ],
                          ),
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: isActive
                            ? Colors.blueAccent.withOpacity(0.3)
                            : Colors.black12,
                        blurRadius: 6,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: IconButton(
                    onPressed: chatController.canSend.isTrue
                        ? () {
                            final text = inputController.text.trim();
                            if (text.isNotEmpty) {
                              chatController.askGemini(text);
                              chatController.canSend.value = false;
                              inputController.clear();
                            }
                          }
                        : null,
                    icon: const Icon(Icons.send_rounded, color: Colors.white),
                    iconSize: 22,
                    splashRadius: 26,
                  ),
                );
              }),
            ],
          )),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Obx(() {
              List<Message> chats = chatController.chats;
              if (chats.isEmpty) {
                return Expanded(
                  child: Center(
                    child: ShaderMask(
                      shaderCallback: (bounds) {
                        return const LinearGradient(
                          colors: [
                            Color(0xFF1E3C72), // Deep navy-blue
                            Color(0xFF2A5298), // Softer azure
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ).createShader(bounds);
                      },
                      child: const Text(
                        "Ask me something",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white, // Fallback
                          fontSize: 26,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 0.8,
                          fontFamily: 'Poppins',
                          shadows: [
                            Shadow(
                              blurRadius: 4,
                              color: Colors.black12,
                              offset: Offset(0, 1),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              }

              return Flexible(
                child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: chats.length,
                  itemBuilder: (context, index) {
                    return ChatBubble(chat: chats[index]);
                  },
                ),
              );
            }),
            Obx(() {
              if (chatController.typingstate.value == ChatState.typing) {
                return const Align(
                  alignment: Alignment.centerLeft,
                  child: Icon(
                    Icons.more_horiz,
                    color: Colors.grey,
                  ),
                );
              } else {
                return const SizedBox.shrink();
              }
            })
          ],
        ),
      ),
    );
  }
}

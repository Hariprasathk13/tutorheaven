import 'package:flutter/material.dart';
import 'package:tutorheaven/app/data/models/Messages/Message.dart';
import 'package:tutorheaven/app/data/models/Messages/UserMessage.dart';


class ChatBubble extends StatelessWidget {
  final Message chat;

  const ChatBubble({super.key, required this.chat});

  @override
  Widget build(BuildContext context) {
    final bool isSender = chat is UserChat;

    return Align(
      alignment:
          isSender ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.75,
        ),
        decoration: BoxDecoration(
          gradient: isSender
              ? LinearGradient(
                  colors: [
                    const Color(0xFF4A6CF7),
                    const Color(0xFF6C8CFF),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                )
              : LinearGradient(
                  colors: [
                    Colors.white,
                    Colors.grey.shade100,
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(18),
            topRight: const Radius.circular(18),
            bottomLeft: isSender
                ? const Radius.circular(18)
                : const Radius.circular(4),
            bottomRight: isSender
                ? const Radius.circular(4)
                : const Radius.circular(18),
          ),
          boxShadow: [
            BoxShadow(
              color: isSender
                  ? Colors.blueAccent.withOpacity(0.3)
                  : Colors.grey.withOpacity(0.2),
              blurRadius: 8,
              offset: const Offset(2, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment:
              isSender ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            // Message Text
            Text(
              chat.message,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: isSender ? Colors.white : Colors.black87,
                height: 1.4,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

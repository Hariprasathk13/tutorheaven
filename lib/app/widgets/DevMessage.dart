import 'package:flutter/material.dart';

class CreatorMessageCard extends StatelessWidget {
// optional image for creator

  const CreatorMessageCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.blue.shade600, Colors.blue.shade400],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            offset: Offset(0, 6),
            blurRadius: 12,
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Creator Avatar
          CircleAvatar(
            radius: 28,
            // backgroundImage: avatarUrl != null
            //     ? NetworkImage(avatarUrl!)
            //     : const AssetImage('assets/avatar_placeholder.png')
            //         as ImageProvider,
            backgroundColor: Colors.white,
          ),
          const SizedBox(width: 16),

          // Message Content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "hi im hari prasath",
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  """
Welcome to Tutor Heaven! We know how overwhelming YouTube tutorials can feel — endless videos, repeated watching, and confusing explanations. Many call it 'Tutorial Hell'. That’s why we created this app: to transform any YouTube tutorial into an interactive learning experience.

With Tutor Heaven, you can summarize, quiz yourself, and learn efficiently without the endless loop of rewinding and replaying. Dive in, master concepts faster, and make learning truly enjoyable.

Your journey from Tutorial Hell to Tutor Heaven starts here!
""",
                  style: const TextStyle(
                    fontSize: 15,
                    color: Colors.white70,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

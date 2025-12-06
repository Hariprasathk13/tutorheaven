import 'package:flutter/material.dart';

class FeatureCard extends StatelessWidget {
  final IconData icon;
  final String value;
  FeatureCard({super.key, required this.value, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 26,
          backgroundColor: const Color(0xFF1976D2).withOpacity(0.08),
        
          child: Icon(
            icon,
            size: 22,
            color: const Color(0xFF1976D2).withOpacity(0.8),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          value,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 13.5,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.2,
            color: const Color(0xFF37474F), 
          ),
        ),
      ],
    );
  }
}

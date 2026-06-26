import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class ConnectionStatusBar extends StatelessWidget {
  final bool isConnected;

  const ConnectionStatusBar({super.key, required this.isConnected});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: (isConnected ? Colors.green : Colors.redAccent).withOpacity(0.15),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: (isConnected ? Colors.green : Colors.redAccent).withOpacity(0.3),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 10,
            height: 10,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isConnected ? Colors.green : Colors.redAccent,
              boxShadow: [
                BoxShadow(
                  color: (isConnected ? Colors.green : Colors.redAccent).withOpacity(0.6),
                  blurRadius: 8,
                  spreadRadius: 1,
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Text(
            isConnected ? 'Connected to COM14' : 'Disconnected',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: isConnected ? Colors.green : Colors.redAccent,
                  fontWeight: FontWeight.w600,
                ),
          ),
          const Spacer(),
          if (isConnected)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: Colors.green.withOpacity(0.2),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Text(
                '9600 8-N-1',
                style: TextStyle(
                  color: Colors.green,
                  fontSize: 10,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
        ],
      ),
    ).animate().fadeIn(duration: 300.ms).slideX(begin: -0.1);
  }
}

import 'package:chatapp/themes/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatBubble extends StatelessWidget {
  final String message;
  final bool isMe;
  const ChatBubble({super.key, required this.message, required this.isMe});

  @override
  Widget build(BuildContext context) {

    bool isDarkMode = Provider.of<ThemeProvider>(context, listen: false).isDarkMode;
    return Container(
      decoration: BoxDecoration(
        color: isMe
         ? (isDarkMode ? Colors.green.shade600 : Colors.grey.shade500)
         : (isDarkMode ? Colors.grey.shade800 : Colors.green.shade200),
        borderRadius: BorderRadius.circular(12),
      ),
      padding: EdgeInsets.all(16),
      margin: const EdgeInsets.symmetric(horizontal: 25, vertical: 2.5),
      child: Text(message, style: TextStyle(
        color:isMe 
        ?Colors.white 
        : (isDarkMode ? Colors.white : Colors.black)),),  
    );
  }
}

import 'package:flutter/material.dart';

class StylishTextField extends StatefulWidget {
  final TextEditingController controller;
  final Function(String) onAdd;

  const StylishTextField({
    Key? key,
    required this.controller,
    required this.onAdd,
  }) : super(key: key);

  @override
  State<StylishTextField> createState() => _StylishTextFieldState();
}

class _StylishTextFieldState extends State<StylishTextField> {
  bool isFocused = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          gradient: LinearGradient(
            colors: [
              const Color(0xff2C36A3).withOpacity(0.1),
              const Color(0xff2C36A3).withOpacity(0.2),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 12,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Row(
          children: [
            Expanded(
              child: Focus(
                onFocusChange: (hasFocus) {
                  setState(() {
                    isFocused = hasFocus;
                  });
                },
                child: TextField(
                  controller: widget.controller,
                  decoration: InputDecoration(
                    hintText: 'Enter a task...',
                    hintStyle: TextStyle(
                      color: isFocused ? Colors.black : Colors.grey[600],
                      fontSize: 16,
                    ),
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 8),
            GestureDetector(
              onTap: () {
                if (widget.controller.text.isNotEmpty) {
                  widget.onAdd(widget.controller.text);
                  widget.controller.clear();
                }
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: const Color(0xff2C36A3),
                  boxShadow: isFocused
                      ? [
                    BoxShadow(
                      color: const Color(0xff2C36A3).withOpacity(0.4),
                      blurRadius: 15,
                      spreadRadius: 1,
                    )
                  ]
                      : [],
                ),
                child: const Icon(
                  Icons.add,
                  color: Colors.white,
                  size: 24,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

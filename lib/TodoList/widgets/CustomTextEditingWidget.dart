import 'package:flutter/material.dart';
import 'package:webreinventassignment/TodoList/view/TodoListScreen.dart';

class CustomTextEditingWidget extends StatefulWidget {
  final TextEditingController controller;
  final Function(String) onAdd;

  const CustomTextEditingWidget({
    super.key,
    required this.controller,
    required this.onAdd,
  });

  @override
  State<CustomTextEditingWidget> createState() =>
      _CustomTextEditingWidgetState();
}

class _CustomTextEditingWidgetState extends State<CustomTextEditingWidget> {
  
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        gradient: LinearGradient(
          colors: [
            const Color(0xff2C36A3).withOpacity(0.2),
            const Color(0xff2C36A3).withOpacity(0.5),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 10,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: widget.controller,
              decoration: const InputDecoration(
                hintText: 'Enter a task...',
                hintStyle: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
                border: InputBorder.none,
              ),
              textInputAction: TextInputAction.done,
              onSubmitted: (value) => todoListCtrl.onSubmit(context),
            ),
          ),
          const SizedBox(width: 8),
          GestureDetector(
            onTap: () => todoListCtrl.onSubmit(context),
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xff2C36A3),
              ),
              child: const Icon(
                Icons.add,
                color: Colors.white,
                size: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

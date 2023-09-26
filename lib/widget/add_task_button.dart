import 'package:flutter/material.dart';

class AddTaskButton extends StatelessWidget {
  final void Function()? onPressed;
  final String title;
  final bool showIcon;
  const AddTaskButton(
      {super.key, required this.onPressed, required this.title, this.showIcon = true});
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
          elevation: 0.0,
          padding: const EdgeInsets.only(
            top: 16,
            bottom: 16,
            right: 16,
            left: 16,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        onPressed: onPressed,
        child: Row(
          children: [
          showIcon?  const Icon(
              Icons.add,
              size: 16,
            ): const SizedBox(),
            Text(title)
          ],
        ));
  }
}

import 'package:flutter/material.dart';

class BottomSheetButton extends StatelessWidget {
  final String title;
  final bool isTaskCompleted;
  final VoidCallback onPressed;
  final Color color;
  final Color? borderColor;

  const BottomSheetButton(
      {Key? key,
      required this.title,
      required this.onPressed,
      required this.color,
      this.isTaskCompleted = false,
      this.borderColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: isTaskCompleted
          ? const SizedBox()
          : Container(
              margin: const EdgeInsets.only(bottom: 10),
              height: 55,
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                    width: 1.2, color: borderColor ?? Colors.transparent),
              ),
              width: MediaQuery.sizeOf(context).width / 1.1,
              child: Center(
                child:
                    Text(title, style: Theme.of(context).textTheme.labelSmall!),
              ),
            ),
    );
  }
}

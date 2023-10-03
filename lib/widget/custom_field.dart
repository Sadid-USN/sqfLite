import 'package:flutter/material.dart';

class CustomField extends StatelessWidget {
  final String title;
  final String hintText;
  final double? width;
  final TextEditingController? controller;
  final Widget? widget;
  final bool isNote;

  const CustomField({
    super.key,
    required this.title,
    required this.hintText,
    this.isNote = false,
    this.controller,
    this.widget,
    this.width,
  });
  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return Container(
      margin: const EdgeInsets.only(top: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: textTheme.titleSmall!
                .copyWith(fontSize: 16, fontWeight: FontWeight.w600),
          ),
          Container(
            margin: const EdgeInsets.only(top: 8.0),
            height: 65,
            width: width ?? MediaQuery.sizeOf(context).width,
            decoration: BoxDecoration(
              border: Border.all(width: 0.9),
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    // validator: validator,
                    textInputAction: TextInputAction.next,
                    minLines: 3,
                    maxLines: 10,
                    keyboardType: TextInputType.text,
                    cursorColor: Colors.blueGrey.shade600,
                    readOnly: widget == null ? false : true,
                    autofocus: false,
                    controller: controller,
                    style: textTheme.titleSmall!.copyWith(fontSize: 16),
                    decoration: InputDecoration(
                      border: InputBorder.none,

                      disabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          width: 0,
                        ),
                        borderRadius: BorderRadius.circular(0.0),
                      ),
                      // border: InputBorder.none,
                      hintText: hintText,
                      hintStyle: textTheme.titleSmall!.copyWith(fontSize: 14),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(width: 0, color: Colors.white),
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(12.0),
                      ),

                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Colors.white,
                          width: 0,
                        ),
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                    ),
                  ),
                ),
                widget == null
                    ? const SizedBox()
                    : Container(
                        child: widget,
                      )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

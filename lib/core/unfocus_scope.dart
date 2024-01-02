import 'package:flutter/material.dart';

extension ScaffoldExtansion on Scaffold {
  Widget unfocusScope(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: this,
    );
  }

  Widget unfocusBottomSheet(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pop();
      },
      child: this,
    );
  }
}

import 'package:flutter/material.dart';

import '../theme/app_color.dart';

class RoundedElevatedButton extends StatelessWidget {
  const RoundedElevatedButton({
    super.key,
    required this.buttonText,
    required this.onPressed,
    this.color = AppColor.appColor,
  });

  final String buttonText;
  final VoidCallback? onPressed;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.all(color),
        elevation: WidgetStateProperty.all(0.0),
        shape: WidgetStateProperty.all(
          const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(8)),
          ),
        ),
        fixedSize: WidgetStateProperty.all(
          Size(
            MediaQuery.of(context).size.width,
            45,
          ),
        ),
      ),
      child: Text(
        buttonText,
        style: const TextStyle(
          color: AppColor.whiteColor,
          fontWeight: FontWeight.w400,
          fontSize: 16,
        ),
      ),
    );
  }
}

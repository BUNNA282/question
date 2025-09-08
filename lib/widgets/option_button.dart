import 'package:flutter/material.dart';
import 'package:flutter_app_game/config/app_colors.dart';
import 'package:flutter_app_game/config/app_styles.dart';

class OptionButton extends StatelessWidget {
  final String text;
  final int index;
  final VoidCallback onTap;
  final Color backgroundColor;
  final Color textColor;
  final Color borderColor;

  const OptionButton({
    super.key,
    required this.text,
    required this.index,
    required this.onTap,
    required this.backgroundColor,
    required this.textColor,
    required this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          foregroundColor: textColor,
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: BorderSide(color: borderColor, width: 1.5),
          ),
          elevation: 5,
          shadowColor: AppColors.blackOpacity(0.3),
        ),
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: AppStyles.optionButtonTextStyle,
        ),
      ),
    );
  }
}

// lib/widgets/background_pattern.dart
import 'package:flutter/material.dart';
import 'package:flutter_app_game/config/app_colors.dart';

class BackgroundPattern extends StatelessWidget {
  const BackgroundPattern({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Large circles/shapes
        Positioned(
          top: -50,
          right: -50,
          child: Container(
            width: 200,
            height: 200,
            decoration: BoxDecoration(
              color: AppColors.whiteOpacity(0.1),
              shape: BoxShape.circle,
            ),
          ),
        ),
        Positioned(
          bottom: -80,
          left: -80,
          child: Container(
            width: 250,
            height: 250,
            decoration: BoxDecoration(
              color: AppColors.whiteOpacity(0.08),
              borderRadius: BorderRadius.circular(70), // រាងជ្រុងមូល
            ),
          ),
        ),
        Positioned(
          top: 150,
          left: -30,
          child: Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              color: AppColors.whiteOpacity(0.05),
              shape: BoxShape.circle,
            ),
          ),
        ),
        Positioned(
          bottom: 200,
          right: -40,
          child: Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              color: AppColors.whiteOpacity(0.06),
              borderRadius: BorderRadius.circular(40),
            ),
          ),
        ),

        // Small dots/icons (as seen in the original quiz screen, keeping for consistency)
        Positioned(
          top: 20,
          left: 20,
          child: Icon(Icons.star, color: AppColors.whiteOpacity(0.2), size: 30),
        ),
        Positioned(
          bottom: 50,
          right: 30,
          child: Icon(
            Icons.question_mark_sharp,
            color: AppColors.whiteOpacity(0.2),
            size: 40,
          ),
        ),
        Positioned(
          top: 100,
          right: 80,
          child: Icon(
            Icons.diamond,
            color: AppColors.whiteOpacity(0.2),
            size: 25,
          ),
        ),
        Positioned(
          bottom: 120,
          left: 50,
          child: Icon(
            Icons.circle_outlined,
            color: AppColors.whiteOpacity(0.2),
            size: 35,
          ),
        ),
        Positioned(
          top: 250,
          left: 100,
          child: Icon(
            Icons.flash_on,
            color: AppColors.whiteOpacity(0.2),
            size: 30,
          ),
        ),
        Positioned(
          bottom: 20,
          right: 150,
          child: Icon(
            Icons.lightbulb_outline,
            color: AppColors.whiteOpacity(0.2),
            size: 30,
          ),
        ),
      ],
    );
  }
}

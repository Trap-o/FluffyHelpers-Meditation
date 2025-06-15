import 'package:fluffyhelpers_meditation/constants/app_colors.dart';
import 'package:flutter/material.dart';

class LevelProgressBar extends StatelessWidget {
  final int level;
  final int currentExp;
  final int maxExp;

  const LevelProgressBar({
    super.key,
    required this.level,
    required this.currentExp,
    required this.maxExp,
  });

  @override
  Widget build(BuildContext context) {
    double progress = currentExp / maxExp;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.highlight,
              ),
              alignment: Alignment.center,
              child: Text(
                '$level',
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            const SizedBox(width: 12),

            Expanded(
              child: Stack(
                children: [
                  Container(
                    height: 12,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                  FractionallySizedBox(
                    alignment: Alignment.centerLeft,
                    widthFactor: progress.clamp(0.0, 1.0),
                    child: Container(
                      height: 12,
                      decoration: BoxDecoration(
                        color: AppColors.accent,
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(width: 12),

            Container(
              width: 40,
              height: 40,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.accent,
              ),
              alignment: Alignment.center,
              child: Text(
                '${level + 1}',
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),

        const SizedBox(height: 6),

        Align(
          alignment: Alignment.center,
          child: Text(
            '$currentExp XP',
            style: const TextStyle(color: AppColors.accent),
          ),
        ),
      ],
    );
  }
}

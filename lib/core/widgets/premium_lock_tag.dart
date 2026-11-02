import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class PremiumLockTag extends StatelessWidget {
  final bool isLocked;

  const PremiumLockTag({super.key, required this.isLocked});

  @override
  Widget build(BuildContext context) {
    // Si le contenu est gratuit (pas verrouillé), on n'affiche rien du tout
    if (!isLocked) return const SizedBox.shrink();

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: AppColors.accentGold,
        borderRadius: BorderRadius.circular(8),
      ),
      child: const Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.lock, size: 12, color: Colors.white),
          SizedBox(width: 4),
          Text(
            "PREMIUM",
            style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}

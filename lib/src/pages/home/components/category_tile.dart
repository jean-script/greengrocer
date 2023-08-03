import 'package:flutter/material.dart';
import 'package:greengrocer/src/config/custom_colors.dart';

class CategoryTile extends StatelessWidget {
  const CategoryTile({
    super.key,
    required this.category,
    required this.isSelectd,
    required this.onPressed,
  });

  final String category;
  final bool isSelectd;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Align(
        alignment: Alignment.center,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 6),
          decoration: BoxDecoration(
              color: isSelectd
                  ? CustomColors.customSwatchColor
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(10)),
          child: Text(
            category,
            style: TextStyle(
                color: isSelectd
                    ? Colors.white
                    : CustomColors.customConstrastColor,
                fontSize: isSelectd ? 16 : 14,
                fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}

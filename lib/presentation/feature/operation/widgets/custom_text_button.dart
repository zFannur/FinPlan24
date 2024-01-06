import 'package:finplan24/app/app.dart';
import 'package:flutter/material.dart';

class CustomTextButton extends StatelessWidget {
  const CustomTextButton({
    required this.isSelected,
    required this.name,
    required this.onTap,
    super.key,
  });

  final bool isSelected;
  final String name;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: isSelected
          ? TextButton.styleFrom(
              side: const BorderSide(
                width: 2,
                color: AppColors.orange,
              ),
            )
          : null,
      onPressed: onTap,
      child: Text(
        name,
        style: AppTextStyle.bold14,
      ),
    );
  }
}

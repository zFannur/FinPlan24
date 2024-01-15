import 'package:finplan24/app/app.dart';
import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    required this.onPressed,
    this.backgroundColor = AppColors.greyDark,
    required this.child,
    this.isFixedSize = true,
  });

  final VoidCallback onPressed;
  final Color backgroundColor;
  final Widget child;
  final bool? isFixedSize;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        shape: const RoundedRectangleBorder(),
        backgroundColor: backgroundColor,
        fixedSize: (isFixedSize ?? false) ? Size(MediaQuery.of(context).size.width / 3, 40) : null,
      ),
      child: child,
    );
  }
}

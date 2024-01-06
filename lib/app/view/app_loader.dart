import 'package:finplan24/app/app.dart';
import 'package:flutter/material.dart';

class AppLoader extends StatelessWidget {
  const AppLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Загрузка...',
            style: AppTextStyle.bold24,
          ),
          Padding(
            padding: AppPadding.top8,
            child: CircularProgressIndicator(
              color: AppColors.orange,
            ),
          ),
        ],
      ),
    );
  }
}

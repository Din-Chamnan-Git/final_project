import 'package:final_project/const/themes/app_theme.dart';
import 'package:flutter/material.dart';

class CustomCategory extends StatelessWidget {
  final String name;
  final bool isSelect;
  final VoidCallback action;

  const CustomCategory({
    super.key,
    required this.name,
    required this.isSelect,
    required this.action,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: action,
      child: AnimatedContainer(
        padding: EdgeInsets.symmetric(horizontal: 10),
        duration: const Duration(milliseconds: 300),
        margin: const EdgeInsets.symmetric(horizontal: 10),
        alignment: Alignment.center,

        height: 40,
        decoration: BoxDecoration(
          color:
              isSelect
                  ? AppThemeData.primaryBlueAccent
                  : AppThemeData.primarySoft,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          name,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
        ),
      ),
    );
  }
}

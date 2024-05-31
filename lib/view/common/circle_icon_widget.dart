import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CircleIconWidget extends StatelessWidget {
  final VoidCallback onTap;
  final double radius;
  final IconData icon;
  final Color iconColor;
  final double iconSize;
  const CircleIconWidget({
    required this.onTap,
    super.key,
    required this.radius,
    required this.iconColor,
    required this.iconSize,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(20),
      onTap: onTap,
      child: CircleAvatar(
        radius: radius,
        backgroundColor: Colors.grey.shade300,
        child: Padding(
          padding: EdgeInsets.only(top: 1.h),
          child: Icon(
            icon,
            color: iconColor,
            size: iconSize,
          ),
        ),
      ),
    );
  }
}

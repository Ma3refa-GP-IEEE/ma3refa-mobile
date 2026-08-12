import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ma3refa_mobile/core/utils/app_colors.dart';

class StarRatingWidget extends StatelessWidget {
  final double currentPoints;
  final double maxPoints;

  const StarRatingWidget({
    super.key,
    required this.currentPoints,
    this.maxPoints = 500,
  });

  @override
  Widget build(BuildContext context) {
    final double pointsPerStar = maxPoints / 5;
    final int currentFullStars = (currentPoints / pointsPerStar).floor();

    final double nextStarTarget = currentPoints >= maxPoints
        ? maxPoints
        : (currentFullStars + 1) * pointsPerStar;

    final double pointsNeeded = currentPoints >= maxPoints
        ? 0
        : nextStarTarget - currentPoints;

    final double progressPercent = currentPoints >= maxPoints
        ? 1.0
        : currentPoints / nextStarTarget;

    double rating = (currentPoints / maxPoints) * 5.0;
    rating = rating.clamp(0.0, 5.0);

    final Color cardBackground = AppColors.secondary;
    final Color orangeText = AppColors.textDark;
    final Color greenBar = const Color(0xFF23974A);

    return Card(
      elevation: 8,
      shadowColor: Colors.black45,
      color: cardBackground,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: EdgeInsets.all(20.r),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (pointsNeeded > 0)
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: '${pointsNeeded.toStringAsFixed(0)} more points ',
                      style: TextStyle(
                        color: orangeText,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextSpan(
                      text: 'to get your next star!',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              )
            else
              Text(
                'Legendary! You got all stars!',
                style: TextStyle(
                  color: orangeText,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),

            const SizedBox(height: 16),

            Stack(
              children: [
                Container(
                  height: 10.h,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(10.r),
                    border: Border.all(color: Colors.grey.shade600, width: 1.w),
                  ),
                ),
                FractionallySizedBox(
                  widthFactor: progressPercent,
                  child: Container(
                    height: 10.h,
                    decoration: BoxDecoration(
                      color: greenBar,
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10.h),

            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Points: ${currentPoints.toStringAsFixed(0)}/${nextStarTarget.toInt()}',
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),

            SizedBox(height: 24.h),

            Center(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: List.generate(5, (index) {
                  double fillAmount = (rating - index).clamp(0.0, 1.0);
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: 4.0),
                    child: Stack(
                      children: [
                        Icon(
                          Icons.star_rounded,
                          color: Colors.grey.shade800,
                          size: 40,
                        ),
                        ClipRect(
                          clipper: _StarClipper(fillAmount),
                          child: const Icon(
                            Icons.star_rounded,
                            color: Color(0xFFFFC107),
                            size: 40,
                            shadows: [
                              Shadow(
                                color: Color(0x66FFC107),
                                blurRadius: 10,
                                offset: Offset(0, 2),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _StarClipper extends CustomClipper<Rect> {
  final double fillAmount;
  _StarClipper(this.fillAmount);

  @override
  Rect getClip(Size size) {
    return Rect.fromLTRB(0, 0, size.width * fillAmount, size.height);
  }

  @override
  bool shouldReclip(_StarClipper oldClipper) {
    return oldClipper.fillAmount != fillAmount;
  }
}

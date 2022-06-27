import 'package:flutter/material.dart';

import '../services/sizes.dart';

class CalendarDays extends StatelessWidget{
  final String day;
  final Color color;
  const CalendarDays({Key? key, required this.day, required this.color}) : super(key: key);

  @override
  Widget build(BuildContext context){
    final double size = getDaySizeScroll(context);
    return Container(
      width: size,
      height: size,
      alignment: Alignment.center,
      child: Center(
        child: Text(day,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: color,
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.w600,
            fontSize: screenSize(context) == ScreenSizes.small ? 12 : 16,
          ),
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';

import '../../services/sizes.dart';
import '../dashed/dashed_circle_widget.dart';

class CalendarDayNumber extends StatelessWidget{
  final int day;
  final Color color;
  final bool scrolling;
  final bool isFuture;
  final DateTime date;
  const CalendarDayNumber({Key? key, required this.day, required this.color, required this.scrolling, required this.isFuture, required this.date}) : super(key: key);

  @override
  Widget build(BuildContext context){
    final double size = scrolling ? getDaySizeScroll(context) : getDayNumberSize(context);
    return SizedBox(
      height: size,
      width: size,
      child: ((){
        if(scrolling){
          if(day >= 1 && !isFuture){
            return Center(
              child: DashedCircle(
                color: const Color(0xff2F3A57),
                child: CircleAvatar(
                  backgroundColor: Colors.transparent,
                  foregroundColor: Colors.transparent,
                  child: Text(day < 1 ? '' : day.toString(),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: const Color(0xff2F3A57),
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.w500,
                      fontSize: ((){
                        if(scrolling){
                          return screenSize(context) == ScreenSizes.small ? 16.0 : 18.0;
                        }else{
                          return screenSize(context) == ScreenSizes.small ? 8.0 : 10.0;
                        }
                      }()),
                    ),
                  ),
                ),
              ),
            );
          }else if(isFuture){
            return Center(
              child: CircleAvatar(
                backgroundColor: Colors.transparent,
                foregroundColor: Colors.transparent,
                child: Text(day < 1 ? '' : day.toString(),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: const Color(0xff888888),
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w400,
                    fontSize: ((){
                      if(scrolling){
                        return screenSize(context) == ScreenSizes.small ? 16.0 : 18.0;
                      }else{
                        return screenSize(context) == ScreenSizes.small ? 8.0 : 10.0;
                      }
                    }()),
                  ),
                ),
              ),
            );
          }
        }else{
          return SizedBox(
            width: size,
            height: size,
            child: Center(
              child: Text(day < 1 ? '' : day.toString(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: color,
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w400,
                  fontSize: screenSize(context) == ScreenSizes.small ? 8.0 : 10.0,
                ),
              ),
            ),
          );
        }
      }()),
    );
  }
}

class CalendarDayNumberBlank extends StatelessWidget{
  const CalendarDayNumberBlank({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context){
    final double size = getDaySizeScroll(context);
    return SizedBox(
      width: size,
      height: size,
    );
  }
}
import 'package:flutter/material.dart';

import '../../services/date_calculator.dart';
import '../../services/months.dart';
import 'days_number.dart';

/// Displays the calendar in month view
class CalendarMonthView extends StatelessWidget{
  final int month;
  final int year;
  final bool scrolling;
  const CalendarMonthView({Key? key, required this.month, required this.year, required this.scrolling}) : super(key: key);

  Widget buildMonthDays(){
    final List<Row> dayRows = <Row>[];
    final List<CalendarDayNumber> dayRowChildren = <CalendarDayNumber>[];

    final int daysInMonth = getDaysInMonth(year, month);
    final int firstWeekdayOfMonth = DateTime(year, month, 1).weekday;

    for(int specificDay = 1 - firstWeekdayOfMonth; specificDay <= daysInMonth; specificDay++){
      if(DateTime(year, month, specificDay).weekday == DateTime.sunday){
        dayRowChildren.add(CalendarDayNumber(day: specificDay, color: const Color(0xffff0000), scrolling: scrolling, isFuture: calculateDateDifference(DateTime(year, month, specificDay)), date: DateTime(year, month, specificDay),));
      }else{
        dayRowChildren.add(CalendarDayNumber(day: specificDay, color: const Color(0xff2F3A57), scrolling: scrolling, isFuture: calculateDateDifference(DateTime(year, month, specificDay)), date: DateTime(year, month, specificDay),),);
      }

      if((specificDay + firstWeekdayOfMonth) % DateTime.daysPerWeek == 0 || specificDay == daysInMonth){
        dayRows.add(Row(children: List<CalendarDayNumber>.from(dayRowChildren),),);
        dayRowChildren.clear();
      }
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: dayRows,
    );
  }

  Widget buildMonthView(BuildContext context){
    return scrolling
    ? buildMonthDays()
    : Column(
      children: [
        Text(months[month - 1], style: const TextStyle(color: Color(0xff2F3A57), fontWeight: FontWeight.w600, fontSize: 14, fontFamily: 'Montserrat')),

        buildMonthDays(),
      ],
    );
  }

  @override
  Widget build(BuildContext context){
    return buildMonthView(context);
  }
}


class CalendarMonthViewBlank extends StatelessWidget{
  const CalendarMonthViewBlank({Key? key}) : super(key: key);

  Widget buildMonthDays(){
    DateTime now = DateTime.now();
    final List<Row> dayRows = <Row>[];
    final List<CalendarDayNumberBlank> dayRowChildren = <CalendarDayNumberBlank>[];

    final int daysInMonth = getDaysInMonth(now.year, now.month);
    final int firstWeekdayOfMonth = DateTime(now.year, now.month, 1).weekday;

    for(int specificDay = 1 - firstWeekdayOfMonth; specificDay <= daysInMonth; specificDay++){
      if(DateTime(now.year, now.month, specificDay).weekday == DateTime.sunday || DateTime(now.year, now.month, specificDay).weekday == DateTime.saturday){
        dayRowChildren.add(const CalendarDayNumberBlank());
      }else{
        dayRowChildren.add(const CalendarDayNumberBlank());
      }

      if((specificDay + firstWeekdayOfMonth) % DateTime.daysPerWeek == 0 || specificDay == daysInMonth){
        dayRows.add(Row(children: List<CalendarDayNumberBlank>.from(dayRowChildren),),);
        dayRowChildren.clear();
      }
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: dayRows,
    );
  }

  Widget buildMonthView(BuildContext context){
    return Column(
      children: [
        buildMonthDays(),
      ],
    );
  }

  @override
  Widget build(BuildContext context){
    return buildMonthView(context);
  }
}
import 'package:flutter/material.dart';
import 'month.dart';

/// Displays the calendar in year view
class CalendarYearView extends StatelessWidget{
  final int year;
  final VoidCallback onTap;
  const CalendarYearView({Key? key, required this.year, required this.onTap}) : super(key: key);
  
  Widget buildYearMonths(){
    List<Widget> monthRows = <Widget>[];
    final List<CalendarMonthView> monthRowChildren = <CalendarMonthView>[];

    for (int month = 1; month <= DateTime.monthsPerYear; month++) {
      monthRowChildren.add(
        CalendarMonthView(month: month, year: year, scrolling: false,),
      );

      if (month % 3 == 0) {
        monthRows.add(
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: List<Widget>.from(monthRowChildren),
          ),
        );

        monthRows.add(const SizedBox(height: 20,));
        monthRowChildren.clear();
      }
    }

    return Column(
      children: List<Widget>.from(monthRows),
    );
  }

  @override
  Widget build(BuildContext context){
    return buildYearMonths();
  }
}
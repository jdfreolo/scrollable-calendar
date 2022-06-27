import 'package:flutter/material.dart';
import 'package:scrollable_calendar/widgets/calendar/month.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import '../../services/days.dart';
import '../../services/months.dart';
import 'days.dart';

class CalendarMonthViewScroll extends StatefulWidget{
  final int month;
  final int year;
  const CalendarMonthViewScroll({Key? key, required this.month, required this.year}) : super(key: key);

  @override
  CalendarMonthViewScrollState createState() => CalendarMonthViewScrollState();
}

class CalendarMonthViewScrollState extends State<CalendarMonthViewScroll>{
  final ItemScrollController itemScrollController = ItemScrollController();
  final ItemPositionsListener itemPositionsListener = ItemPositionsListener.create();

  ValueNotifier<int> yearCalendar = ValueNotifier<int>(2000);
  ValueNotifier<int> monthCalendar = ValueNotifier<int>(0);
  ValueNotifier<int> indexCalendar = ValueNotifier<int>(0);
  ScrollController controller = ScrollController();
  int initialIndex = 21;

  Widget buildYearMonths(){
    List<Widget> monthRows = <Widget>[];
    final List<Widget> monthRowChildren = <Widget>[];

    for(int month = 1; month <= DateTime.monthsPerYear; month++){
      monthRowChildren.add(
        InkWell(
          onTap: (){
            monthCalendar.value = month - 1;
            indexCalendar.value--;
          },
          child: CalendarMonthView(month: month, year: yearCalendar.value, scrolling: false,),
        ),
      );

      if(month % 3 == 0){
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

    return SingleChildScrollView(
      physics: const ClampingScrollPhysics(),
      child: Column(
        children: List<Widget>.from(monthRows),
      ),
    );
  }

  @override
  void initState(){
    super.initState();
    yearCalendar.value = widget.year;
    monthCalendar.value = widget.month - 1;
    itemPositionsListener.itemPositions.addListener(() {
      itemPositionsListener.itemPositions.value.map((e){
        if(e.index > 12 && e.itemLeadingEdge <= 0){
          itemScrollController.jumpTo(index: widget.month - 1);
        }

        if(e.itemLeadingEdge <= 0){
          monthCalendar.value = e.index;
        } 
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context){
    return ValueListenableBuilder(
      valueListenable: indexCalendar,
      builder: (_, int indexCalendarListener, __) => ValueListenableBuilder(
        valueListenable: yearCalendar,
        builder: (_, int yearCalendarListener, __) => ValueListenableBuilder(
          valueListenable: monthCalendar,
          builder: (_, int monthCalendarListener, __) => Column(
            children: [
              Container(
                height: 80,
                decoration: const BoxDecoration(
                  color: Color(0xffF2F6FF),
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10))
                ),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: ((){
                    switch(indexCalendarListener){
                      case 0: return TextButton.icon(
                        onPressed: (){
                          indexCalendar.value++;
                        }, 
                        icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Color(0xff2F3A57),), 
                        label: Text(monthCalendarListener <= 11 ? months[monthCalendarListener] : '', style: const TextStyle(color: Color(0xff2F3A57), fontWeight: FontWeight.bold, fontSize: 24, fontFamily: 'Montserrat')),
                      );
                      case 1: return Row(
                        children: [
                          TextButton.icon(
                            onPressed: (){
                              indexCalendar.value--;
                            }, 
                            icon: const SizedBox(),
                            label: Text('$yearCalendarListener', style: const TextStyle(color: Color(0xff2F3A57), fontWeight: FontWeight.bold, fontSize: 24, fontFamily: 'Montserrat')),
                          ),

                          Expanded(child: Container()),

                          IconButton(
                            onPressed: (){
                              if(yearCalendar.value > 2000){
                                yearCalendar.value--;
                              }
                            },
                            icon: const Icon(Icons.arrow_back_ios_new_outlined, color: Color(0xff888888),),
                          ),

                          const SizedBox(width: 10,),

                          IconButton(
                            onPressed: (){
                              if(yearCalendar.value < 2100){
                                yearCalendar.value++;
                              }
                            },
                            icon: const Icon(Icons.arrow_forward_ios_outlined, color: Color(0xff888888),),
                          ),
                        ],
                      );
                    }
                  }()),
                ),
              ),

              SizedBox(
                child: ((){
                  switch(indexCalendarListener){
                    case 0: return Container(
                      color: const Color(0xffF2F6FF),
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: ((){
                        final List<Widget> daysRowChildren = <Widget>[];

                        for(int day = 0; day < days.length; day++){
                          daysRowChildren.add(CalendarDays(day: days[day], color: day != 0 ? const Color(0xff2F3A57) : const Color(0xffff0000),));
                        }

                        return Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: daysRowChildren,
                        );
                      }()),
                    );
                    case 1: return const SizedBox();
                  }
                }()),
              ),

              Expanded(
                child: Container(
                  decoration: const BoxDecoration(
                    color: Color(0xffffffff),
                    borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10)),
                  ),
                  padding: const EdgeInsets.all(20),
                  child: ((){
                    switch(indexCalendarListener){
                      case 0: return ScrollablePositionedList.separated(
                        separatorBuilder: (context, index){
                          return const SizedBox(height: 20,);
                        },
                        physics: const ClampingScrollPhysics(),
                        initialScrollIndex: monthCalendarListener,
                        itemCount: 15,
                        itemBuilder: (context, index){
                          return index <= 11
                          ? CalendarMonthView(
                            month: index + 1,
                            year: yearCalendarListener,
                            scrolling: true,
                          )
                          : const CalendarMonthViewBlank();
                        },
                        itemScrollController: itemScrollController,
                        itemPositionsListener: itemPositionsListener,
                      );
                      case 1: return buildYearMonths();
                    }
                  }()),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
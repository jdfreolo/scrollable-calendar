/// Calculates the number of days in a month
int getDaysInMonth(int year, int month) {
  return month < DateTime.monthsPerYear ? DateTime(year, month + 1, 0).day : DateTime(year + 1, 1, 0).day;
}


/// Calculates the date difference between the date provided and the current date
bool calculateDateDifference(DateTime date) {
  DateTime now = DateTime.now();
  if(DateTime(date.year, date.month, date.day).difference(DateTime(now.year, now.month, now.day)).inDays > 0){
    return true;
  }else{
    return false;
  }
}
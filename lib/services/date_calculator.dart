int getDaysInMonth(int year, int month) {
  return month < DateTime.monthsPerYear ? DateTime(year, month + 1, 0).day : DateTime(year + 1, 1, 0).day;
}

bool calculateDateDifference(DateTime date) {
  DateTime now = DateTime.now();
  if(DateTime(date.year, date.month, date.day).difference(DateTime(now.year, now.month, now.day)).inDays > 0){
    return true;
  }else{
    return false;
  }
}
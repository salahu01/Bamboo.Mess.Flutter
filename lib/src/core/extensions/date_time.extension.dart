

extension DateTimeX on DateTime {
  //* get Months
  List<String> get _months => ['January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December'];

  //* get days
  List<String> get _days => ['Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday'];

  //* find month in string
  String get monthToString => _months[month];

  //* find day
  String get dayToString => _days[weekday - 1];

  //* convert date time for mongodb
  String get order => '$dayToString , $monthToString $day, $year ';

  //* find time
  String get findTime {
    final temp = toString().split(' ').last.split(':');
    if (num.parse(temp.first) > 12) {
      num reminder = num.parse(temp.first) % 12;
      if (reminder == 0) reminder = 12;
      return '${reminder < 10 ? reminder : '0$reminder'}:${temp[1].trim()} PM';
    }
    return '${temp.first.trim()}:${temp[1].trim()} AM';
  }
}

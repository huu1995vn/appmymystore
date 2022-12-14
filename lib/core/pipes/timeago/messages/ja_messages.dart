import 'lookupmessages.dart';

class JaMessages implements LookupMessages {
  @override
  String prefixAgo() => '';
  @override
  String prefixFromNow() => '今から';
  @override
  String suffixAgo() => '前';
  @override
  String suffixFromNow() => '後';
  @override
  String lessThanOneMinute(int seconds) => '1分未満';
  @override
  String aboutAMinute(int minutes) => '約1分';
  @override
  String minutes(int minutes) => '$minutes分';
  @override
  String aboutAnHour(int minutes) => '約1時間';
  @override
  String hours(int hours) => '約$hours時間';
  @override
  String aDay(int hours) => '約1日';
  @override
  String days(int days) => '約$days日';
  @override
  String aboutAMonth(int days) => '約1か月';
  @override
  String months(int months) => '約$monthsか月';
  @override
  String aboutAYear(int year) => '約1年';
  @override
  String years(int years) => '約$years年';
  @override
  String wordSeparator() => '';
}

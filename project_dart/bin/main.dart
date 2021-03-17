import 'Service/TimeService.dart';
import 'models/Time.dart';

void main(List<String> arguments) async {
  var times = List<Time>.generate(
    5,
    (index) => Time(
      id: index,
      fieldId: 5,
      userId: null,
      startTime: 'Start:$index',
      endTime: 'End:$index',
      status: false,
    ),
  );
  var index = 1;
  var userId = 99;

  var _time = Time();
  _time.id = times[index].id;
  _time.fieldId = times[index].fieldId;
  _time.userId = userId;
  _time.startTime = times[index].startTime;
  _time.endTime = times[index].endTime;
  _time.status = true;

  times[index] = _time;
  print(times);
  // print(_time);

}

String setTime(String hour, String minute) {
  var stlDt = '0001-01-01 $hour:$minute:04Z';
  var time = DateTime.parse(stlDt);
  return '${time.hour}:${time.minute}:00';
}

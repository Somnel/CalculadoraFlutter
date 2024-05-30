import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';


class WorldTime {

  String location;
  String? time;
  String flag;
  String url;
  bool? isDaytime;


  WorldTime({ required this.location, required this.flag, required this.url});

  Future<void> getTime() async {
    try {
      // Make the request
      Response response = await get(Uri.parse('http://worldtimeapi.org/api/timezone/$url'));
      Map data = jsonDecode(response.body);

      // get properties from data
      String datetime = data['datetime'];
      String offset = data['utc_offset'].substring(0, 3);

      // create DateTime object
      DateTime now = DateTime.parse(datetime);
      now = now.add(Duration(hours: int.parse(offset)));

      // set the time property
      isDaytime = now.hour > 6 && now.hour < 20;
      time = DateFormat.jm().format(now);
    } catch(e) {
      print('Caused Error: $e');
      time = 'could not get time data';
    }

  }
}



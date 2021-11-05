import 'package:gemini/services/helper.dart';

getDailyCheckin(Map<String, dynamic> data) {
  return makeHttpRequest('user/get-daily-checkin', 'get', data);
}

dailyCheckin(Map<String, dynamic> data) {
  return makeHttpRequest('user/daily-checkin', 'post', data);
}
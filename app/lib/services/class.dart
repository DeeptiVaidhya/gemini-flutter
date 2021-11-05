import 'package:gemini/services/helper.dart';

getClassList(Map<String, dynamic> data) {
  return makeHttpRequest('course/class-list', 'post', data);
}

getClassDetails(Map<String, dynamic> data) {
  return makeHttpRequest('course/class-detail', 'post', data);
}

practiceDetails(Map<String, dynamic> data) {
  return makeHttpRequest('course/practice-detail', 'post', data);
}

updateClassTask(Map<String, dynamic> data) {
  return makeHttpRequest('course/update-class-task', 'post', data);
}

updatePracticeContent(Map<String, dynamic> data) {
  return makeHttpRequest('course/update-practice-content', 'post', data);
}
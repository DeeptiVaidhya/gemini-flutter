import 'package:gemini/services/helper.dart';

getLearningTopicsPost(Map<String, dynamic> data) {
  return makeHttpRequest('course/topic_list', 'post', data);
}

getLearningTopicsDetailsPost(Map<String, dynamic> data) {
  return makeHttpRequest('course/topic_detail', 'post', data);
}
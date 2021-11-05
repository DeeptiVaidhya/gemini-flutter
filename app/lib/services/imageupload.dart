import 'package:gemini/services/helper.dart';

imageupload(Map<String, dynamic> data) {
  return makeHttpRequest('auth/upload-profile-picture', 'post', data);
}
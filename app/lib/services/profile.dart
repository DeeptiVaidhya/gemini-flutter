import 'package:gemini/services/helper.dart';

getUserProfile(Map<String, dynamic> data) {
  return makeHttpRequest('user/user_detail', 'post', data);
}

editUserProfile(Map<String, dynamic> data) {
  return makeHttpRequest('auth/profile', 'post', data);
}

getPublicProfile(Map<String, dynamic> data) {
  return makeHttpRequest('user/public-profile', 'post', data);
}

uploadProfile(Map<String, dynamic> data) {
  return makeHttpRequest('auth/upload-profile-picture', 'post', data);
}


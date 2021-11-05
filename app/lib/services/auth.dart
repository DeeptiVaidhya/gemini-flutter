import 'package:gemini/services/helper.dart';

signIn(Map<String, dynamic> data) {
  return makeHttpRequest('auth/login', 'post', data);
}

checkLogin(Map<String, dynamic> data) {
  return makeHttpRequest('auth/check_login', 'post', data);
}

signUp(Map<String, dynamic> data) {
  return makeHttpRequest('auth/signup', 'post', data);
}

checkAccessCode(Map<String, dynamic> data) {
  return makeHttpRequest('auth/check-access-link', 'post', data);
}

checkEntryExistence(Map<String, dynamic> data) {
  return makeHttpRequest('auth/entry-existence', 'post', data);
}

getTimeZone(Map<String, dynamic> data) {
  return makeHttpRequest('auth/time-zones', 'get', data);
}

resetPassword(Map<String, dynamic> data) {
  return makeHttpRequest('auth/reset-password', 'post', data);
}

checkresetPasswordCode(Map<String, dynamic> data) {
  return makeHttpRequest('auth/reset-password-code', 'post', data);
}

forgotPassword(Map<String, dynamic> data) {
  return makeHttpRequest('auth/forgot-password', 'post', data);
}

logout(Map<String, dynamic> data) {
  return makeHttpRequest('auth/logout', 'get', data);
}





import 'package:gemini/services/helper.dart';

getDiscussionPost(Map<String, dynamic> data) {
  return makeHttpRequest('post/discussion-topics', 'get', data);
}

getBuddies(Map<String, dynamic> data) {
  return makeHttpRequest('post/buddies', 'post', data);
}

getDashboardDetails(Map<String, dynamic> data){
  return makeHttpRequest('user/participant-dashboard', 'get', data);
}

buddyInvite(Map<String, dynamic> data) {
  return makeHttpRequest('post/buddy-invite', 'post', data);
}

messageNotification(Map<String, dynamic> data){
  return makeHttpRequest('message/message-notification', 'get', data);
}

message(Map<String, dynamic> data){
  return makeHttpRequest('message/buddy-message', 'get', data);
}

sendMessage(Map<String, dynamic> data){
  return makeHttpRequest('message/add-message', 'post', data);
}

acceptRequest(Map<String, dynamic> data) {
  return makeHttpRequest('post/invite-update-status', 'post', data);
}

contactUs(Map<String, dynamic> data) {
  return makeHttpRequest('auth/contact_us', 'post', data);
}

messageDetails(Map<String, dynamic> data){
  return makeHttpRequest('message/buddy-message', 'post', data);
}

getWeeklyCheckin(Map<String, dynamic> data){
  return makeHttpRequest('user/get-weekly-checkin', 'post', data);
}

weeklyCheckin(Map<String, dynamic> data){
  return makeHttpRequest('user/weekly-checkin', 'post', data);
}

getVirtualVisits(Map<String, dynamic> data){
  return makeHttpRequest('course/get-virtual-visits', 'get', data);
}

courseClassDetail(Map<String, dynamic> data){
  return makeHttpRequest('course/class-detail', 'post', data);
}

getPracticeLog(Map<String, dynamic> data){
  return makeHttpRequest('course/get-practice-log', 'get', data);
}


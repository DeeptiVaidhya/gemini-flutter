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



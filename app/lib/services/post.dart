import 'package:gemini/services/helper.dart';

addPost(Map<String, dynamic> data) {
  return makeHttpRequest('post/add-post', 'post', data);
}

getPost(Map<String, dynamic> data) {
  return makeHttpRequest('post/journal_posts', 'post', data);
}

getPostList(Map<String, dynamic> data) {
  return makeHttpRequest('post/posts', 'post', data);
}

getPostReply(Map<String, dynamic> data) {
  return makeHttpRequest('post/post-and-reply', 'post', data);
}

getPostDetails(Map<String, dynamic> data) {
  return makeHttpRequest('post/post-details', 'post', data);
}

likeUnlikePost(Map<String, dynamic> data) {
  return makeHttpRequest('post/post-like', 'post', data);
}

followPosts(Map<String, dynamic> data) {
  return makeHttpRequest('post/post-follow', 'post', data);
}

deletePost(Map<String, dynamic> data){
  return makeHttpRequest('post/delete-post', 'post', data);
}
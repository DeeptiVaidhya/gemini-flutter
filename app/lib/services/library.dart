import 'package:gemini/services/helper.dart';

getLibraryList(Map<String, dynamic> data) {
  return makeHttpRequest('resource/library-list', 'post', data);
}

getLibraryFilterMenu(Map<String, dynamic> data) {
  return makeHttpRequest('resource/libary-filter-menu', 'get', data);
}

favUnfavoritePost(Map<String, dynamic> data) {
  return makeHttpRequest('resource/library-favorite', 'post', data);
}
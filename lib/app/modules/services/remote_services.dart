import 'dart:convert';

import 'package:http/http.dart' as http;

import '../home/models/post.dart';

class RemoteService {
  // Future<List<Post>?> getPosts() async {
  Future<Post?> getPosts() async {
    var client = http.Client();

    var uri = Uri.parse(
        'http://mirror.ccjjj.com/xcxapi/teacher/action_info?action_id=43&uid=777');
    var response = await client.post(uri);

    if (response.statusCode == 200) {
      var str = response.body;
      // print("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~" + str.runtimeType.toString());
      Post res = postFromJson(str);
      // print("~~~~~~~~~~~~~~~~~~~~~~~~~~${res.code}");
      // print('------------------------success_api---------------------------');
      return res;
      // return res;
      // var post = postFromJson(json);
      // return post?.result ??
      //     []; // Return the list of results from the Post object or an empty list if null
    } else {
      print(
          '!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!failed_api!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!');
      return null; // or an empty list: return [];
    }
  }
}

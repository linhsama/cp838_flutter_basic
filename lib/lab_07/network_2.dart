import 'post.dart';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;


class Network {

  List<Post> parsePost(String response){
    var list = json.decode(response) as List<dynamic>;
    List<Post> posts = list.map((e)=>Post.fromJson(e)).toList();
    return posts;
  }

  Future<List<Post>> fetchPost() async{
    var url = Uri.parse("https://jsonplaceholder.typicode.com/posts");
    final response = await http.get(url);
    if(response.statusCode == 200){
      return compute(parsePost, response.body);
    }else{
      throw Exception("Get API failed:");
    }
  }
}
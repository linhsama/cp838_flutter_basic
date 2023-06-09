import 'Photo.dart';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;


class Network {

  List<Photo> parsePhoto(String response){
    var list = json.decode(response) as List<dynamic>;
    List<Photo> Photos = list.map((e)=>Photo.fromJson(e)).toList();
    return Photos;
  }

  Future<List<Photo>> fetchPhoto() async{
    var url = Uri.parse("https://jsonplaceholder.typicode.com/photos");
    final response = await http.get(url);
    if(response.statusCode == 200){
      return compute(parsePhoto, response.body);
    }else{
      throw Exception("Get API failed:");
    }
  }
}
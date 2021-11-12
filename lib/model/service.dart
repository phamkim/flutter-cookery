import 'dart:convert';
import 'package:food/controller/category.dart';
import 'package:food/controller/food.dart';
import "package:http/http.dart" as http;

class Api {

  static Future<List<Food>> fetchFood(String source) async {
    var url = 'http://192.168.88.105:38328/api/?source=$source';
    final response = await http.get(Uri.encodeFull(url));
    if (response.statusCode == 200) {
      final resultJson = jsonDecode(response.body)['data'];
      final parsed = resultJson.cast<Map<String, dynamic>>();
      return parsed.map<Food>((json) => Food.fromJson(json)).toList();
    } else {
      return null;
    }
  }

  static Future<List<Category>> fetchCategory() async {
    var url = 'http://192.168.88.105:38328/api/categoris';
    final response = await http.get(Uri.encodeFull(url));
    if (response.statusCode == 200) {
      final resultJson = jsonDecode(response.body)['data'];
      final parsed = resultJson.cast<Map<String, dynamic>>();
      return parsed.map<Category>((json) => Category.fromJson(json)).toList();
    } else {
      return null;
    }
  }

  static Future<List<Component>> fetchComponent(String source,String name) async {
    var url = 'http://192.168.88.105:38328/api/search?name=$name&source=$source';
    final response = await http.get(Uri.encodeFull(url));
    if (response.statusCode == 200) {
      final resultJson = jsonDecode(response.body)['data'][0]['components'];
      final parsed = resultJson.cast<Map<String, dynamic>>();
      return parsed.map<Component>((json) => Component.fromJson(json)).toList();
    } else {
      return null;
    }
  }

  static Future<List<dynamic>> fetchName(String source) async {
    var url = 'http://192.168.88.105:38328/api/name?&source=$source';
    final response = await http.get(Uri.encodeFull(url));
    if (response.statusCode == 200) {
      final resultJson = jsonDecode(response.body)['data'] as List;
      return resultJson;
    } else {
      return null;
    }
  }

  static Future<List<Food>> getFood(String source,String name) async {
    var url = 'http://192.168.88.105:38328/api/search?name=$name&source=$source';
    final response = await http.get(Uri.encodeFull(url));
    if (response.statusCode == 200) {
      final resultJson = jsonDecode(response.body)['data'];
      final parsed = resultJson.cast<Map<String, dynamic>>();
      return parsed.map<Food>((json) => Food.fromJson(json)).toList();
    } else {
      return null;
    }
  }
}

import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiService{
  static const String baseUrl = "https://jsonplaceholder.typicode.com";

Future<List<dynamic>> fetchData() async{
  try{
    const url = "$baseUrl/posts";
    final response = await http.get(Uri.parse(url));
    if(response.statusCode == 200){
      return jsonDecode(response.body);
    }else{
      throw Exception("Failed to load data ${response.statusCode}");
    }
  }catch(e){
    throw Exception("Error: $e");
  }
  }
}
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:project1/src/services/utilities/app_url.dart';


class ProductService{
  Future<List<dynamic>> getProductList () async {

    final response = await http.get(Uri.parse(AppUrl.productList));
    var   data = jsonDecode(response.body.toString());
    if(response.statusCode == 200){
print("hihi123");
      return data;

    }else{
      print("object");

      throw Exception('Error');
    }
  }
}
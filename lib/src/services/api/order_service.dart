import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:project1/src/services/utilities/app_url.dart';


class OrderProvider{

  Future<List<dynamic>> getListOrder (String id) async {
      Map<String, String> body = {'id': id};
      http.Response response = await http.post(
          Uri.parse(AppUrl.getListOrder),
          body: body);
      if(response.statusCode == 200){
        var data = jsonDecode(response.body.toString());
        return data;
      }else{
        throw Exception('Error');
      }
  }

  Future<dynamic> getDetailOrder (String order_id) async {
    Map<String, String> body = {'order_id': order_id};
    final response = await http.post(
        Uri.parse(AppUrl.getDetailOrder),
        body: body);
    if(response.statusCode == 200){
      var data = jsonDecode(response.body.toString());
      return data;
    }else{
      throw Exception('Error');
    }
  }
}
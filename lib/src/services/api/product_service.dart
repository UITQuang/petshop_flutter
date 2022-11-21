import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:project1/src/services/utilities/app_url.dart';

import '../../models/product_model.dart';
import '../../models/product_detail.dart';


class ProductService{
  Future<List<dynamic>> getProductList () async {

    final response = await http.get(Uri.parse(AppUrl.productList));
    var   data = jsonDecode(response.body.toString());
    if(response.statusCode == 200){
      return data;

    }else{
      throw Exception('Error');
    }
  }
  Future<List<dynamic>> getCategoryList () async {

    final response = await http.get(Uri.parse(AppUrl.categoryList));
    var   data = jsonDecode(response.body.toString());
    if(response.statusCode == 200){

      return data;

    }else{
      throw Exception('Error');
    }
  }

  Future<ProductDetail> getDetailProduct (int id) async {
    final response = await http.get(Uri.parse(AppUrl.detailProduct+id.toString()));
    if(response.statusCode == 200){
      var data = jsonDecode(response.body);
      ProductDetail product = ProductDetail.fromJson(data);
      return product;
    }else{
      throw Exception('Error');
    }
  }
}

class NoticeProvider{
  Future<List<dynamic>> getNoticeList () async {
    final response = await http.get(Uri.parse("https://meowmeowpetshop.xyz/api/v1/notice?notice_type=notify"));
    var   data = jsonDecode(response.body.toString());
    if(response.statusCode == 200){
      return data;
    }else{
      throw Exception('Error');
    }
  }

  Future<dynamic> getBannerList () async {
    final response = await http.get(Uri.parse("https://meowmeowpetshop.xyz/api/v1/notice?notice_type=banner"));
    if(response.statusCode == 200){
      var data = jsonDecode(response.body.toString());
      return data;
    }else{
      throw Exception('Error');
    }
  }

}
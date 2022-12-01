import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:project1/src/services/utilities/app_url.dart';

class VoucherService {
  Future<List<dynamic>> getVoucherList() async {
    http.Response response = await http.get(Uri.parse(AppUrl.getVoucherList));
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body.toString());
      return data;
    } else {
      throw Exception('Error');
    }
  }

  Future<List<dynamic>> getVoucherUser(String id_user) async {
    Map<String, String> body = {'id_user': id_user};
    http.Response response =
        await http.post(Uri.parse(AppUrl.getVoucherOfUser), body: body);
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body.toString());
      return data;
    } else {
      throw Exception('Error');
    }
  }

  Future<void> removeVoucher(String id_user, String id_voucher) async {
    await http.post(Uri.parse(AppUrl.removeVoucherOfUser),
        body: {'id_user': id_user, 'id_voucher': id_voucher});
  }

  Future<dynamic> getInfoRank(String id_user) async {
    Map<String, String> body = {'id_user': id_user};
    http.Response response =
        await http.post(Uri.parse(AppUrl.getInfoRank), body: body);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body.toString());
      return data;
    } else {
      throw Exception('Error');
    }
  }

  Future<bool> redeemVoucher(String id_user, String id_voucher) async {
    Map<String, String> body = {'id_user': id_user, 'id_voucher': id_voucher};
    http.Response response =
        await http.post(Uri.parse(AppUrl.redeemVoucher), body: body);
    if (response.statusCode == 200) {
      return true;
    } else {
      throw false;
    }
  }
}

import 'dart:convert';

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../global.dart';

class ApiProviders extends GetxController{


  onPageStart()async{
    await getUser();
    await fetchData();
  }

  var ourProducts = [].obs;
  var suggested = [].obs;
  var best_seller = [].obs;
  var categories = [].obs;
  var banner1 = [].obs;
  var banner2 = [].obs;
  var cartCount = 0.obs;

  var id = ''.obs;
  var token = ''.obs;
  Future<void> getUser() async {
    final response = await http.post(Uri.parse('$serurl/api/login?email_phone=8547541134&password=12345678'),
    );
    print("status code  : ${response.statusCode}");
    if(response.statusCode == 200){
      var items = json.decode(response.body);
      id.value = items['customerdata']['id'];
      token.value = items['customerdata']['token'];
    }
  }
  Future<void> fetchData() async {
    final response = await http.post(Uri.parse('$serurl/api/home?id=${id.value}&token=${token.value}'),
    );
    print("status code  : ${response.statusCode}");
    if(response.statusCode == 200){
      var items = json.decode(response.body);
      ourProducts.value = items['our_products'];
      suggested.value = items['suggested_products'];
      best_seller.value = items['best_seller'];
      categories.value = items['categories'];
      banner1.value = items['banner1'];
      banner2.value = items['banner2'];
      cartCount.value = items['cartcount'];
    }
  }






}
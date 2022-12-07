import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodiez_frontent/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

class AuthProvider extends ChangeNotifier {
  String? username;

  Future<String?> register({
    required String username,
    required String password,
  }) async {
    try {
      var response = await Client.dio.post("/signin", data: {
        'username': username,
        'password': password,
      });

      var access = response.data["access"];
      Client.dio.options.headers["authorization"] = "Bearer $access";
      this.username = username;
      notifyListeners();
      var pref = await SharedPreferences.getInstance();
      await pref.setString('access', access);
      print("Registered Successfully");
      return null;
    } on DioError catch (error) {
      // print(error.response!.data);
      if (error.response != null &&
          error.response!.data != null &&
          error.response!.data is Map) {
        var map = error.response!.data as Map;
        return map.values.first.first;
      }
    } catch (error) {
      print(error);
      return "$error";
    }
    return "unknown error occured";
  }

  Future<String?> login({
    required String username,
    required String password,
  }) async {
    this.username = username;
    notifyListeners();
  }

  Future<void> logout() async {
    this.username = null;
    notifyListeners();
  }
}



//    try{
//       var response=await Client.dio.post("/register",data:{
//         "username":username,
//       "password":password,});
//     }
//   }

// var token=response.data["token"];
// Client.dio.options.headers["Authorization"]="Bearer $token";

// }
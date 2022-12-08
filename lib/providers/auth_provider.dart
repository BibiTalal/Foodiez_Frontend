import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodiez_frontent/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

class AuthProvider extends ChangeNotifier {
  String? username;

  Future<bool> register({
    required String username,
    required String password,
  }) async {
    try {
      var response =
          await Client.dio.post("http://10.0.2.2:8000/register/", data: {
        'username': username,
        'password': password,
      });

      var token = response.data["access"];

      Client.dio.options.headers[HttpHeaders.authorizationHeader] =
          "Bearer $token";
      this.username = username;
      notifyListeners();

      var pref = await SharedPreferences.getInstance();
      await pref.setString("token", token);
      print('register successfully');
      return true;
    } on DioError catch (e) {
      print(e.response!.data);
    } catch (e) {
      print("Unknown Error");
    }

    return false;
  }

  // Future<bool> register({
  //   required String username,
  //   required String password,
  // }) async {
  //   try {
  //     var response =
  //         await Client.dio.post("http://10.0.2.2:8000/register/", data: {
  //       'username': username,
  //       'password': password,
  //     });

  //     var access = response.data["access"];
  //     Client.dio.options.headers[HttpHeaders.authorizationHeader] =
  //         "Bearer $access";
  //     this.username = username;
  //     notifyListeners();
  //     var pref = await SharedPreferences.getInstance();
  //     await pref.setString('access', access);
  //     print("Registered Successfully");
  //     return true;
  //   } on DioError catch (error) {
  //     print(error.response!.data);
  //     // if (error.response != null &&
  //     //     error.response!.data != null &&
  //     //     error.response!.data is Map) {
  //     //   var map = error.response!.data as Map;
  //     //   return map.values.first.first;
  //     // }
  //   } catch (error) {
  //     print("unknown error");
  //   }
  //   return false;
  // }

  Future<bool> login(
      {required String username, required String password}) async {
    late String access;
    try {
      Response response =
          await Client.dio.post("http://10.0.2.2:8000/signin/", data: {
        "username": username,
        "password": password,
      });
      access = response.data["access"];
      Client.dio.options.headers["Authorization"] = "Bearer $access";
      var ref = await SharedPreferences.getInstance();
      ref.setString("access", access);
      this.username = username;
      notifyListeners();
      return true;
    } on DioError catch (error) {
      print(error);
    }
    notifyListeners();

    return false;
  }

  Future<bool> hasaccess() async {
    var pref = await SharedPreferences.getInstance();
    var access = pref.getString("access");

    if (access == null || JwtDecoder.isExpired(access)) {
      print('No access'); // for testing
      return false;
    }

    var accessMap = JwtDecoder.decode(access);
    username = accessMap['username'];
    notifyListeners();
    // to test
    print(username);
    return true;
  }

  void logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove("access");
    //test
    this.hasaccess();
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
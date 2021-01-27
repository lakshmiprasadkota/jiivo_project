import 'package:dio/dio.dart';
import 'package:jiovii_fullapp/network/base_response.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../base_network.dart';


class AuthManager {
  Future<ResponseData> createLoginToken(Map<String, dynamic> data) async {
    FormData formData = FormData.fromMap(data);
   try{
     Response response = await dioClient.tokenRef.post("/api/login", data: formData);
     if (response?.statusCode == 200) {
       SharedPreferences prefs = await SharedPreferences.getInstance();
       if (response.data['status']) {
         prefs.setString("token", response.data['token']);
         print(response);
         return ResponseData("", ResponseStatus.SUCCESS,
             data: response.data);

       } else {
         return ResponseData(response.data['message'], ResponseStatus.FAILED);
       } }
     else {
       return ResponseData("Failed to get data", ResponseStatus.FAILED);
     }
   }
   catch(err){
     return ResponseData("No Internet", ResponseStatus.FAILED);
   }
  }

  Future<ResponseData> createSignUpToken(Map<String, dynamic> data) async {
    FormData formData = FormData.fromMap(data);
    try{
      Response response = await dioClient.tokenRef.post("/api/signup", data: formData);
      if (response?.statusCode == 200) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        if (response.data['status']) {
          prefs.setString("token", response.data['token']);
          print(response);
          return ResponseData("", ResponseStatus.SUCCESS,
              data: response.data);

        } else {
          return ResponseData(response.data['message'], ResponseStatus.FAILED);
        } }
      else {
        return ResponseData("Failed to get data", ResponseStatus.FAILED);
      }
    }
    catch(err){
      return ResponseData("No Internet", ResponseStatus.FAILED);
    }
  }
}

final authManager = AuthManager();




import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../base_network.dart';
import '../base_response.dart';


class VerificationManager {
  Future<ResponseData> createVerification(Map<String, dynamic> data) async {
    FormData formData = FormData.fromMap(data);
    try {
      Response response =
      await dioClient.ref.post("/api/otp/validate",
          data:  formData
      );
      if (response?.statusCode == 200) {

        if (response.data['status']) {

          print(response);
          return ResponseData("", ResponseStatus.SUCCESS,
              data: response.data);
        } else {
          return ResponseData(response.data['message'], ResponseStatus.FAILED);
        }
      }
      else {
        return ResponseData("Failed to get data", ResponseStatus.FAILED);
      }
    }
    catch (err) {
      return ResponseData("No Internet", ResponseStatus.FAILED);
    }
  }

}

final verificationManager = VerificationManager();
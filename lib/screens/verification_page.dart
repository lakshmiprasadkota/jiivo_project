import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:jiovii_fullapp/extension_page.dart';
import 'package:jiovii_fullapp/network/base_network.dart';
import 'package:jiovii_fullapp/network/base_response.dart';
import 'package:jiovii_fullapp/network/logins/verification_manager.dart';
import 'package:jiovii_fullapp/screens/login_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'homepage.dart';

class VerificationPage extends StatefulWidget {
  VerificationPage({this.tk});
   final String tk ;
  @override
  _VerificationPageState createState() => _VerificationPageState();
}

class _VerificationPageState extends State<VerificationPage> {
  bool loading = false;
  dynamic res;
  final numberController = TextEditingController();

  Future<void> performVerification() async {
    String number = numberController.text.trim();

    if (number.isEmpty) {
      Fluttertoast.showToast(msg: "Invalid Number");
      return;
    }

    setState(() {
      loading = true;
    });
    Map<String, dynamic> data ={
      "otp": number,

    };
    SharedPreferences prefs= await SharedPreferences.getInstance();
    String token = prefs.get("token");
    ResponseData responseData =
    await verificationManager.createVerification(data);
    print(token);
    setState(() {
      res = responseData.data;
      loading = false;
    });
    if  (responseData.status == ResponseStatus.SUCCESS) {

      Navigator.push(
          context, MaterialPageRoute(builder: (context) => Homepage()));
    } else {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => LoginPage()));
      print(responseData.data['message']);
    }
    print("response --->${responseData}");
    print("otp--${number}");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: Container(
        margin: EdgeInsets.symmetric(vertical: 191, horizontal: 25),
        child: Column(
          children: [
            Text("Verification", style: TitleStyle),
            SizedBox(
              height: 15,
            ),
            Flexible(
                child: Text(
              "6 - Digit PIN has been sent to your phone, ",
              style: TextStyle(color: Color(0xff9FA5BB), fontSize: 14),
            )),
            SizedBox(
              height: 3,
            ),
            Flexible(
                child: Text("enter it below to continue.",
                    style: TextStyle(color: Color(0xff9FA5BB), fontSize: 14))),

            SizedBox(
              height: 63,
            ),
            // PinCodeTextField(
            //   length: 6,
            //   obscureText: false,
            //   animationType: AnimationType.fade,
            //   pinTheme: PinTheme(
            //     shape: PinCodeFieldShape.box,
            //     borderRadius: BorderRadius.circular(5),
            //     fieldHeight: 50,
            //     fieldWidth: 40,
            //     activeFillColor: Colors.white,
            //   ),
            //   animationDuration: Duration(milliseconds: 300),
            //   backgroundColor: Colors.blue.shade50,
            //   enableActiveFill: true,
            //
            //   controller: numberController,
            //   onCompleted: (v) {
            //     print("Completed");
            //   },
            //   onChanged: (value) {
            //     print(value);
            //     setState(() {
            //
            //     });
            //   },
            //   beforeTextPaste: (text) {
            //     print("Allowing to paste $text");
            //     //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
            //     //but you can show anything you want here, like your pop up saying wrong paste format or etc
            //     return true;
            //   },
            // ),

            TextField(
              controller: numberController,
            ),

            SizedBox(
              height: 30,
            ),
            if (loading)
              Center(
                child: CircularProgressIndicator(),
              )
            else
              InkWell(
                onTap: () {
                  setState(() {
                    performVerification();
                  });
                },
                child: Container(
                  height: 50,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Color(0xffFF8701),
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                            color: Color(0x1333B83FC),
                            offset: Offset(0, 5),
                            blurRadius: 10)
                      ]),
                  child: Center(
                    child: Text(
                      "Confirm",
                      style: botton,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

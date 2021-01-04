

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import 'jiivo_Page.dart';

class VerificationPage extends StatefulWidget {
  @override
  _VerificationPageState createState() => _VerificationPageState();
}

class _VerificationPageState extends State<VerificationPage> {
  bool hidepassword = false;

  bool loading = false;

  dynamic res;

  final  numberController = TextEditingController();



  Future<void> performLogin() async{
    String number = numberController.text.trim();


    // if (number.isEmpty || number.length < 13) {
    //   Fluttertoast.showToast(msg: "Invalid Number");
    //   return;
    // }

    setState(() {
      loading = true;
    });
    FormData formData = FormData.fromMap({
      "otp": "12345",

    });
    Response response =
    await Dio().post("https://networkintern.herokuapp.com/api/otp/validate",
        data: formData,
        options: Options(
          validateStatus: (status) => status < 500,
        ));
    setState(() {
      res = response.data;
      loading = false;
    });
    if (response.data['status']) {

      Navigator.push(context, MaterialPageRoute(
          builder: (context) =>  Homepage()));
    }
    else{
      Fluttertoast.showToast(msg: response.data['message']);
      print(response.data['message']);
    }
    print(response);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: Container(
        margin: EdgeInsets.symmetric(vertical: 191 , horizontal: 25),
        child: Column(
          children: [
            Text("Verification" , style: TextStyle(color: Color(0xff2E3748) ,
                fontSize: 35, fontWeight: FontWeight.w400),),
            SizedBox(height: 15,),
            Flexible(child: Text("6 - Digit PIN has been sent to your phone, " ,style: TextStyle(color: Color(0xff9FA5BB) ,
                fontSize: 14 ),)),
            SizedBox(height: 3,),
            Flexible(child: Text("enter it below to continue.",style: TextStyle(color: Color(0xff9FA5BB) ,fontSize: 14))),

            SizedBox(height: 63,),
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
              controller:  numberController,
            ) ,

            SizedBox(height: 30,),
            if (loading)
              Center(
                child: CircularProgressIndicator(),
              )
            else
              Container(
                height: 50,
                width: double.infinity,
                decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                          color: Color(0x333B83FC),
                          offset: Offset(0, 5),
                          blurRadius: 10
                      )
                    ]
                ),
                child: RaisedButton(onPressed: (){
                  setState(() {
                    performLogin();
                  });
                } ,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    color: Color(0xffFF8701),
                    child: Text("Confirm" , style: TextStyle(color: Color(0xFFFFFFFF) ,
                        fontSize: 14),)),
              ),
          ],
        ),
      ),
    );
  }
}



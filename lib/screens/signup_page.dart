import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:jiovii_fullapp/extension_page.dart';
import 'package:jiovii_fullapp/network/base_network.dart';
import 'file:///D:/FlutterProjects/jiovii_fullapp/lib/Screens/verification_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:jiovii_fullapp/network/base_response.dart';
import 'package:jiovii_fullapp/network/logins/login_manager.dart';


class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  bool hidePassword = false;
  bool loading = false;
  dynamic res;
  final numberController = TextEditingController();
  final passwordController = TextEditingController();
  final emailController = TextEditingController();
  final nameController = TextEditingController();

  Future<void> performSignUp() async {
    String number = numberController.text.trim();
    String password = passwordController.text.trim();
    String name = nameController.text.trim();
    String email = emailController.text.trim();

    if (number.isEmpty || number.length < 13) {
      Fluttertoast.showToast(msg: "Invalid Number");
      return;
    }
    if (password.isEmpty) {
      Fluttertoast.showToast(msg: "Invalid password");
      return;
    }
    setState(() {
      loading = true;
    });
    Map<String, dynamic> data ={
      "mobile": number,
      "password": password,
      "name": name,
      "email": email,
    };


    ResponseData responseData = await authManager.createSignUpToken(data);
    setState(() {
      res = responseData.data;
      loading = false;
    });
    if (responseData.status == ResponseStatus.SUCCESS) {

      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => VerificationPage(

          ),
        ),
      );
    } else {
      Fluttertoast.showToast(msg: responseData.message);
      print(responseData.data['message']);
    }
    print(responseData);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 226, horizontal: 25),
          child: Column(
            children: [
              Container(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Sign In",
                    style: TitleStyle,
                  )),
              SizedBox(
                height: 19,
              ),
              Container(
                child: TextField(
                  controller: nameController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                      isDense: true,
                      hintText: "Denom Josh",
                      hintStyle: hint,
                      labelText: "Name",
                      labelStyle:
                          TextStyle(color: Color(0xffFF8701), fontSize: 12),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide:
                              BorderSide(color: Color(0xffFF8701), width: 2)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide:
                              BorderSide(color: Color(0xffFF8701), width: 2))),
                ),
              ),
              SizedBox(
                height: 24,
              ),
              Container(
                child: TextField(
                  controller: emailController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                      isDense: true,
                      hintText: "Denom@108",
                      hintStyle: hint,
                      labelText: "E-mail",
                      labelStyle:
                          TextStyle(color: Color(0xffFF8701), fontSize: 12),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide:
                              BorderSide(color: Color(0xffE3EAF2), width: 2)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide:
                              BorderSide(color: Color(0xffFF8701), width: 2))),
                ),
              ),
              SizedBox(
                height: 24,
              ),
              Container(
                child: TextField(
                  controller: numberController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                      isDense: true,
                      hintText: "+91",
                      hintStyle: hint,
                      labelText: "Number",
                      labelStyle:
                          TextStyle(color: Color(0xffFF8701), fontSize: 12),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide:
                              BorderSide(color: Color(0xffE3EAF2), width: 2)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide:
                              BorderSide(color: Color(0xffFF8701), width: 2))),
                ),
              ),
              SizedBox(
                height: 24,
              ),
              Container(
                child: TextField(
                  controller: passwordController,
                  keyboardType: TextInputType.text,
                  obscureText: hidePassword,
                  decoration: InputDecoration(
                      isDense: true,
                      suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              hidePassword = !hidePassword;
                            });
                          },
                          icon: Icon(hidePassword
                              ? Icons.visibility_off
                              : Icons.visibility)),
                      labelText: "Password",
                      labelStyle:
                          TextStyle(color: Color(0xffFF8701), fontSize: 12),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide:
                              BorderSide(color: Color(0xffE3EAF2), width: 2)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide:
                              BorderSide(color: Color(0xffFF8701), width: 2))),
                ),
              ),
              SizedBox(
                height: 35,
              ),
              if (loading)
                Center(
                  child: CircularProgressIndicator(),
                )
              else
                InkWell(
                  onTap: () {
                    setState(() {
                      performSignUp();
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
                              color: Color(0x1AFF8701),
                              offset: Offset(0, 5),
                              blurRadius: 10)
                        ]),
                    child: Center(
                      child: Text(
                        "Sign In",
                        style: botton,
                      ),
                    ),
                  ),
                ),
              SizedBox(
                height: 39,
              ),
              Text(
                "-OR-",
                style: TextStyle(
                    color: Color(0xff000000),
                    fontWeight: FontWeight.w600,
                    fontSize: 15),
              ),
              SizedBox(
                height: 19,
              ),
              Container(
                  alignment: Alignment.center,
                  height: 50,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      border: Border(
                        left: BorderSide(
                          color: Color(0xffE3EAF2),
                          width: 1.5,
                        ),
                        right: BorderSide(color: Color(0xffE3EAF2), width: 1.5),
                        top: BorderSide(color: Color(0xffE3EAF2), width: 1.5),
                        bottom:
                            BorderSide(color: Color(0xffE3EAF2), width: 1.5),
                      )),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(),
                      Row(
                        children: [
                          Image.asset(
                            "assets/images/g.png",
                            height: 20,
                            width: 20,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            "Sign Up with Google",
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: Color(0xff000000)),
                          )
                        ],
                      ),
                      Container(),
                    ],
                  )),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:jiovii_fullapp/network/base_network.dart';
import 'package:jiovii_fullapp/network/base_response.dart';
import 'package:jiovii_fullapp/network/logins/login_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'file:///D:/FlutterProjects/jiovii_fullapp/lib/Screens/signup_page.dart';
import 'file:///D:/FlutterProjects/jiovii_fullapp/lib/Screens/homepage.dart';
import '../extension_page.dart';


class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  FocusNode _focusNode;
  FocusNode _numberFocusNode;
  bool hidePassword = false;
  bool loading = false;
  dynamic res;
  final numberController = TextEditingController();
  final passwordController = TextEditingController();

  Future<void> performLogin() async {
    String number = numberController.text.trim();
    String password = passwordController.text.trim();

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
    Map<String, dynamic> data = {
      "mobile": number,
      "password": password,
    };


   ResponseData responseData =
    await  authManager.createLoginToken(data);
    setState(() {
      res = responseData.data;
      loading = false;
    });
    if (responseData.status == ResponseStatus.SUCCESS) {
      print(responseData.data['message']);
      print("----------------------------------------------------------------------/n"
          "----------------------------------------------------suscus");
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => Homepage()));
    } else {
      Fluttertoast.showToast(msg: responseData.message);
      print(responseData.data['message']);

    }
    print(responseData);

  }
  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _numberFocusNode = FocusNode();
  }

  @override
  void dispose() {
    _focusNode.dispose();
    _numberFocusNode.dispose();
    super.dispose();
  }

  _requestFocusPassword() {
    setState(() {
      FocusScope.of(context).requestFocus(_focusNode);
    });
  }

  _requestNumberFocus() {
    setState(() {
      FocusScope.of(context).requestFocus(_numberFocusNode);
    });
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
                    "Login In",
                    style: TitleStyle,
                  )),
              SizedBox(
                height: 19,
              ),
              Container(
                child: TextField(
                  focusNode: _numberFocusNode,
                  onTap: () {
                    _requestNumberFocus();
                  },
                  controller: numberController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                      isDense: true,
                      hintText: "+91",
                      hintStyle: hint,
                      labelText: "Number",
                      labelStyle: TextStyle(
                          color: _numberFocusNode.hasFocus
                              ? Color(0xffFF8701)
                              : Color(0xff97A6BA),
                          fontSize: 12,
                          fontWeight: FontWeight.bold),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide:
                              BorderSide(color: Color(0xffE3EAf2), width: 2)),
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
                  focusNode: _focusNode,
                  onTap: () {
                    _requestFocusPassword();
                  },
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
                          icon: Icon(
                            hidePassword
                                ? Icons.visibility_off
                                : Icons.visibility,
                            color: _focusNode.hasFocus
                                ? Color(0xffFF8701)
                                : Color(0xff97A6BA),
                          )),
                      labelText: "Password",
                      labelStyle: TextStyle(
                          color: _focusNode.hasFocus
                              ? Color(0xffFF8701)
                              : Color(0xff97A6BA),
                          fontSize: 12,
                          fontWeight: FontWeight.bold),
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
                height: 5,
              ),
              Container(
                alignment: Alignment.bottomRight,
                child: Text(
                  "Forget Password?",
                  style: TextStyle(
                      color: Color(
                        0xff9FA5BB,
                      ),
                      fontSize: 12),
                ),
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
                    performLogin();
                  },
                  child: Container(
                    height: 50,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Color(0xffFF8701),
                        boxShadow: [
                          BoxShadow(
                              color: Color(0x333B83FC),
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
                height: 19,
              ),
              Container(
                height: 140,
                child: Stack(
                  children: [
                    Positioned(
                      top: 0,
                      left: 70,
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SignUpPage()));
                        },
                        child: RichText(
                            text: TextSpan(
                                text: "Don’t have an account? ",
                                style: TextStyle(
                                    color: Color(0xff9FA5BB),
                                    fontWeight: FontWeight.w600,
                                    fontSize: 15),
                                children: [
                              TextSpan(
                                text: "Sign up",
                                style: TextStyle(
                                    color: Color(0xffFF8701), fontSize: 15),
                              )
                            ])),
                      ),
                    ),
                    Positioned(
                        bottom: 0,
                        left: 60,
                        child: Text(
                          "-Or sign in withFringerprint-",
                          style: TextStyle(
                              color: Color(0xff1E2C40),
                              fontWeight: FontWeight.w600,
                              fontSize: 15),
                        )),
                  ],
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                height: 58,
                width: 58,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xffFF8701),
                    boxShadow: [
                      BoxShadow(
                          color: Color(0x5CFF8701),
                          offset: Offset(0, 3),
                          blurRadius: 6)
                    ]),
                child: Center(child: Image.asset("assets/images/finger.png")),
              )
            ],
          ),
        ),
      ),
    );
  }
}

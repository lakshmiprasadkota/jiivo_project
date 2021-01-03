import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'login_page.dart';
import 'verification_page.dart';



void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Login Demo',
      theme: ThemeData(
       
        primarySwatch: Colors.deepOrange,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: LoginPage(),
    );
  }
}



class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _mobileController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _loading = false;

  dynamic res;

  Future<void> _performLogin() async {
    String mobile = _mobileController.text.trim();
    String password = _passwordController.text.trim();

    if (mobile.isEmpty) {
      Fluttertoast.showToast(msg: "Invalid number");
      return;
    }
    if (password.isEmpty) {
      Fluttertoast.showToast(msg: "Invalid password");
      return;
    }
    setState(() {
      _loading = true;
    });
    // Map<String, dynamic> postData = {
    //   "username": username,
    //   "password": password,
    // };
    FormData formData = FormData.fromMap({
      "mobile": mobile,
      "password": password,
    });

    Response response =
    await Dio().post("https://networkintern.herokuapp.com/api/login",
        data: formData,
        options: Options(
          validateStatus: (status) => status < 500,
        ));

    setState(() {
      res = response.data;
      _loading = false;
    });
    if (response.data['status']) {
      // Navigator.of(context).push(
      //   MaterialPageRoute(
      //     builder: (context) => SecondPage(
      //       user: response.data['user'] ??
      //           "", // response.data['user'] == null ? "" : response.data['user']
      //     ),
      //   ),
      // );
    } else {
      Fluttertoast.showToast(msg: response.data['message']);
      print(response.data['message']);
    }
    print(res);
  }

  bool hidepassword = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Sign In",
              style: TextStyle(
                  color: Color(0xFF2E3748),
                  fontSize: 35,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 14,
            ),
            Container(
              child: Column(
                children: [
                  TextField(
                    controller: _mobileController,
                    decoration: InputDecoration(
                      labelText: "Number",
                      labelStyle:
                      TextStyle(color: Color(0xFFFF8701), fontSize: 12,fontWeight: FontWeight.bold),
                      prefixText: "+91",
                      prefixStyle:
                      TextStyle(color: Color(0xFF2E3748), fontSize: 14),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        borderSide: BorderSide(
                          color: Color(0xFFFF8701),
                          width: 2,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        borderSide: BorderSide(
                          color: Color(0xFFFF8701),
                          width: 2,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 24,
                  ),
                  TextField(
                    controller: _passwordController,
                    obscureText: hidepassword,
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        borderSide: BorderSide(
                          color: Color(0xFFE3EAF2),
                          width: 2,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        borderSide: BorderSide(
                          color: Color(0xFFE3EAF2),
                          width: 2,
                        ),
                      ),
                      labelText: "Password",
                      labelStyle: TextStyle(
                          color: Color(0xFFE3EAF2),
                          fontSize: 12,
                          fontWeight: FontWeight.bold),
                      suffixIcon: IconButton(
                          color: Color(0xFF9FA5BB),
                          onPressed: () {
                            setState(() {
                              hidepassword = !hidepassword;
                            });
                          },
                          icon: Icon(hidepassword
                              ? Icons.visibility_off
                              : Icons.visibility)),

                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      InkWell(
                        child: Text(
                          "Forget Password?",
                          style:
                          TextStyle(color: Color(0xFF9FA5BB), fontSize: 12),
                        ),
                        onTap: () {},
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  if (_loading)
                    Center(
                      child: CircularProgressIndicator(),
                    )
                  else
                    InkWell(
                      onTap: () {
                        // Navigator.of(context).push(
                        //   MaterialPageRoute(
                        //     builder: (context) => CurrentEvents(
                        //       // user: response.data['user'] ??
                        //       //     "", // response.data['user'] == null ? "" : response.data['user']
                        //     ),
                        //   ),
                        // );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.circular(20),
                            color: Color(0xFFFF8701),
                            boxShadow: [
                              BoxShadow(
                                  offset: Offset(0, 5),
                                  blurRadius: 10,
                                  color: Color(0x333B83FC))
                            ]),
                        height: 50,
                        width: double.infinity,
                        child: InkWell(
                          onTap: (){
                            _performLogin();
                          },
                          child: Center(
                              child: Text(
                                "Sign In",
                                style: TextStyle(
                                    fontSize: 14,
                                    color: Color(0xFFFFFFFF),
                                    fontWeight: FontWeight.bold),
                              )),
                        ),
                      ),
                    ),
                  if (res != null) Text("${res['user']}"),

                  SizedBox(
                    height: 19,
                  ),
                  InkWell(
                    onTap: () {},
                    child: RichText(
                      text: TextSpan(children: <TextSpan>[
                        TextSpan(
                            text: ' Don’t have an account? ',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF9FA5BB),
                                fontSize: 15)),
                        TextSpan(
                            text: ' Sign up ',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color(0xFFFF8701),
                                fontSize: 15)),
                      ]),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 50,
            ),
            Center(
                child: Text(
                  "-Or sign in withFringerprint-",
                  style: TextStyle(
                      fontSize: 15,
                      color: Color(0xFF1E2C40),
                      fontWeight: FontWeight.bold),
                )),
            SizedBox(height: 20,),
            // Center(
            //   child: Stack(
            //  children: <Widget>[
            //    Container(
            //      height: 58,
            //      width: 58,
            //      decoration: BoxDecoration(
            //        shape: BoxShape.circle,
            //        color: Color(0xFFFF8701),
            //        boxShadow:[BoxShadow(offset: Offset(0,3),blurRadius: 6,color: Color(0x5CFF8701))]
            //      ),
            //    ),
            //    Container(
            //
            //    )
            //  ],
            //
            //
            //   ),
            // )
          ],
        ),
      ),
    );
  }
}
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:jiovii_fullapp/SignUp_page.dart';
import 'package:jiovii_fullapp/jiivo_Page.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool hidepassword = false;
  bool loading = false;
  dynamic res;
  final  numberController = TextEditingController();
  final passwordController = TextEditingController();

  Future<void> performLogin() async{
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
    FormData formData = FormData.fromMap({
      "mobile": number,
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
      loading = false;
    });
    if (response.data['status']) {

      Navigator.push(context, MaterialPageRoute(
          builder: (context) => Homepage()));
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
     body: SingleChildScrollView(
       child: Container(
          margin: EdgeInsets.symmetric(vertical: 226 , horizontal: 25),
          child: Column(
            children: [
              Container(
                alignment: Alignment.topLeft,
                  child: Text("Sign In" , style: TextStyle(color: Color(0xFF2E3748) ,fontWeight: FontWeight.w600, fontSize: 35),))
              ,SizedBox(height: 10,),
              Container(
                child: TextField(
                  controller: numberController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    isDense: true,
                    hintText: "+91",
                    hintStyle: TextStyle(color: Color(0xff2E3748) , fontSize: 14 ),
                    labelText:"Number",
                    labelStyle: TextStyle(color: Color(0xffFF8701) , fontSize: 12 ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(color: Color(0xffFF8701) , width: 2)
                    ),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(color: Color(0xffFF8701) , width: 2)
                      )

                  ),
                ),
              ),
              SizedBox(height: 24,),
              Container(
                child: TextField(
                   controller: passwordController,
                  keyboardType: TextInputType.text,
                  obscureText: hidepassword,
                  decoration: InputDecoration(
                    isDense: true,
                      suffixIcon: IconButton(
                          onPressed: (){
                            setState(() {
                              hidepassword= !hidepassword;
                            });
                          },
                          icon:Icon(hidepassword?Icons.visibility_off:Icons.visibility)
                      ),
                    labelText:"Password",
                    labelStyle: TextStyle(color: Color(0xffFF8701) , fontSize: 12 ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(color: Color(0xffFF8701) , width: 2)
                    ),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(color: Color(0xff97A6BA) , width: 2)
                      )

                  ),
                ),
              ),
              SizedBox(height: 5,),
              Container(
                alignment: Alignment.bottomRight,
                child: Text("Forget Password?" , style: TextStyle(color: Color(0xff9FA5BB , ),fontSize: 12),),
              ),
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
                      color: Color(0xff3B83FC33),
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
                    child: Text("Sign In" , style: TextStyle(color: Color(0xFFFFFFFF) ,
                    fontSize: 14),)),
              ),
              SizedBox(height: 19,),
              InkWell(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> SignUpPage()));
                },
                child: RichText(text: TextSpan(
                 text : "Don’t have an account? ",
                  style: TextStyle(color: Color(0xff9FA5BB) , fontSize: 15),
                  children: [
                    TextSpan(text: "Sign up",
                    style: TextStyle(color: Color(0xffFF8701) , fontSize: 15),
                    ) ]
                )),
              ),
              SizedBox(height: 129,),
              Text("-Or sign in withFringerprint-" , style: TextStyle(color: Color(0xff1E2C40), fontSize: 15),)

            ],
          ),
        ),
     ),
    );
  }
}

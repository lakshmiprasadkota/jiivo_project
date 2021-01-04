import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:jiovii_fullapp/SignUp_page.dart';
import 'package:jiovii_fullapp/jiivo_Page.dart';
import 'Extension_page.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  FocusNode _focusNode ;
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
  void initState() {
    super.initState();
    _focusNode = FocusNode();
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }
  _requestFocus(){
    setState(() {
      FocusScope.of(context).requestFocus(_focusNode);
    });
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
                  child: Text("Sign In" , style: TitleStyle,))
              ,SizedBox(height: 19,),
              Container(
                child: TextField(

                  controller: numberController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    isDense: true,
                    hintText: "+91",
                    hintStyle: hint ,
                    labelText:"Number",
                    labelStyle:TextStyle(color: _focusNode.hasFocus ?Color (0xff97A6BA):Color(0xffFF8701), fontSize: 12,fontWeight: FontWeight.bold),

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
                child: TextField (
                  focusNode:  _focusNode,
                  onTap : (){

                    _requestFocus();
                  },
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

                     labelStyle:  TextStyle(color: _focusNode.hasFocus ?Color (0xff97A6BA):Color(0xffFF8701), fontSize: 12,fontWeight: FontWeight.bold),

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
                    child: Text("Sign In" , style: botton ,
                   )),
              ),
              SizedBox(height: 19,),
              InkWell(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> SignUpPage()));
                },
                child: RichText(text: TextSpan(
                 text : "Don’t have an account? ",
                  style: TextStyle(color: Color(0xff9FA5BB) , fontWeight: FontWeight.w600,fontSize: 15),
                  children: [
                    TextSpan(text: "Sign up",
                    style: TextStyle(color: Color(0xffFF8701) , fontSize: 15),
                    ) ]
                )),
              ),
              SizedBox(height: 129,),
              Text("-Or sign in withFringerprint-" , style: TextStyle(color: Color(0xff1E2C40),fontWeight: FontWeight.w600, fontSize: 15),),
              SizedBox(height: 31,),
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
                          blurRadius: 6
                      )
                    ]
                ),
                child: Center(child: Image.asset("assets/images/finger.png")),
              )
            ],
          ),
        ),
     ),
    );
  }
}

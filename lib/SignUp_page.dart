import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:jiovii_fullapp/jiivo_Page.dart';
import 'package:jiovii_fullapp/verification_page.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  bool hidepassword = false;
  bool loading = false;
  dynamic res;
  final  numberController = TextEditingController();
  final passwordController = TextEditingController();
  final  emailController = TextEditingController();
  final nameController = TextEditingController();

  Future<void> performLogin() async{
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
    FormData formData = FormData.fromMap({
      "mobile": number,
      "password": password,
      "name": name,
      "email": email,

    });
    Response response =
    await Dio().post("https://networkintern.herokuapp.com/api/signup",
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
          builder: (context) => VerificationPage()));
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
              ,SizedBox(height: 19,),
              Container(
                child: TextField(
                  controller: nameController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                      isDense: true,
                      hintText: "Denom Josh",
                      hintStyle: TextStyle(color: Color(0xff2E3748) , fontSize: 14 ),
                      labelText:"Name",
                      labelStyle: TextStyle(color: Color(0xffFF8701) , fontSize: 12 ),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(color: Color(0xffE3EAF2) , width: 2)
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
                  controller: emailController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                      isDense: true,
                      hintText: "Denom@108",
                      hintStyle: TextStyle(color: Color(0xff2E3748) , fontSize: 14 ),
                      labelText:"E-mail",
                      labelStyle: TextStyle(color: Color(0xffFF8701) , fontSize: 12 ),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(color: Color(0xffE3EAF2) , width: 2)
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
                  controller: numberController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      isDense: true,
                      hintText: "+91",
                      hintStyle: TextStyle(color: Color(0xff2E3748) , fontSize: 14 ),
                      labelText:"Number",
                      labelStyle: TextStyle(color: Color(0xffFF8701) , fontSize: 12 ),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(color: Color(0xffE3EAF2) , width: 2)
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
                          borderSide: BorderSide(color: Color(0xffE3EAF2) , width: 2)
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(color: Color(0xffFF8701) , width: 2)
                      )

                  ),
                ),
              ),
              SizedBox(height: 35,),


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
                            color: Color(0xffFF87011A),
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
              SizedBox(height: 39,),


              Text("-OR-" , style: TextStyle(color: Color(0xff000000), fontSize: 15),),
              SizedBox(height: 19,),
              Container(

               alignment: Alignment.center,
                height: 50,
                width: double.infinity,
                decoration: BoxDecoration(
                   borderRadius: BorderRadius.circular(15),
                  border: Border(left: BorderSide(  color: Color(0xffE3EAF2) , width:1.5,),
                    right:  BorderSide(  color: Color(0xffE3EAF2) , width:1.5),
                    top:  BorderSide(  color: Color(0xffE3EAF2) , width:1.5),
                    bottom:  BorderSide(  color: Color(0xffE3EAF2) , width:1.5),
                      )
                ),

                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(

                    ),
                    Row(
                      children: [
                        Image.asset("assets/images/g.png" , height: 20, width: 20,),
                        SizedBox(width: 10,),
                        Text("Sign Up with Google" , style: TextStyle( fontSize: 14,color: Color(0xff000000)),)

                      ],
                    ),

                    Container(

                    ),
                  ],
                )
              ),
            ],
          ),
        ),
      ),
    );
  }
}

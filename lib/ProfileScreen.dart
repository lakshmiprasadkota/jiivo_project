import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'login_page.dart';

class ProfileClass extends StatefulWidget {
  @override
  _ProfileClassState createState() => _ProfileClassState();
}

class _ProfileClassState extends State<ProfileClass> {
  List <IconData>  icon = [Icons.person , Icons.email_outlined , Icons.location_on_outlined, Icons.remove_red_eye_outlined , Icons.phone_callback_sharp];
   List <String> title = ["Username" , "E-Mail "  ,"Location" ,"Password Change " ,"Mobile No. "];
   List <String> subtitle = ["Denim Josh " , "denimjosh@gmail.com", "denimjosh@gmail.com " , "Mumbai " , "**** " , "+91 85551 58558 "];

   @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        toolbarHeight: 80,
        elevation: 2,
        shadowColor: Color(0xff00000D),

        leading: IconButton(icon: Icon(Icons.arrow_back_sharp ,size: 25, color:Color(0xff000000)) ,onPressed: (){
          Navigator.pop(context);
        }, ),
        titleSpacing: 0,
        title: Text("Profile" , style: TextStyle(color: Color(0xff000000),fontSize: 17),),
      ),
      body: SingleChildScrollView(
        child: Container(
          color: Color(0xffF7FBFE) ,
          margin: EdgeInsets.symmetric(vertical: 30 ,horizontal:23 ),
          child: Column(
            children: [

              Container(
                alignment: Alignment.center,
                child: CircleAvatar(
                  backgroundImage : AssetImage("assets/images/meme.jpg"),
                  radius: 50,
                ),
              ),
              SizedBox(height: 21,),
              Container(
                alignment: Alignment.center,
                child: Text("Denim Josh" ,style: TextStyle(color:Color(0xff2E3748) , fontSize: 20 ,)
                ),
              ),
              SizedBox(height: 2,),
              Container(
                alignment: Alignment.center,
                child: Text("Mumabi" ,style: TextStyle(color:Color(0xff9FA5BB) , fontSize: 15 ,)
                ),
              ),
              SizedBox(height: 30,),

             ListView.builder(
               shrinkWrap: true,
               itemCount: icon.length,
               itemBuilder: (context,index){
                 return    Column(
                     children: [
                       Container(
                         padding: EdgeInsets.symmetric(vertical: 14 , horizontal: 18),
                         decoration: BoxDecoration(
                              color: Colors.white,
                             borderRadius: BorderRadius.circular(15),
                             boxShadow: [
                               BoxShadow(
                                   color: Color(0xff0000000D),
                                   offset: Offset(0,3),
                                   blurRadius: 20
                               )
                             ]
                         ),
                         child: Row(
                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                           children: [
                             Row(

                               children: [
                                 CircleAvatar(
                                   backgroundColor: Color(0xffF4F8FF),
                                   child: Icon(icon[index] , color: Color(0xff2E3748),),
                                 ),
                                 SizedBox(width: 16,),
                                 Column(
                                   crossAxisAlignment: CrossAxisAlignment.start,
                                   children: [
                                     Text("${title[index]}" , style:TextStyle(color: Color(0xff9FA5BB) , fontWeight: FontWeight.w500,fontSize: 13), ),
                                     SizedBox(height: 5,),
                                     Text("${subtitle[index]}" , style: TextStyle(color: Color(0xff2E3748), fontWeight: FontWeight.w500 , fontSize: 12),
                                     ),

                                   ],
                                 ),
                               ],
                             ),

                             Text("Edit", style: TextStyle(color: Color(0xffFF8701), fontWeight: FontWeight.w500 , fontSize: 15),
                             ),

                           ],
                         ),
                       ),

                       SizedBox(height: 10,),


                     ],
                   );
               }

             ),
              SizedBox(height: 20,),

              Container(
                height: 50,
                width: double.infinity,
                decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                          color: Color(0x1AFF8701),
                          offset: Offset(0, 5),
                          blurRadius: 10
                      )
                    ]
                ),
                child: RaisedButton(onPressed: (){
                 Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginPage()));
                } ,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    color: Color(0xffFF8701),
                    child: Text("Logout" , style: TextStyle(color: Color(0xFFFFFFFF) ,
                        fontSize: 14),)),
              ),

            ],
          ),
        ),
      ),
    );
  }
}

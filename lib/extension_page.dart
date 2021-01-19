import 'package:flutter/material.dart';
extension CoustomExtension on Widget {
  Widget addContainer ({double height , Color color , Decoration }){
    return Container( height: height, color: color , decoration : Decoration ,child: this,  );
  }
  Widget center(){
    return Center(child: this, );
  }

  Widget TextStyle ({
    Color clr, FontWeight fontWeight , fontSize  ,
  }){
    return TextStyle( clr: clr, fontWeight:  fontWeight , );
  }


}


var  TitleStyle  = TextStyle(
  fontSize: 35,
  color: Color(0xff2E3748),
  fontWeight: FontWeight.w700
);

var  hint  = TextStyle(
    fontSize: 14,
    color: Color(0xff2E3748),
    fontWeight: FontWeight.bold
);
var  botton = TextStyle(
    fontSize: 14,
    color: Color(0xffFFFFFF),
    fontWeight: FontWeight.w400
);


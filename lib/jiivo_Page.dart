
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jiovii_fullapp/ProfileScreen.dart';

class Homepage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {

  int selectedIndex = 0; //to handle which item is currently selected in the bottom app bar
  String text = "Home";
  void updateTabSelection(int index, String buttonText) {
    setState(() {
      selectedIndex = index;
      text = buttonText;
    });
  }
  @override
  Widget build(BuildContext context) {
    return  DefaultTabController(
          length: 2,
          child: Scaffold(
              appBar: AppBar(
   backgroundColor: Colors.white,
                toolbarHeight: 120,
                leading: Icon(Icons.menu ,size: 20, color: Colors.black,),
                titleSpacing: 0,
                title: Text("MY JIIVO" ,style :TextStyle(color: Color(0xff000000) , fontSize: 17),),
                actions: [
                  Icon(Icons.search , color: Color(0xffFF8701),),
                  SizedBox(width: 16,)
                ],
                bottom: TabBar(
                  isScrollable: true,
                  labelStyle: TextStyle(color: Color(0xffBCBCBC) , fontSize: 16),
                  unselectedLabelColor: Color(0xffBCBCBC),
                  labelColor:  Color(0xffBCBCBC),
indicatorColor: Color(0xffFF8701),
               indicatorWeight: 3,
                  labelPadding: EdgeInsets.only(left: 30 ,right: 30),
                  tabs: [
                        Tab(text: "Current event",),
                    Tab(text: "Past event",),
                  ],
                ),
              ),
              body: TabBarView(
                children: [
                  CurrentEvent(),
                  PastEvent(),
                ],
              ),
            floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked, //specify the location of the FAB
            floatingActionButton: FloatingActionButton(
              onPressed: () {

              },

              tooltip: "Centre FAB",
              child: Container(

                child: Center(child: Icon(Icons.add ,size: 30,)),
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Color(0x5CFF8701),
                      offset: Offset(0,10),
                      blurRadius: 15
                    )
                  ]
                ),
              ),
              elevation: 4.0,
            ),
            bottomNavigationBar: BottomAppBar(
              child: Container(

                decoration: BoxDecoration(
                    color: Color(0xFFFFFF),
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                          color: Color(0xff00000029),
                          offset: Offset(0,3),
                          blurRadius: 6
                      )
                    ]
                ),
                margin: EdgeInsets.only(bottom: 5 ),
                height: 70,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: [
                        IconButton(icon: Icon( Icons.event_available ,color: selectedIndex == 0
                            ? Color(0xffFF8701)
                            : Color(0xffD2D8CF),size: 20,), onPressed: (){
                          updateTabSelection(0, "Events");

                        }),
                        Text("Event" , style: TextStyle(color: selectedIndex == 0
                            ? Color(0xffFF8701)
                            : Color(0xffD2D8CF), fontSize: 13),)
                      ],
                    ),
                    SizedBox(width: 20,),
                    Column(
                      children: [
                        IconButton(icon: Icon(Icons.person ,   size: 20, color: selectedIndex == 1
                            ? Color(0xffFF8701)
                            : Color(0xffD2D8CF),), onPressed: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>ProfileClass()));
                          updateTabSelection(1, "profile");

                        }),
                        Text("profile"  , style: TextStyle(color: selectedIndex == 1
                            ? Color(0xffFF8701)
                            : Color(0xffD2D8CF),
                        fontSize: 13),)
                      ],
                    ),

                  ],
                ),
              ),
              shape: CircularNotchedRectangle(),
              
              
            ),
          ),

    );
  }
}

class CurrentEvent extends StatelessWidget {
 List <String> img = [  "assets/images/dev2.png" ,"assets/images/dev.png"  ,"assets/images/meme.jpg"];
 List <String> title = [ "Google dev festival & meetup \n& Start up business idea " , "Standup Comdian by Varun \nlaughter club shows " ,"Standup Comdian by Varun \nlaughter club shows" ,];
 List <String> date = [ "22" , "28" , "30"];

 List <String> subtitle = [ "Google Devfest" , "LDevlop Thecho" , "Child Play Center"];

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16, ),
      color: Color(0xffF7FBFE),
      padding: EdgeInsets.only(top: 18),
      child: ListView.builder(
        itemCount: img.length,
        itemBuilder: (context , index){
           return Column(
             children: [

             Container(
               decoration: BoxDecoration(
                   color: Colors.white,
                   borderRadius: BorderRadius.circular(10),
                   boxShadow: [
                     BoxShadow(
                         color: Color(0xff00000008),
                         offset: Offset(0,3),
                         blurRadius: 6
                     )
                   ]
               ),

             child: Column(
               children: [
                 SizedBox(height: 10,),
                 Container(
                   margin: EdgeInsets.symmetric(horizontal: 18),
                   child: Row(
                     children: [
                       Container(
                         height:32,
                         width: 28,
                         decoration: BoxDecoration(
                             color: Color(0xffFFF6EE),
                             border: Border(
                               left: BorderSide(color: Color(0xffFF8701)),
                               right: BorderSide(color: Color(0xffFF8701)),
                               top: BorderSide(color: Color(0xffFF8701)),
                               bottom: BorderSide(color: Color(0xffFF8701)),
                             ),
                             borderRadius: BorderRadius.circular(5)


                         ),
                         child: Center(
                           child: RichText(text: TextSpan(
                               text : "${date[index]}",
                               style: TextStyle(color: Color(0xffFF8701 ),
                                   fontWeight: FontWeight.bold,
                                   fontSize: 11),
                               children: [
                                 TextSpan(text: "\nFeb",
                                   style: TextStyle(color: Color(0xff2A3E68) ,fontWeight: FontWeight.bold, fontSize: 6),
                                 ) ]
                           )),
                         ),
                       ),
                       SizedBox(width: 11,),
                       Container(
                         child: Text("${title[index]}"
                           , style: TextStyle(color:Color(0xff2A3E68), fontWeight: FontWeight.bold,fontSize: 13 ),),
                       ),

                     ],
                   ),
                 ),


                 SizedBox(height: 10,),
                 Container(

                   child: Image.asset("${img[index]}" ),
                 ),
                 SizedBox(height: 6,),
                 Container(
                     margin: EdgeInsets.symmetric(horizontal: 16),
                     alignment: Alignment.topLeft,
                     child: Text("${subtitle[index]}" , style: TextStyle(color: Color(0xff2A3E68) , fontWeight: FontWeight.bold, fontSize: 16),))
                 ,SizedBox(height: 3,),
                 Container(
                     margin: EdgeInsets.symmetric(horizontal: 16),
                     alignment: Alignment.topLeft,
                     child: Text("10.30Am - 01.00PM . ITI, Mumbai..." , style: TextStyle(color: Color(0xffA1A0A0) , fontWeight: FontWeight.w400 , fontSize: 13),))
                 ,SizedBox(height: 7,),
                 Container(
                     margin: EdgeInsets.symmetric(horizontal: 15),
                     alignment: Alignment.bottomRight,
                     child: Stack(
                       overflow: Overflow.visible,
                       children: [

                         Positioned(
                           left: -40,
                           child: CircleAvatar(
                             backgroundImage: AssetImage("assets/images/flower.jpg"),
                             radius: 12,
                           ),
                         ),
                         Positioned(
                           left: -30,
                           child: CircleAvatar(
                             backgroundImage: AssetImage("assets/images/stc.jpg"),
                             radius: 12,
                           ),
                         ),
                         Positioned(
                           left: -20,
                           child: CircleAvatar(
                             backgroundImage: AssetImage("assets/images/meme.jpg"),
                             radius: 12,
                           ),
                         ),
                         Positioned(
                           left: -10,
                           child: CircleAvatar(
                             backgroundImage: AssetImage("assets/images/flower.jpg"),
                             radius: 12,
                           ),
                         ),
                         Positioned(

                           child: CircleAvatar(
                             backgroundColor: Color(0xffFF8701),
                             child: Center(child: Text("99+" , style: TextStyle(fontSize: 8, color: Colors.white),)),
                             radius: 12,
                           ),
                         ),

                       ],
                     )
                 )
                 ,SizedBox(height: 12,),
               ],
             ),
           ),
               SizedBox(height: 10,)
             ],
           ) ;
             //Column(
          //   children: [
          //     Card(
          //       shadowColor: Color(0xff00000008),
          //         margin: EdgeInsets.symmetric(horizontal: 16, ),
          //         child:
          //     ),
          //     SizedBox(height: 10,)
          //
          //   ],
          // );
        }
      ),
    );
  }
}

class PastEvent extends StatelessWidget {
 List <String> img = [  "assets/images/dev2.png" ,"assets/images/dev.png"  ,"assets/images/meme.jpg"];
 List <String> title = [ "Google dev festival & meetup \n& Start up business idea " , "Standup Comdian by Varun \nlaughter club shows " ,"Standup Comdian by Varun \nlaughter club shows" ,];
 List <String> date = [ "22" , "28" , "30"];

 List <String> subtitle = [ "Google Devfest" , "LDevlop Thecho" , "Child Play Center"];

  @override
  Widget build(BuildContext context) {
    return
       Container(
         color: Color(0xffF7FBFE),
    padding: EdgeInsets.only(top: 18),
    child: ListView.builder(
    itemCount: img.length,
    itemBuilder: (context , index){
    return Column(
    children: [
   Container(
       decoration: BoxDecoration(
          color: Colors.white,
           borderRadius: BorderRadius.circular(10),
           boxShadow: [
             BoxShadow(
                 color: Color(0xff00000008),
                 offset: Offset(0,3),
                 blurRadius: 6
             )
           ]
       ),
    margin: EdgeInsets.symmetric(horizontal: 16, ),
    child:  Column(
    children: [
      SizedBox(height: 10,),
    Container(

    child: Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
    Row(
    children: [
    Container(
    height:32,
    width: 28,
    decoration: BoxDecoration(
    color: Color(0xffFFF6EE),
    border: Border(
    left: BorderSide(color: Color(0xffFF8701)),
    right: BorderSide(color: Color(0xffFF8701)),
    top: BorderSide(color: Color(0xffFF8701)),
    bottom: BorderSide(color: Color(0xffFF8701)),
    ),
    borderRadius: BorderRadius.circular(5)


    ),
    child: Center(
    child: RichText(text: TextSpan(
    text : "${date[index]}",
    style: TextStyle(color: Color(0xffFF8701 ),
    fontWeight: FontWeight.bold,
    fontSize: 11),
    children: [
    TextSpan(text: "\nFeb",
    style: TextStyle(color: Color(0xff2A3E68) ,fontWeight: FontWeight.bold, fontSize: 6),
    ) ]
    )),
    ),
    ),
    SizedBox(width: 11,),
    Container(
    child: Text("${title[index]}"
    , style: TextStyle(color:Color(0xff2A3E68), fontWeight: FontWeight.bold,fontSize: 13 ),),
    ),

    ],
    ),

    Container(
    padding: EdgeInsets.only(left: 40),
    alignment: Alignment.topRight,
    child: Icon(Icons.favorite_border ,size: 26 ,color: Color(0xffFF8701),))

    ],
    ),
    ),


    SizedBox(height: 10,),
    Container(

    child: Image.asset("${img[index]}" ),
    ),
    SizedBox(height: 6,),
    Container(
    margin: EdgeInsets.symmetric(horizontal: 16),
    alignment: Alignment.topLeft,
    child: Text("${subtitle[index]}" , style: TextStyle(color: Color(0xff2A3E68) , fontWeight: FontWeight.bold, fontSize: 16),)),
    SizedBox(height: 3,),
    Container(
    margin: EdgeInsets.symmetric(horizontal: 16),
    alignment: Alignment.topLeft,
    child: Text("10.30Am - 01.00PM . ITI, Mumbai..." , style: TextStyle(color: Color(0xffA1A0A0) , fontWeight: FontWeight.w400 , fontSize: 13),))
    ,SizedBox(height: 7,),
    Container(
    margin: EdgeInsets.symmetric(horizontal: 15),
    alignment: Alignment.bottomRight,
    child: Stack(
    overflow: Overflow.visible,
    children: [

    Positioned(
    left: -40,
    child: CircleAvatar(
    backgroundImage: AssetImage("assets/images/flower.jpg"),
    radius: 12,
    ),
    ),
    Positioned(
    left: -30,
    child: CircleAvatar(
    backgroundImage: AssetImage("assets/images/stc.jpg"),
    radius: 12,
    ),
    ),
    Positioned(
    left: -20,
    child: CircleAvatar(
    backgroundImage: AssetImage("assets/images/meme.jpg"),
    radius: 12,
    ),
    ),
    Positioned(
    left: -10,
    child: CircleAvatar(
    backgroundImage: AssetImage("assets/images/flower.jpg"),
    radius: 12,
    ),
    ),
    Positioned(

    child: CircleAvatar(
    backgroundColor: Color(0xffFF8701),
    child: Center(child: Text("99+" , style: TextStyle(fontSize: 8, color: Colors.white),)),
    radius: 12,
    ),
    ),

    ],
    )
    )
    ,SizedBox(height: 12,),
    ],
    )
    ),
    SizedBox(height: 10,)

    ],
    );
    }
    ),
    );



  }
}

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return HomeState();
  }
}

class HomeState extends State<Home> {
  bool clickedCentreFAB = false; //boolean used to handle container animation which expands from the FAB
  int selectedIndex = 0; //to handle which item is currently selected in the bottom app bar
  String text = "Home";

  //call this method on click of each bottom app bar item to update the screen
  void updateTabSelection(int index, String buttonText) {
    setState(() {
      selectedIndex = index;
      text = buttonText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Align(
            alignment: FractionalOffset.center,
            //in this demo, only the button text is updated based on the bottom app bar clicks
            child: RaisedButton(
              child: Text(text),
              onPressed: () {},
            ),
          ),
          //this is the code for the widget container that comes from behind the floating action button (FAB)
          Align(
            alignment: FractionalOffset.bottomCenter,
            child: AnimatedContainer(
              duration: Duration(milliseconds: 250),
              //if clickedCentreFAB == true, the first parameter is used. If it's false, the second.
              height:
              clickedCentreFAB ? MediaQuery.of(context).size.height : 10.0,
              width: clickedCentreFAB ? MediaQuery.of(context).size.height : 10.0,
              decoration: BoxDecoration(
                  borderRadius:
                  BorderRadius.circular(clickedCentreFAB ? 0.0 : 300.0),
                  color: Colors.blue),
            ),
          )
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked, //specify the location of the FAB
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            clickedCentreFAB = !clickedCentreFAB; //to update the animated container
          });
        },
        tooltip: "Centre FAB",
        child: Container(
          margin: EdgeInsets.all(15.0),
          child: Icon(Icons.add),
        ),
        elevation: 4.0,
      ),
      bottomNavigationBar: BottomAppBar(
        child: Container(
          margin: EdgeInsets.only(left: 12.0, right: 12.0),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              IconButton(
                //update the bottom app bar view each time an item is clicked
                onPressed: () {
                  updateTabSelection(0, "Home");
                },
                iconSize: 27.0,
                icon: Icon(
                  Icons.home,
                  //darken the icon if it is selected or else give it a different color
                  color: selectedIndex == 0
                      ? Colors.blue.shade900
                      : Colors.grey.shade400,
                ),
              ),
              IconButton(
                onPressed: () {
                  updateTabSelection(1, "Outgoing");
                },
                iconSize: 27.0,
                icon: Icon(
                  Icons.call_made,
                  color: selectedIndex == 1
                      ? Colors.blue.shade900
                      : Colors.grey.shade400,
                ),
              ),
              //to leave space in between the bottom app bar items and below the FAB
              SizedBox(
                width: 50.0,
              ),
              IconButton(
                onPressed: () {
                  updateTabSelection(2, "Incoming");
                },
                iconSize: 27.0,
                icon: Icon(
                  Icons.call_received,
                  color: selectedIndex == 2
                      ? Colors.blue.shade900
                      : Colors.grey.shade400,
                ),
              ),
              IconButton(
                onPressed: () {
                  updateTabSelection(3, "Settings");
                },
                iconSize: 27.0,
                icon: Icon(
                  Icons.settings,
                  color: selectedIndex == 3
                      ? Colors.blue.shade900
                      : Colors.grey.shade400,
                ),
              ),
            ],
          ),
        ),
        //to add a space between the FAB and BottomAppBar
        shape: CircularNotchedRectangle(),
        //color of the BottomAppBar
        color: Colors.white,
      ),
    );
  }
}


import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'file:///D:/FlutterProjects/jiovii_fullapp/lib/Screens/profile_screen.dart';
import 'file:///D:/FlutterProjects/jiovii_fullapp/lib/models/past_todo.dart';
import 'file:///D:/FlutterProjects/jiovii_fullapp/lib/models/current_todo.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Homepage extends StatefulWidget {
  Homepage({ this.tk});
  final String tk;
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  int selectedIndex = 0;
  String text = "Home";


  void updateTabSelection(int index, String buttonText) {
    setState(() {
      selectedIndex = index;
      text = buttonText;
    });
  }
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          toolbarHeight: 120,
          leading: Icon(
            Icons.menu,
            size: 20,
            color: Colors.black,
          ),
          titleSpacing: 0,
          title: Text(
            "MY JIIVO",
            style: TextStyle(color: Color(0xff000000), fontSize: 17),
          ),
          actions: [
            Icon(
              Icons.search,
              color: Color(0xffFF8701),
            ),
            SizedBox(
              width: 16,
            )
          ],
          bottom: TabBar(
            isScrollable: true,
            labelStyle: TextStyle(color: Color(0xffBCBCBC), fontSize: 16),
            unselectedLabelColor: Color(0xffBCBCBC),
            labelColor: Color(0xffBCBCBC),
            indicatorColor: Color(0xffFF8701),
            indicatorWeight: 3,
            labelPadding: EdgeInsets.only(left: 30, right: 30),
            tabs: [
              Tab(
                text: "Current event",
              ),
              Tab(
                text: "Past event",
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            CurrentEvent(ceTk:widget.tk,),
            PastEvent(),
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        //specify the location of the FAB
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          child: Container(
            child: Center(
                child: Icon(
              Icons.add,
              size: 30,
            )),
            decoration: BoxDecoration(boxShadow: [
              BoxShadow(
                  color: Color(0x5CFF8701),
                  offset: Offset(0, 10),
                  blurRadius: 15)
            ]),
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
                      offset: Offset(0, 3),
                      blurRadius: 6)
                ]),
            margin: EdgeInsets.only(bottom: 5),
            height: 70,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    IconButton(
                        icon: Icon(
                          Icons.event_available,
                          color: selectedIndex == 0
                              ? Color(0xffFF8701)
                              : Color(0xffD2D8CF),
                          size: 20,
                        ),
                        onPressed: () {
                          updateTabSelection(0, "Events");
                        }),
                    Text(
                      "Event",
                      style: TextStyle(
                          color: selectedIndex == 0
                              ? Color(0xffFF8701)
                              : Color(0xffD2D8CF),
                          fontSize: 13),
                    )
                  ],
                ),
                SizedBox(
                  width: 20,
                ),
                Column(
                  children: [
                    IconButton(
                        icon: Icon(
                          Icons.person,
                          size: 20,
                          color: selectedIndex == 1
                              ? Color(0xffFF8701)
                              : Color(0xffD2D8CF),
                        ),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ProfileClass()));
                          updateTabSelection(1, "profile");
                        }),
                    Text(
                      "profile",
                      style: TextStyle(
                          color: selectedIndex == 1
                              ? Color(0xffFF8701)
                              : Color(0xffD2D8CF),
                          fontSize: 13),
                    )
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

class CurrentEvent extends StatefulWidget {
  CurrentEvent ({ this.ceTk});
  final String ceTk;
  @override
  _CurrentEventState createState() => _CurrentEventState();
}

class _CurrentEventState extends State<CurrentEvent> {
  Welcome listTodos = Welcome();
  bool fetching = true;
  void getHttpOfCurrentEvents() async {
    setState(() {
      fetching = true;
    });
    SharedPreferences prefs= await SharedPreferences.getInstance();
    String token = prefs.get("token");
    try {
      SharedPreferences prefs= await SharedPreferences.getInstance();
      String token = prefs.get("token");
      Response response =
      await Dio().get("https://networkintern.herokuapp.com/api/events?type=current",
          options: Options(
              validateStatus: (status) => status < 500,
              headers: {
                "Authorization":"Bearer $token"
              }
          )
      );
      setState(() {
        listTodos = welcomeFromJson(jsonEncode(response.data));
        fetching = false;
      });
      print(response);
    } catch (e) {
      setState(() {
        fetching = false;
      });
      print(e);
    }
  }

  @override
  void initState() {
    getHttpOfCurrentEvents();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (fetching) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
    if (listTodos.events.length == 0) {
      return Center(
        child: Text("No Data"),
      );
    }
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: 16,
      ),
      color: Color(0xffF7FBFE),
      padding: EdgeInsets.only(top: 18),
      child: ListView.builder(
          itemCount: listTodos.events.length,
          itemBuilder: (context, index) {
            Welcome todo = listTodos;
            return Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                            color: Color(0x08000000),
                            offset: Offset(0, 3),
                            blurRadius: 6)
                      ]),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 18),
                        child: Row(
                          children: [
                            Container(
                              height: 50,
                              width: 100,
                              decoration: BoxDecoration(
                                  color: Color(0xffFFF6EE),
                                  border: Border(
                                    left: BorderSide(color: Color(0xffFF8701)),
                                    right: BorderSide(color: Color(0xffFF8701)),
                                    top: BorderSide(color: Color(0xffFF8701)),
                                    bottom:
                                        BorderSide(color: Color(0xffFF8701)),
                                  ),
                                  borderRadius: BorderRadius.circular(5)),
                              child: Center(
                                child: Text("${todo.events[index].date}"),
                                // child: RichText(text: TextSpan(
                                //     text : "22",
                                //     style: TextStyle(color: Color(0xffFF8701 ),
                                //         fontWeight: FontWeight.bold,
                                //         fontSize: 11),
                                //     children: [
                                //       TextSpan(text: "\nFeb",
                                //         style: TextStyle(color: Color(0xff2A3E68) ,fontWeight: FontWeight.bold, fontSize: 6),
                                //       ) ]
                                // )),
                              ),
                            ),
                            SizedBox(
                              width: 11,
                            ),
                            Flexible(
                              child: Container(
                                child: Text(
                                  "${todo.events[index].description}",
                                  style: TextStyle(
                                      color: Color(0xff2A3E68),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 13),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        child:
                            Image.network("${todo.events[index].bannerImage}"),
                      ),
                      SizedBox(
                        height: 6,
                      ),
                      Container(
                          margin: EdgeInsets.symmetric(horizontal: 16),
                          alignment: Alignment.topLeft,
                          child: Text(
                            "${todo.events[index].title}",
                            style: TextStyle(
                                color: Color(0xff2A3E68),
                                fontWeight: FontWeight.bold,
                                fontSize: 16),
                          )),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 16),
                        alignment: Alignment.topLeft,
                        child: RichText(
                            text: TextSpan(
                                text: "${todo.events[index].from}",
                                style: TextStyle(
                                    color: Color(0xffA1A0A0),
                                    fontWeight: FontWeight.w400,
                                    fontSize: 13),
                                children: [
                              TextSpan(
                                text: " - ",
                                style: TextStyle(
                                    color: Color(0xffA1A0A0),
                                    fontWeight: FontWeight.w400,
                                    fontSize: 13),
                              ),
                              TextSpan(
                                text: "${todo.events[index].to} ",
                                style: TextStyle(
                                    color: Color(0xffA1A0A0),
                                    fontWeight: FontWeight.w400,
                                    fontSize: 13),
                              ),
                              TextSpan(
                                text: " . ",
                                style: TextStyle(
                                    color: Color(0xffA1A0A0),
                                    fontWeight: FontWeight.w400,
                                    fontSize: 20),
                              ),
                              TextSpan(
                                text: " ${todo.events[index].location}",
                                style: TextStyle(
                                    color: Color(0xffA1A0A0),
                                    fontWeight: FontWeight.w400,
                                    fontSize: 13),
                              ),
                            ])),
                      ),
                      SizedBox(
                        height: 7,
                      ),
                      Container(
                          margin: EdgeInsets.symmetric(horizontal: 15),
                          alignment: Alignment.bottomRight,
                          child: Stack(
                            overflow: Overflow.visible,
                            children: [
                              Positioned(
                                left: -40,
                                child: CircleAvatar(
                                  backgroundImage:
                                      AssetImage("assets/images/flower.jpg"),
                                  radius: 12,
                                ),
                              ),
                              Positioned(
                                left: -30,
                                child: CircleAvatar(
                                  backgroundImage:
                                      AssetImage("assets/images/stc.jpg"),
                                  radius: 12,
                                ),
                              ),
                              Positioned(
                                left: -20,
                                child: CircleAvatar(
                                  backgroundImage:
                                      AssetImage("assets/images/meme.jpg"),
                                  radius: 12,
                                ),
                              ),
                              Positioned(
                                left: -10,
                                child: CircleAvatar(
                                  backgroundImage:
                                      AssetImage("assets/images/flower.jpg"),
                                  radius: 12,
                                ),
                              ),
                              Positioned(
                                child: CircleAvatar(
                                  backgroundColor: Color(0xffFF8701),
                                  child: Center(
                                      child: Text(
                                    "99+",
                                    style: TextStyle(
                                        fontSize: 8, color: Colors.white),
                                  )),
                                  radius: 12,
                                ),
                              ),
                            ],
                          )),
                      SizedBox(
                        height: 12,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                )
              ],
            );
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
          }),
    );
  }
}

class PastEvent extends StatefulWidget {
  @override
  _PastEventState createState() => _PastEventState();
}

class _PastEventState extends State<PastEvent> {
  Past listTodos = Past();
  bool fetching = true;

  void getHttp() async {
    setState(() {
      fetching = true;
    });
    try {
      SharedPreferences prefs= await SharedPreferences.getInstance();
      String token = prefs.get("token");
      Response response = await Dio()
          .get("https://networkintern.herokuapp.com/api/events?type=past",
          options: Options(
              validateStatus: (status) => status < 500,
              headers: {
                "Authorization":"Bearer $token"
              }
          ));
      setState(() {
        listTodos = pastFromMap(jsonEncode(response.data));
        fetching = false;
      });
    } catch (e) {
      setState(() {
        fetching = false;
      });
      print(e);
    }
  }
  @override
  void initState() {
    getHttp();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    if (fetching) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
    if (listTodos.events.length == 0) {
      return Center(
        child: Text("No Data"),
      );
    }
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: 16,
      ),
      color: Color(0xffF7FBFE),
      padding: EdgeInsets.only(top: 18),
      child: listTodos == null ? Text("No Data") : ListView.builder(
          itemCount: listTodos.events.length,
          itemBuilder: (context, index) {
            Past todo = listTodos;
            return Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                            color: Color(0x0800000008),
                            offset: Offset(0, 3),
                            blurRadius: 6)
                      ]),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 18),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Container(
                                  height: 32,
                                  width: 28,
                                  decoration: BoxDecoration(
                                      color: Color(0xffFFF6EE),
                                      border: Border(
                                        left: BorderSide(
                                            color: Color(0xffFF8701)),
                                        right: BorderSide(
                                            color: Color(0xffFF8701)),
                                        top: BorderSide(
                                            color: Color(0xffFF8701)),
                                        bottom: BorderSide(
                                            color: Color(0xffFF8701)),
                                      ),
                                      borderRadius: BorderRadius.circular(5)),
                                  child: Center(
                                    child: RichText(
                                        text: TextSpan(
                                            text: "22",
                                            style: TextStyle(
                                                color: Color(0xffFF8701),
                                                fontWeight: FontWeight.bold,
                                                fontSize: 11),
                                            children: [
                                          TextSpan(
                                            text: "\nFeb",
                                            style: TextStyle(
                                                color: Color(0xff2A3E68),
                                                fontWeight: FontWeight.bold,
                                                fontSize: 6),
                                          )
                                        ])),
                                  ),
                                ),
                                SizedBox(
                                  width: 11,
                                ),
                                Container(
                                  child: Text(
                                    "${todo.events[index].title}",
                                    style: TextStyle(
                                        color: Color(0xff2A3E68),
                                        fontWeight: FontWeight.bold,
                                        fontSize: 13),
                                  ),
                                ),
                              ],
                            ),
                            Icon(
                              Icons.favorite_border,
                              color: Color(0xffFF8701),
                              size: 25,
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        child:
                            Image.network("${todo.events[index].bannerImage}"),
                      ),
                      SizedBox(
                        height: 6,
                      ),
                      Container(
                          margin: EdgeInsets.symmetric(horizontal: 16),
                          alignment: Alignment.topLeft,
                          child: Text(
                            "${todo.events[index].description}",
                            style: TextStyle(
                                color: Color(0xff2A3E68),
                                fontWeight: FontWeight.bold,
                                fontSize: 16),
                          )),
                      SizedBox(
                        height: 3,
                      ),
                      Container(
                          margin: EdgeInsets.symmetric(horizontal: 16),
                          alignment: Alignment.topLeft,
                          child: Text(
                            "${todo.events[index].location}",
                            style: TextStyle(
                                color: Color(0xffA1A0A0),
                                fontWeight: FontWeight.w400,
                                fontSize: 13),
                          )),
                      SizedBox(
                        height: 7,
                      ),
                      Container(
                          margin: EdgeInsets.symmetric(horizontal: 15),
                          alignment: Alignment.bottomRight,
                          child: Stack(
                            overflow: Overflow.visible,
                            children: [
                              Positioned(
                                left: -40,
                                child: CircleAvatar(
                                  backgroundImage:
                                      AssetImage("assets/images/flower.jpg"),
                                  radius: 12,
                                ),
                              ),
                              Positioned(
                                left: -30,
                                child: CircleAvatar(
                                  backgroundImage:
                                      AssetImage("assets/images/stc.jpg"),
                                  radius: 12,
                                ),
                              ),
                              Positioned(
                                left: -20,
                                child: CircleAvatar(
                                  backgroundImage:
                                      AssetImage("assets/images/meme.jpg"),
                                  radius: 12,
                                ),
                              ),
                              Positioned(
                                left: -10,
                                child: CircleAvatar(
                                  backgroundImage:
                                      AssetImage("assets/images/flower.jpg"),
                                  radius: 12,
                                ),
                              ),
                              Positioned(
                                child: CircleAvatar(
                                  backgroundColor: Color(0xffFF8701),
                                  child: Center(
                                      child: Text(
                                    "99+",
                                    style: TextStyle(
                                        fontSize: 8, color: Colors.white),
                                  )),
                                  radius: 12,
                                ),
                              ),
                            ],
                          )),
                      SizedBox(
                        height: 12,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                )
              ],
            );
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
          }),
    );
  }
}

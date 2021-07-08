import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:vcu/signin.dart';
import 'attendance.dart';
import 'assignment.dart';
import 'dailyreport.dart';
import 'schedule.dart';
import 'components/cards.dart';
import 'components/constants.dart';

final controller = ScrollController();
User loggedInUser;

final _auth = FirebaseAuth.instance;
var nameOfUserLoggedIn;

class Constants {
  static   String name=nameOfUserLoggedIn.toString() ;
  static const String SignOut = 'Sign out';

  static  List<String> choices = <String>[
    name,
    SignOut
  ];
}

void main() =>
    runApp(MaterialApp(debugShowCheckedModeBanner: false, home: HomePage()));

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {




  final List<Widget> listUrl = [
    Text('Attendance()'),
    Text('Assignment()'),
    Text('Report()'),
    Text('Schedule()'),
  ];

  @override
  void initState() {
    super.initState();
    getCurrentUser();
    print(nameOfUserLoggedIn);
  }
  void getCurrentUser() async {
    try {
      User user = _auth.currentUser;
      if (user != null) {
        loggedInUser = user;
        print(loggedInUser);
        nameOfUserLoggedIn = loggedInUser.email.toString();
        loggedInUser.uid;
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.orangeAccent[100],
        appBar: TopBar(
            title: 'VCU',
            // Icon(
            //   Icons.account_circle,
            //   color: Colors.white,
            //   size: 30,
            // ),

            child: PopupMenuButton(
              itemBuilder: (BuildContext context) {
                return Constants.choices.map((String choice) {
                  return PopupMenuItem<String>(
                    value: choice,
                    child: Text(choice),
                  );
                }).toList();
              },
              child: MaterialButton(
                onPressed: null,
                height: 50,
                minWidth: 50,
                elevation: 10,
                shape: kBackButtonShape,
                child: Icon(
                  Icons.account_circle,
                  color: Colors.white,
                  size: 30,
                ),
              ),
              onSelected: choiceAction,
            ),
            onPressed: null),
        body: SafeArea(
          child: Container(
            padding: EdgeInsets.all(20.0),
            child: Column(
              children: <Widget>[
                Container(
                  width: double.infinity,
                  height: 250,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      image: DecorationImage(
                          image: AssetImage('assets/images/Banner.png'),
                          fit: BoxFit.cover)),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        gradient: LinearGradient(
                            begin: Alignment.bottomRight,
                            colors: [
                              Colors.black.withOpacity(.4),
                              Colors.black.withOpacity(.2),
                            ])),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        SizedBox(
                          height: 30,
                        ),
                        SizedBox(
                          height: 30,
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Expanded(
                    child: GridView.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  children: cardsInfo
                      .map((item) => Card(
                            color: Colors.transparent,
                            elevation: 0,
                            child: Stack(children: <Widget>[
                              Card(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)),
                                elevation: 10,
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      image: DecorationImage(
                                          image: AssetImage(item.assetName),
                                          fit: BoxFit.cover)),
                                  child: Transform.translate(
                                    offset: Offset(50, -50),
                                    child: Container(
                                      margin: EdgeInsets.symmetric(
                                          horizontal: 65, vertical: 63),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: Colors.transparent),
                                    ),
                                  ),
                                ),
                              ),
                              Positioned.fill(
                                  child: Material(
                                color: Colors.transparent,
                                child: InkWell(
                                  onTap: () {
                                    if (item.assetName ==
                                        'assets/images/two.png') {
                                      Navigator.push(
                                        context,
                                        PageRouteBuilder(
                                          pageBuilder: (c, a1, a2) =>
                                              Attendance(uid: loggedInUser.uid,),
                                          transitionsBuilder:
                                              (c, anim, a2, child) =>
                                                  FadeTransition(
                                                      opacity: anim,
                                                      child: child),
                                          transitionDuration:
                                              Duration(milliseconds: 1000),
                                        ),
                                      );
                                    }
                                    if (item.assetName ==
                                        'assets/images/three.png') {
                                      Navigator.push(
                                        context,
                                        PageRouteBuilder(
                                          pageBuilder: (c, a1, a2) =>
                                              Assignment(),
                                          transitionsBuilder:
                                              (c, anim, a2, child) =>
                                                  FadeTransition(
                                                      opacity: anim,
                                                      child: child),
                                          transitionDuration:
                                              Duration(milliseconds: 1000),
                                        ),
                                      );
                                    }
                                    if (item.assetName ==
                                        'assets/images/four.png') {
                                      Navigator.push(
                                        context,
                                        PageRouteBuilder(
                                          pageBuilder: (c, a1, a2) => Report(),
                                          transitionsBuilder:
                                              (c, anim, a2, child) =>
                                                  FadeTransition(
                                                      opacity: anim,
                                                      child: child),
                                          transitionDuration:
                                              Duration(milliseconds: 1000),
                                        ),
                                      );
                                    }
                                    if (item.assetName ==
                                        'assets/images/one.png') {
                                      Navigator.push(
                                        context,
                                        PageRouteBuilder(
                                          pageBuilder: (c, a1, a2) =>
                                              Schedule(),
                                          transitionsBuilder:
                                              (c, anim, a2, child) =>
                                                  FadeTransition(
                                                      opacity: anim,
                                                      child: child),
                                          transitionDuration:
                                              Duration(milliseconds: 1000),
                                        ),
                                      );
                                    }
                                  },
                                ),
                              ))
                            ]),
                          ))
                      .toList(),
                ))
              ],
            ),
          ),
        ),
      ),
    );
  }
  void choiceAction(String choice) {

    if (choice == Constants.name) {

    } else if (choice == Constants.SignOut) {
      FirebaseAuth.instance.signOut();
      Navigator.pop(
        context,
        PageRouteBuilder(
          pageBuilder: (c, a1, a2) =>
              SignIn(),
          transitionsBuilder:
              (c, anim, a2, child) =>
              FadeTransition(
                  opacity: anim,
                  child: child),
          transitionDuration:
          Duration(milliseconds: 1000),
        ),
      );
    }
  }
}



class TopBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Widget child;
  final Function onPressed;
  final Function onTitleTapped;

  @override
  final Size preferredSize;

  TopBar({@required this.title,
    @required this.child,
    @required this.onPressed,
    this.onTitleTapped})
      : preferredSize = Size.fromHeight(60.0);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: <Widget>[
          // SizedBox(height: 30,),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Hero(
                tag: 'topBarBtn',
                child: Card(
                  color: Color(0xFF831307),
                  elevation: 10,

                  shape: kBackButtonShape,
                  // child: MaterialButton(
                  //   height: 50,
                  //   minWidth: 50,
                  //   elevation: 10,
                  //   shape: kBackButtonShape,
                  //   onPressed: () {
                  //     PopupMenuButton(itemBuilder: ,);
                  //   },
                  //   child: child,
                  // ),
                  child: child,
                ),
              ),
              // SizedBox(
              //   width: 50,
              // ),
              Hero(
                tag: 'title',
                transitionOnUserGestures: true,
                child: Card(
                  color: Color(0xFF831307),
                  elevation: 10,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                    ),
                  ),
                  child: InkWell(
                    onTap: onTitleTapped,
                    child: Container(
                      width: MediaQuery
                          .of(context)
                          .size
                          .width / 1.5,
                      height: 50,
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 30),
                          child: Text(
                            title,
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 30,
                              // color: Colors.black54,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}

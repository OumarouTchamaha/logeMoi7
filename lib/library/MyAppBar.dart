import 'package:LogeMoi/screens/ProfilePage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final User loggedUser;
  final int height = 50;
  MyAppBar({this.title, this.loggedUser});
  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 1,
      centerTitle: true,
      leading: Container(),
      title: Text(
        title,
        textAlign: TextAlign.center,
        style: TextStyle(
            fontSize: 23, fontWeight: FontWeight.bold, letterSpacing: 1.3),
      ),
      actions: <Widget>[
//        InkWell(
//          onTap: (){
//            Navigator.push(
//              context,
//              PageTransition(
//                type: PageTransitionType.downToUp,
//                child: ProfilePage(),
//              ),
//            );
//          },
//          child: CircleAvatar(
//            backgroundColor: darkGrey,
//            backgroundImage: null,
//            onBackgroundImageError: null,
//            child: Icon(Icons.account_circle),
//          ),
//        ),
        IconButton(
          icon: Icon(Icons.account_circle),
          onPressed: () {
            Navigator.push(
              context,
              PageTransition(
                type: PageTransitionType.rightToLeft,
                child: ProfilePage(loggedUser: loggedUser,),
              ),
            );
          },
          color: Colors.white,
          iconSize: 40,
        ),
        Padding(
          padding: EdgeInsets.only(right: 10),
        ),
      ],
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size(50, 50);
}

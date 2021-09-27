import 'package:LogeMoi/library/Common.dart';
import 'package:LogeMoi/screens/DisplayEntriesSearch.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class QuartierButton extends StatefulWidget{
  QuartierButton({this.nomQuartier});
  final String nomQuartier;

  @override
  State<StatefulWidget> createState() {
    return new _QuartierButtonState();
  }
}

class _QuartierButtonState extends State<QuartierButton>{

  Widget myQuatierButton({String text}){
    return RaisedButton(
      // padding: EdgeInsets.only(bottom: 10),
      shape: RoundedRectangleBorder(
          borderRadius: new BorderRadius.circular(35.0)),
      onPressed: () {
        print(widget.nomQuartier);
        Navigator.push(
            context,
            PageTransition(
                type: PageTransitionType.rightToLeft, child: DisplayEntriesRecherche(quartier: widget.nomQuartier,)
            )
        );
      },
      color: primaryColor,
      child: RichText(
        text: TextSpan(children: <TextSpan>[
          TextSpan(
              text: text,
              style: TextStyle(
                  color: white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold)),
        ]),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(padding:
    EdgeInsets.only(top: 10, right: 10),
      child:
        myQuatierButton(text: widget.nomQuartier),
    );
  }

}
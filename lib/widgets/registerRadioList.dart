import 'package:LogeMoi/library/Common.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// ignore: camel_case_types
class RegisterRadioList extends StatefulWidget{

  Function getType;

  RegisterRadioList({this.value,this.getType});
  String value;
  @override
  State<StatefulWidget> createState() {
    return  new _RegisterRadioListState();
  }
}

class _RegisterRadioListState extends State<RegisterRadioList>{
  @override
//  void initState(){
//    super.initState();
//  }

  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          flex: 1,
          child: SizedBox(
            height: 40,
              child :
                ListView(
                  physics: ClampingScrollPhysics(),
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  children: <Widget>[
                   Row(
                     crossAxisAlignment: CrossAxisAlignment.center,
                     mainAxisAlignment: MainAxisAlignment.center,
                     children: <Widget>[
                       Radio(
                           groupValue: widget.value,
                           activeColor: primaryColor,
                           //title: Text('Client'),
                           value: 'Client',
                           onChanged: (String value){
                             setState(() {
                               widget.value = value;
                               widget.getType(value);
                             });
                           }),
                       new Text('Client', style: TextStyle(
                         fontSize: 16,
                         fontWeight: FontWeight.bold,
                         color: Colors.black,
                       ),),
                       Radio(
                           groupValue: widget.value,
                           //title: Text('Proprietaire'),
                           value: 'Proprietaire',
                           onChanged: (String value){
                             setState(() {
                               widget.value = value;
                               widget.getType(value);
                             });
                           }),
                       new Text('Propriétaire', style: TextStyle(
                         fontSize: 16,
                         fontWeight: FontWeight.bold,
                         color: Colors.black,
                       ),),
                       Radio(
                           groupValue: widget.value,
                           //title: Text('Agent Immobilier'),
                           value: 'Agent_Immo',
                           onChanged: (String value){
                             setState(() {
                               widget.value = value;
                               widget.getType(value);
                             });
                           }),
                       new Text('Agent Immobilier', style: TextStyle(
                         fontSize: 16,
                         fontWeight: FontWeight.bold,
                         color: Colors.black,
                       ),
                       ),
                       Padding(
                         padding: EdgeInsets.only(bottom: 10.0),
                       ),
                     ],
                   )
                  ],
                ),
                //Text('$widget.value', style: TextStyle(fontSize: 23, color: darkGrey),),
            ),
        ),
      ],
    );
  }

}


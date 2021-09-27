import 'package:LogeMoi/library/Common.dart';
import 'package:flutter/material.dart';

// ignore: camel_case_types
class ProfileRadioList extends StatefulWidget{

  ProfileRadioList({this.value, this.status, this.getType});
  Function getType;
  String value;
  bool status;
  @override
  State<StatefulWidget> createState() {
    return  new _ProfileRadioListState();
  }
}

class _ProfileRadioListState extends State<ProfileRadioList>{

  @override
//  void initState(){
//    super.initState();
//  }

  Widget build(BuildContext context) {
    return new Padding(
      padding: const EdgeInsets.only(left: 1.0),
      child: SizedBox(
        height: 40,
        width: 312,
        child :
        ListView(
          physics: ClampingScrollPhysics(),
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Radio(
                  groupValue: widget.value,
                  activeColor: primaryColor,
                  //title: Text('Client'),
                  value: 'Client',
                  onChanged: !widget.status ? (String value){
                    setState(() {
                      widget.value = value;
                      widget.getType(value);
                    });
                  } : null,
                ),
                new Text('Client', style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),),
                Radio(
                  groupValue: widget.value,
                  //title: Text('Proprietaire'),
                  value: 'Proprietaire',
                  onChanged: !widget.status ? (String value){
                    setState(() {
                      widget.value = value;
                      widget.getType(value);
                    });
                  } : null,
                ),
                new Text('Propriétaire', style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),),
                Radio(
                  groupValue: widget.value,
                  //title: Text('Agent Immobilier'),
                  value: 'Agent_Immo',
                  onChanged: !widget.status ? (String value){
                    setState(() {
                      widget.value = value;
                      widget.getType(value);
                    });
                  } : null,
                ),
                new Text('Agent Immobilier', style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),),
                Padding(
                  padding: EdgeInsets.only(bottom: 10.0),
                ),
              ],
            )
              ],
            ),
        ),
        //Text('$widget.value', style: TextStyle(fontSize: 23, color: darkGrey),),
      );
  }

}



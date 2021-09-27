import 'package:condition/condition.dart';
import 'package:flutter/material.dart';

class ConditionedLoginMsg extends StatefulWidget{
  String message;


  ConditionedLoginMsg({this.message});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return ConditionedLoginMsgState();
  }
  
}
class ConditionedLoginMsgState extends State<ConditionedLoginMsg>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Conditioned.boolean(
      widget.message != null,
      trueBuilder: () => Wrap(

        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 20),
                child: Text(
                  widget.message, style: TextStyle(color: Colors.red,),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
  
}
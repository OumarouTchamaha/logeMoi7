import 'package:flutter/material.dart';

import 'customTextFormFIield.dart';

class InputTextField extends StatefulWidget{
  String labelText;
  String hintText;
  Function validate;
  Function onSave;
  bool obscureText;
  IconButton icon;
  var keyboardType;
  var inputFormatters;
  bool enabled, autofocus;

  InputTextField(
  {this.labelText, this.hintText, this.validate, this.keyboardType,
    this.onSave, this.obscureText, this.icon, this.inputFormatters,
    this.autofocus, this.enabled});

  @override
  State<StatefulWidget> createState() {
    return InputTextFieldState();
  }
  
}
class InputTextFieldState extends State<InputTextField>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(left: 15, bottom: 5),
            child: Text(
              widget.labelText,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 8, right: 8, bottom: 15),
            child: myCustomTextFormField(
              textHint: widget.hintText,
              validate: widget.validate,
              keyboardType: widget.keyboardType,
              inputFormatters: widget.inputFormatters,
              onSave: widget.onSave,
              obscureText: widget.obscureText,
              autofocus: widget.autofocus,
              enabled: widget.enabled,
              icon: widget.icon,
            ),
          ),
        ],
      ),
    );
  }

}
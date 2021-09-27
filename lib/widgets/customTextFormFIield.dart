import 'package:LogeMoi/library/Common.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class myCustomTextFormField extends StatefulWidget{
  String textHint;
  Function validate;
  Function onSave;
  bool obscureText = false;
  IconButton icon;
  TextInputType keyboardType;
  var inputFormatters;
  bool enabled;
  bool autofocus = false;

  myCustomTextFormField({this.textHint, this.onSave, this.validate,
    this.obscureText, this.icon, this.keyboardType, this.inputFormatters,
    this.autofocus, this.enabled});

  @override
  State createState() {
    return myCustomTextFormFieldState();
  }
}

class myCustomTextFormFieldState extends State<myCustomTextFormField>{

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: TextStyle(color: white),
      validator: widget.validate,
      onSaved: widget.onSave,
      obscureText: widget.obscureText,
      keyboardType: widget.keyboardType,
      inputFormatters: widget.inputFormatters,
      enabled: widget.enabled,
      autofocus: widget.autofocus,
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(80),
          borderSide:
          const BorderSide(color: Colors.transparent, width: 0.0),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(80),
          borderSide:
          const BorderSide(color: Colors.transparent, width: 0.0),
        ),
        // disabledBorder: new InputBorder(borderSide: BorderSide.none),
        hintStyle: TextStyle(
            fontSize: 12,
            fontStyle: FontStyle.italic,
            color: Color(0xffffffff)),
        filled: true,
        fillColor: darkGrey,
        contentPadding:
        EdgeInsets.symmetric(horizontal: 17, vertical: 12),
        hintText: widget.textHint,
        suffixIcon: widget.icon

      ),
    );
  }
}
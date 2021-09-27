import 'package:LogeMoi/library/Common.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CustomDropdownButton extends StatefulWidget{

  String selectedValue;
  Function getValue;
  String labelText;

  CustomDropdownButton({this.selectedValue,this.labelText, this.getValue});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return CustomDropdownButtonState();
  }

}
class CustomDropdownButtonState extends State<CustomDropdownButton>{

  var _quartiers;
  List<String> _quartiersList;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 5, bottom: 5),
          child: Text(
            widget.labelText,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ),
        InputDecorator(
          decoration: InputDecoration(
            //prefix: widget.selectedValue != null? Text(widget.selectedValue) : Text(""),
            filled: true,
            fillColor: darkGrey,
            border: OutlineInputBorder(
              borderRadius:
              BorderRadius.circular(80),
              borderSide: const BorderSide(
                  color: Colors.transparent,
                  width: 0.0),
            ),
            contentPadding: EdgeInsets.symmetric(horizontal: 17, vertical: 12),
          ),
          isEmpty: widget.selectedValue == '',
          child:
          StreamBuilder(
              stream: FirebaseFirestore.instance.collection('quartiers').doc('Douala').snapshots(),
              builder: (context, snapshot){
                if(!snapshot.hasData){
                  return new Text('Chargement');
                }
                _quartiers = snapshot.data;
                _quartiersList = List.castFrom(_quartiers.data()['quartiers']);
                return new DropdownButtonHideUnderline(
                  child:
                  DropdownButton<String>(
                    value: widget.selectedValue,
                    style: TextStyle(color: white),
                    dropdownColor: darkGrey,
                    hint: Text('Selectionez le quartier',
                      style: TextStyle(
                          fontSize: 12,
                          fontStyle: FontStyle.italic,
                          color: Color(0xffffffff)),
                    ),
                    isDense: true,
                    onChanged: (String newValue) {
                      setState(() {
                        widget.selectedValue = newValue;
                        widget.getValue(newValue);
                      });
                    },
                    items:
                    _quartiersList.map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                );
              }
          )
        ),
      ],
    );

  }

}
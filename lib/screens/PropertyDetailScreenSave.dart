import 'package:LogeMoi/library/Card.dart';
import 'package:LogeMoi/library/Common.dart';
import 'package:LogeMoi/models/Property.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class PropertyDetailScreenSave extends StatefulWidget {

  final String entry_id;

  List<PropertyDetail> propertyDetails;
  PropertyDetailScreenSave({this.propertyDetails, this.entry_id});
  @override
  _PropertyDetailScreenSaveState createState() => _PropertyDetailScreenSaveState();
}

class _PropertyDetailScreenSaveState extends State<PropertyDetailScreenSave> {

  CollectionReference databaseReference = FirebaseFirestore.instance.collection('entries');

  @override
  Widget build(BuildContext context) {
    print(widget.propertyDetails.length);
    return Scaffold(
      body: SingleChildScrollView(
        // physics: BouncingScrollPhysics(),
        child: Stack(
          children: <Widget>[
            ClipPath(
              clipper: OvalBottomBorderClipper(),
              child: Container(
                margin: EdgeInsets.only(top: 20),
                height: 180,
                decoration: BoxDecoration(
                  color: primaryColor,
                ),
                child: ListTile(
                    leading: Padding(
                      padding: EdgeInsets.only(right: 8),
                      child: IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(
                          Icons.arrow_back,
                          size: 30,
                          color: white,
                        ),
                      ),
                    ),
                    title: Text(
                      "Details     ",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 23,
                          color: white,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.3),
                    ),
                  contentPadding: EdgeInsets.only(right: 80.0),
                    ),
              ),
            ),
            
            Column(
              children: [
                Container(
                  height: 260,
                  color: Colors.transparent,
                  margin: EdgeInsets.only(top: 90),
                  child: Swiper(
                    loop: false,
                    itemWidth: 340,
                    itemHeight: 400,
                    index: 1,
                    itemCount: widget.propertyDetails.length,
                    itemBuilder: (BuildContext context, int index) {
                      return PropertyDetailCard(
                          image: widget.propertyDetails[index].image,
                          title: widget.propertyDetails[index].title,
                          description: widget.propertyDetails[index].description);
                    },
                    viewportFraction: 0.75,
                    pagination: new SwiperPagination(
                        alignment: Alignment(0, 1.4),
                        builder: DotSwiperPaginationBuilder(color: grey)),
                    scale: 0.8,
                    layout: SwiperLayout.DEFAULT,
                  ),

                ),
                Container(
                  child: Padding(
                    padding: EdgeInsets.only(top: 40),
                    child: Divider(
                      thickness: 1,
                      height: 8,
                    ),
                  ),
                ),
              ],
            ),
            Column(
              children: [
                Container(
                    margin: EdgeInsets.only(top: 410),
                    // color: primaryColor,
                    height: 200,
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Padding(
                                padding: EdgeInsets.symmetric(horizontal: 30.0),
                                child: Text('Appartement à louer',
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                            )
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: Divider(
                            thickness: 1,
                            height: 8,
                          ),
                        ),
                        Container(
                          height: 150,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              Column(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: <Widget>[
                                      Icon(
                                        SimpleLineIcons.user,
                                        size: 17,
                                        color: primaryColor,
                                      ),
                                      SizedBox(
                                        width: 4,
                                      ),
                                      Text(
                                        "Publicateur : ",
                                        style: TextStyle(fontSize: 15, color: grey),
                                      ),
                                      SizedBox(
                                        width: 4,
                                      ),
                                      Text(
                                        "Aoudou Ibrahim",
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w800),
                                      )
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Icon(
                                        SimpleLineIcons.clock,
                                        size: 17,
                                        color: primaryColor,
                                      ),
                                      SizedBox(
                                        width: 4,
                                      ),
                                      Text(
                                        "Durée Minimum : ",
                                        style: TextStyle(fontSize: 15, color: grey),
                                      ),
                                      SizedBox(
                                        width: 4,
                                      ),
                                      Text(
                                        "19 mois",
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w800),
                                      )
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                    children: <Widget>[
                                      Icon(
                                        SimpleLineIcons.user,
                                        size: 17,
                                        color: primaryColor,
                                      ),
                                      SizedBox(
                                        width: 4,
                                      ),
                                      Text(
                                        "Type : ",
                                        style: TextStyle(fontSize: 15, color: grey),
                                      ),
                                      SizedBox(
                                        width: 4,
                                      ),
                                      Text(
                                        "Apartement",
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w800),
                                      )
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                    children: <Widget>[
                                      Icon(
                                        SimpleLineIcons.user,
                                        size: 17,
                                        color: primaryColor,
                                      ),
                                      SizedBox(
                                        width: 4,
                                      ),
                                      Text(
                                        "Statut : ",
                                        style: TextStyle(fontSize: 15, color: grey),
                                      ),
                                      SizedBox(
                                        width: 4,
                                      ),
                                      Text(
                                        "A louer",
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w800),
                                      )
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Icon(
                                        AntDesign.creditcard,
                                        size: 17,
                                        color: primaryColor,
                                      ),
                                      SizedBox(
                                        width: 4,
                                      ),
                                      Text(
                                        "Loyer : ",
                                        style: TextStyle(fontSize: 15, color: grey),
                                      ),
                                      SizedBox(
                                        width: 4,
                                      ),
                                      Text(
                                        "100 000 FCFA/mois",
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w800),
                                      )
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Icon(
                                        AntDesign.profile,
                                        size: 17,
                                        color: primaryColor,
                                      ),
                                      SizedBox(
                                        width: 4,
                                      ),
                                      Text(
                                        "Date Ajout : ",
                                        style: TextStyle(fontSize: 15, color: grey),
                                      ),
                                      SizedBox(
                                        width: 4,
                                      ),
                                      Text(
                                        "21 Juin, 2020",
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w800),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                              CircleAvatar(
                                maxRadius: 45,
                                minRadius: 45,
                                backgroundColor: grey,
                                child: Icon(
                                  Icons.account_circle,
                                  size: 70,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                ),
                Container(
                  child: Padding(
                    padding: EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0, bottom: 10.0),
                    child: Divider(
                      thickness: 1,
                      height: 2,
                    ),
                  ),
                ),
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 30.0, bottom: 10.0),
                          child:
                          Icon(AntDesign.infocirlceo, color: primaryColor, size: 17,),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 1.0, bottom: 10.0, left: 5.0),
                          child:
                          Text('Description : ',
                            style:
                            TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.normal,
                                color: grey
                            ),),
                        ),
                      ],
                    ),
                    Wrap(
                      direction: Axis.horizontal,
                      children: [
                        Padding(
                            padding: EdgeInsets.symmetric(horizontal: 50),
                          child:
                          Text('Très bell appartement modèrne situé en bordure de route. '
                              'Situé dans le quartier résidentiel de bonapriso, il dispose d\'un parking privé,'
                              'D\'un gardien disponoble 24h/24',
                            style:
                            TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold
                            ),),
                        )
                      ],
                    ),
                  ],
                ),
                Container(
                  child: Padding(
                    padding: EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0, bottom: 10.0),
                    child: Divider(
                      thickness: 1,
                      height: 2,
                    ),
                  ),
                ),
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 30.0, bottom: 10.0),
                          child:
                          Icon(AntDesign.picture, color: primaryColor, size: 17,),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 1.0, bottom: 10.0, left: 5.0),
                          child:
                          Text('Gallerie d\'images : ',
                            style:
                            TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.normal,
                                color: grey
                            ),),
                        ),
                      ],
                    ),
                    Wrap(
                      direction: Axis.horizontal,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 50),
                          child:
                          Text('Très bell appartement modèrne situé en bordure de route. '
                              'Situé dans le quartier résidentiel de bonapriso, il dispose d\'un parking privé,'
                              'D\'un gardien disponoble 24h/24',
                            style:
                            TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold
                            ),),
                        )
                      ],
                    ),
                  ],
                ),
                Container(
                  height: 20,
                ),
                Center(
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.9,
                    height: 45,
                    child: RaisedButton(
                      // padding: EdgeInsets.only(bottom: 10),
                      shape: RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(35.0)),
                      onPressed: () {},
                      color: primaryColor,
                      child: RichText(
                        text: TextSpan(children: <TextSpan>[
                          TextSpan(
                              text: "Voir le Contact",
                              style: TextStyle(
                                  letterSpacing: 1,
                                  color: white,
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold)),
                        ]),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

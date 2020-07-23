import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geocoder/geocoder.dart';
import "package:latlong/latlong.dart" as latLng;
import 'package:resto/widget/InputPage.dart';



class PlaceholderWidget extends StatefulWidget {
  final Color color;

  PlaceholderWidget(this.color);

  @override
  _PlaceholderWidgetState createState() => _PlaceholderWidgetState();
}

class _PlaceholderWidgetState extends State<PlaceholderWidget> {
  List<Marker> allMarkers = [];

  String inputaddr = '';

  static String color = "green";

  // addToList() async {
  //   final query = inputaddr;
  //   var addresses = await Geocoder.local.findAddressesFromQuery(query);
  //   var first = addresses.first;
  //   Firestore.instance.collection('markers').add({
  //     'coords':
  //         new GeoPoint(first.coordinates.latitude, first.coordinates.longitude),
  //     'place': first.featureName
  //   });
  // }

  // Future addMarker() async {
  //   await showDialog(
  //       context: context,
  //       barrierDismissible: true,
  //       builder: (BuildContext context) {
  //         return new SimpleDialog(
  //           title: new Text(
  //             'Add Marker',
  //             style: new TextStyle(fontSize: 17.0),
  //           ),
  //           children: <Widget>[
  //             new TextField(
  //               onChanged: (String enteredLoc) {
  //                 setState(() {
  //                   inputaddr = enteredLoc;
  //                 });
  //               },
  //             ),
  //             new SimpleDialogOption(
  //               child: new Text('Add It',
  //                   style: new TextStyle(color: Colors.blue)),
  //               onPressed: () {
  //                 addToList();
  //                 Navigator.of(context).pop();
  //               },
  //             )
  //           ],
  //         );
  //       });
  // }

  Widget loadMap() {
    return StreamBuilder(
      stream: Firestore.instance.collection('markers').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return Text('Loading maps.. Please Wait');
        for (int i = 0; i < snapshot.data.documents.length; i++) {
          allMarkers.add(new Marker(
              width: 45.0,
              height: 45.0,
              point: new latLng.LatLng(snapshot.data.documents[i]['coords'].latitude,
                  snapshot.data.documents[i]['coords'].longitude),
              builder: (context) => new Container(
                    child: IconButton(
                      icon: Icon(Icons.location_on),
                      color: Colors.red,
                      iconSize: 45.0,
                      onPressed: () {
                        print(snapshot.data.documents[i]['place']);
                        var a =snapshot.data.documents[i]['place'];
                        Navigator.push(context, new MaterialPageRoute(
                          builder: (BuildContext context) => new InputPage(a),
                        ));
                      },
                    ),
                  )));
        }
        return Center(
          child: Column(
            children: <Widget>[
              Column(
                children: <Widget>[
            Container(
            // here
            height: MediaQuery.of(context).size.height ,
            alignment: Alignment.centerLeft,
             child: new FlutterMap(
                  options: new MapOptions(
                          //by default panvel location
                      center: new latLng.LatLng(18.9894, 73.1175), minZoom: 10.0),
                  layers: [
                    new TileLayerOptions(
                        urlTemplate:
                        "http://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                        subdomains: ['a', 'b', 'c']),
                    new MarkerLayerOptions(markers: allMarkers)
                  ]),
            )

                ],
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
//        appBar: new AppBar(
//          title: new Text(' Maps'),
//          leading: new IconButton(
//            icon: Icon(Icons.add),
//            onPressed: addMarker,
//          ),
//          centerTitle: true,
//        ),
        body: loadMap());
  }
}

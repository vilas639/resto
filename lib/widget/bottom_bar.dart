import 'package:flutter/material.dart';
import 'package:resto/widget/InputPage.dart';
import 'package:resto/widget/PlaceholderWidget.dart';

class BottomBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 6.0,
        color: Colors.transparent,
        elevation: 9.0,
        clipBehavior: Clip.antiAlias,
        child: Container(
            height: 50.0,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25.0),
                    topRight: Radius.circular(25.0)
                ),
                color: Colors.white
            ),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                      height: 50.0,
                      width: MediaQuery.of(context).size.width /2 - 40.0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[


                          new IconButton(
                              icon : new Icon(Icons.home, color: Color(0xFF676E79))
                              , onPressed: null),
                          new IconButton(
                              icon : new Icon(Icons.report, color: Color(0xFF676E79))
                              , onPressed: (){
                          Navigator.push(
                          context, MaterialPageRoute(builder: (context) => new InputPage("")));
                          })
                        ],
                      )
                  ),
                  Container(
                      height: 50.0,
                      width: MediaQuery.of(context).size.width /2 - 40.0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[

                          new IconButton(
                              icon : new Icon(Icons.history, color: Color(0xFF676E79))
                              , onPressed: null),
                          new IconButton(
                            icon : new Icon(Icons.map, color: Color(0xFF676E79))
                              ,  onPressed: () {
                            Navigator.push(
                                context, MaterialPageRoute(builder: (context) => new PlaceholderWidget(Colors.blue)));
                          },
                          )
                        ],
                      )
                  ),
                ]
            )
        )
    );
  }
}
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:resto/model/myData.dart';
import 'package:resto/widget/PlaceholderWidget.dart';
import 'package:resto/widget/bottom_bar.dart';


class ShowDataPage extends StatefulWidget {
  @override
  _ShowDataPageState createState() => _ShowDataPageState();
}

class _ShowDataPageState extends State<ShowDataPage>
    with SingleTickerProviderStateMixin {
  List<myData> allData1 = [];

  TabController _tabController;

  @override
  void initState() {
    _tabController = new TabController(length: 3, vsync: this, initialIndex: 1);
    DatabaseReference ref = FirebaseDatabase.instance.reference();
    ref.child('node-name').once().then((DataSnapshot snap) {
      var keys = snap.value.keys;
      var data = snap.value;
      allData1.clear();
      for (var key in keys) {
        myData d = new myData(
          data[key]['name'],
          data[key]['location'],
          data[key]['km'],
            data[key]['rupees'],
            data[key]['date']
        );

        allData1.add(d);

      }
      setState(() {

        print('Length : ${allData1.length}');
        print(allData1);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0.0,
          centerTitle: true,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Color(0xFF545D68)),
            onPressed: () {},
          ),
          title: Text('History',
              style: TextStyle(
                  fontFamily: 'Varela',
                  fontSize: 20.0,
                  color: Color(0xFF545D68))),

        ),
        body:ListView(
          padding: EdgeInsets.all(1.0),
          children: <Widget>[
            SizedBox(height: 15.0),

            Container(
                height: MediaQuery.of(context).size.height - 50.0,
                width: double.infinity,
                child: TabBarView(
                    controller: _tabController,
                    children: [
                      new Text("This is Tab View"),
                      new SingleChildScrollView(
                        child: Column(
                            children: <Widget>[
                              new Container(
                                  height: MediaQuery.of(context).size.height * 0.8,
                                  child: allData1.length == 0
                                      ? Center(
                                    child: CircularProgressIndicator(),
                                  )
                                      : new ListView.builder(
                                    shrinkWrap: true,

                                    scrollDirection: Axis.vertical,
                                    itemCount: allData1.length,
                                    itemBuilder: (_, index) {
                                      return UI(
                                        allData1[index].name,
                                        allData1[index].location,
                                        allData1[index].km,
                                        allData1[index].Rupees,
                                        allData1[index].Date,

                                      );

                                    },
                                  )
                              ),
                              ],)

                      ),

                      PlaceholderWidget(Colors.blue),
                    ]
                )
            )
          ],
        ),
        floatingActionButton: new FloatingActionButton(
          backgroundColor: Color(0xFFF17532),
          child: const Icon(Icons.add),
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => new PlaceholderWidget(Colors.blue)));
          },
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: BottomBar(),
    );
  }



  Widget UI(String name, String location, String km,String Rupees,String Date) {
    return new Card(
      elevation: 10.0,
      child: new Container(
        padding: new EdgeInsets.all(20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                  width: 210.0,
                  child: Row(children: [
                    Container(
                        height: 75.0,
                        width: 75.0,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(7.0),
                            color: Color(0xFFFFE3DF)),
                        child: Center(
                            child:
                            Image.asset("assets/fuel.png", height: 50.0, width: 50.0))),
                    SizedBox(width: 20.0),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(name,
                            style: GoogleFonts.notoSans(
                                fontSize: 18.0, fontWeight: FontWeight.w800,
                              textStyle: TextStyle(color: Color(0xFFF68D7F))
                            )),
                        Text(location,
                            style: GoogleFonts.notoSans(
                                fontSize: 14.0, fontWeight: FontWeight.w400)),

                        Row(
                          children: <Widget>[
                            Text(
                              '\Rs ' + Rupees,
                              style: GoogleFonts.lato(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.w600,
                                  textStyle: TextStyle(color: Color(0xFFF68D7F))),
                            ),
                            SizedBox(width: 3.0),

                          ],
                        )
                      ],
                    )
                  ])),

              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Text(Date,
                      style: GoogleFonts.notoSans(
                          fontSize: 18.0, fontWeight: FontWeight.w800,

                      )),



                  Text(
                    km+ ' \Km ',
                    style: GoogleFonts.lato(
                        fontSize: 12.0,

                        fontWeight: FontWeight.w600,
                        textStyle: TextStyle(
                            color: Colors.grey.withOpacity(0.9))),
                  ),
                  Text("",
                      style: GoogleFonts.notoSans(
                          fontSize: 14.0, fontWeight: FontWeight.w400)),
                ],
              )
            ],
          )),
      );

  }



}

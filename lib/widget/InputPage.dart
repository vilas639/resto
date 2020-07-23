import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:resto/ShowDataPage.dart';
import 'package:validate/validate.dart';

class InputPage extends StatefulWidget {

  String loca;
  InputPage (this.loca);

  @override
  State<StatefulWidget> createState() => new _InputPagetate();
}

class _LoginData {
  String name = '';
  String location = '';
  String km = '';
  String Rupees = '';
  String Date = '';
}

class _InputPagetate extends State<InputPage> {
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  _LoginData _data = new _LoginData();

  TextEditingController _locationcontroller = new TextEditingController();

  String _validateEmail(String value) {
    // If empty value, the isEmail function throw a error.
    // So I changed this function with try and catch.
    try {
      Validate.isEmail(value);
    } catch (e) {
      return 'The E-mail Address must be a valid email address.';
    }

    return null;
  }

  String _validatePassword(String value) {
    if (value.length < 3) {
      return 'please Enter Data';
    }

    return null;
  }

  String _validateMoney(String value) {
    if (value.length < 1) {
      return 'please Enter Data';
    }

    return null;
  }


  void submit() {
    Center(
      child: CircularProgressIndicator(),
    );
    // First validate form.
    if (this._formKey.currentState.validate()) {
      _formKey.currentState.save(); // Save our form now.

      print('Printing the  data.');
      print('name: ${_data.name}');
      print('km: ${_data.km}');

      final DateTime now = DateTime.now();
      final DateFormat formatter = DateFormat('yyyy-MM-dd');
      final String formatted = formatter.format(now);
      print(formatted); // something like 2013-04-20

      DatabaseReference ref = FirebaseDatabase.instance.reference();
      var data = {
        "name": _data.name,
        "km": _data.km,
        "location": _data.location,
        "rupees": _data.Rupees,
        "date": formatted,
      };
      ref.child('node-name').push().set(data).then((v) {
        _formKey.currentState.reset();

        Navigator.push(context,
            MaterialPageRoute(builder: (context) => new ShowDataPage()));
      });


    }
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;

    setState(() {
      var loc1= widget.loca;
      print("new loca"+loc1);
      print(this._locationcontroller.text);

      this._locationcontroller.text = loc1;
    });
    return new Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Color(0xFF545D68)),
          onPressed: () {},
        ),
        title: Text('Add Fuel',
            style: TextStyle(
                fontFamily: 'Varela',
                fontSize: 20.0,
                color: Color(0xFF545D68))),

      ),
      body: new Container(
          padding: new EdgeInsets.all(20.0),
          child: new Form(
            key: this._formKey,
            child: new ListView(
              children: <Widget>[
                new TextFormField(
                    keyboardType: TextInputType.text, // Use email input type for emails.
                    decoration: new InputDecoration(
                        hintText: 'Enter Name',
                        labelText: 'Enter Name'
                    ),
                    validator: this._validatePassword,
                    onSaved: (String value) {
                      this._data.name = value;
                    }
                ),
                new TextFormField(

                    decoration: new InputDecoration(
                        hintText: 'Location',
                        labelText: 'Enter your location'
                    ),
                    validator: this._validatePassword,
                    onSaved: (String value) {
                      this._data.location = value;
                    },
                    controller: _locationcontroller
                ),
                new TextFormField(
                    keyboardType: TextInputType.number,

                    decoration: new InputDecoration(
                        hintText: 'Km',
                        labelText: 'Enter your Km'
                    ),
                    validator: this._validateMoney,
                    onSaved: (String value) {
                      this._data.km = value;
                    }
                ),
                new TextFormField(
                    keyboardType: TextInputType.number,

                    decoration: new InputDecoration(
                        hintText: 'Rupees',
                        labelText: 'Enter your Money'
                    ),
                    validator: this._validateMoney,
                    onSaved: (String value) {
                      this._data.Rupees = value;
                    }
                ),
                new Container(
                  width: screenSize.width,
                  child: new RaisedButton(
                    child: new Text(
                      'Save',
                      style: new TextStyle(
                          color: Colors.white
                      ),
                    ),
                    onPressed: this.submit,
                    color: Colors.blue,
                  ),
                  margin: new EdgeInsets.only(
                      top: 20.0
                  ),
                ),
                new Container(
                  width: screenSize.width,
                  child: new RaisedButton(
                    child: new Text(
                      'Show Data',
                      style: new TextStyle(
                          color: Colors.white
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => new ShowDataPage()));
                    },
                    color: Colors.blue,
                  ),
                  margin: new EdgeInsets.only(
                      top: 20.0
                  ),
                )
              ],
            ),
          )
      ),
    );
  }


}
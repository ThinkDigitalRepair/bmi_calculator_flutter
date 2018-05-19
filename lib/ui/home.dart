import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new HomeState();
  }
}

class HomeState extends State<Home> {
  double bmi;

  var _bmiText = "";

  @override
  Widget build(BuildContext context) {
    final TextEditingController _ageController = new TextEditingController();
    final TextEditingController _heightController = new TextEditingController();
    final TextEditingController _weightController = new TextEditingController();
    ErrorSnackBar errorSnackBar;

    void calculate() {
      var age, height, weight;
      if (_ageController.text.isNotEmpty) {
        age = int.parse(_ageController.text);
      }
      if (_heightController.text.isNotEmpty) {
        height = int.parse(_heightController.text);
      }
      if (_weightController.text.isNotEmpty) {
        weight = int.parse(_weightController.text);
      }

      // make sure all variables are input.
      if (age != null && height != null && weight != null) {
        bmi = weight / (height * height) * 703;
        setState(() {
          _bmiText = "Your BMI: ${bmi.toStringAsFixed(2)}";
        });
      } else {
        debugPrint("All fields not filled");
      }
    }

    return new Scaffold(
      appBar: new AppBar(
        title: new Text('BMI'),
        centerTitle: true,
        backgroundColor: Colors.pinkAccent,
        actions: <Widget>[
          new IconButton(
              icon: Icon(Icons.format_line_spacing),
              onPressed: () {
                setState(() {
                  _ageController.text = '27';
                  _heightController.text = '5.75';
                  _weightController.text = '145';
                });
              })
        ],
      ),
      body: new ListView(
        children: <Widget>[
          new Center(
            child: new Image.asset("images/bmilogo.png"),
          ),
          new Padding(padding: new EdgeInsets.all(18.0)),
          new Container(
            color: Colors.grey.shade300,
            padding: new EdgeInsets.all(15.0),
            child: new Column(
              children: <Widget>[
                new TextField(
                  controller: _ageController,
                  keyboardType: TextInputType.number,
                  decoration: new InputDecoration(
                      icon: new Icon(Icons.person_outline), labelText: "Age"),
                ),
                new TextField(
                  controller: _heightController,
                  keyboardType: TextInputType.number,
                  decoration: new InputDecoration(
                      icon: new Icon(Icons.insert_chart),
                      labelText: "Height (in feet)"),
                ),
                new TextField(
                  controller: _weightController,
                  keyboardType: TextInputType.number,
                  decoration: new InputDecoration(
                      icon: new Icon(Icons.line_weight),
                      labelText: "Weight (in lbs)"),
                ),
                new Padding(padding: new EdgeInsets.only(top: 20.0)),
                new RaisedButton(
                  onPressed: calculate,
                  color: Colors.pinkAccent,
                  child: new Text(
                    "Calculate",
                    style: new TextStyle(color: Colors.white),
                  ),
                )
              ],
            ),
          ),
          new Padding(
            padding: const EdgeInsets.all(20.0),
            child: new Center(
                child: new Text(
              bmi == null ? "" : _bmiText,
              style: new TextStyle(
                  color: Colors.blueAccent,
                  fontSize: 20.0,
                  fontWeight: FontWeight.w800,
                  fontStyle: FontStyle.italic),
            )),
          ),
        ],
      ),
    );
  }
}

class ErrorSnackBar extends SnackBar {
  @override
  Widget build(BuildContext context) {
    return new SnackBar(content: new Text("Please fill in all the fields."));
  }
}

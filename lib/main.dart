import 'package:flutter/material.dart';
// import 'package:radar/src/counter.dart';
import 'package:radar/src/dataPrasing.dart';
import 'package:radar/src/lineCharts.dart';
import 'package:radar/src/functionality.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Radar App',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: MyHomePage(title: 'Radar  SI tool'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // double _counter = 0;
  var _connectButton = ConnectButton();
  bool stop = true;

  List<List<double>> _plotListAmplitude = [
    [],
  ];
  List<List<double>> _plotListPhase = [
    [],
  ];

  void playStartRadar() async {
    DataToPlot _pulseList = new DataToPlot();
    stop = false;

    try {
      await _connectButton.connect();
      while (stop == false) {
        await _connectButton.startSearch();
        // _counter = 0;
        _pulseList = await _connectButton.readData();
        for (int i = 0; i < _pulseList.ns; i++) {
          _plotListAmplitude = [];
          _plotListPhase = [];
          setState(() {
            _plotListAmplitude = _pulseList.amplitude;
            _plotListPhase = _pulseList.phase;
            // _counter = i.toDouble(); //_pulseList[0][0][0];
          });
          _pulseList = await _connectButton.readData();
        }
      }
    } catch (err) {
      print("hots manger not running");
      print(err.toString());

      // todo: move to diffrent file
      showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Host Manger not running'),
            content: const Text('Try to start host manger or rest the device'),
            actions: <Widget>[
              FlatButton(
                child: Text('Ok'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }

  void stopRadar() async {
    stop = true;
    try {
      await _connectButton.stopRadar();
    } catch (err) {
      print(err.toString());
    }
  }

  void restartStartRadar() async {
    stopRadar();
    setState(() {
      _plotListAmplitude = [
        [],
      ];
      _plotListPhase = [
        [],
      ];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: new Container(
            padding: EdgeInsets.all(20.0),
            child: new Column(
              children: <Widget>[
                Expanded(
                  child: ListView(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      children: <Widget>[
                        Container(
                          height: 200,
                          width: 400,
                          child: SimpleLineChart(_plotListAmplitude),
                        ),
                        Container(
                          height: 200,
                          width: 400,
                          child: SimpleLineChart(_plotListPhase),
                        ),
                      ]),
                ),
                new Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    new FloatingActionButton(
                      backgroundColor: Colors.green,
                      onPressed: playStartRadar,
                      child: new Icon(Icons.play_arrow),
                    ),
                    SizedBox(width: 20.0),
                    new FloatingActionButton(
                      backgroundColor: Colors.red,
                      onPressed: stopRadar,
                      child: new Icon(Icons.stop),
                    ),
                    SizedBox(width: 20.0),
                    new FloatingActionButton(
                      backgroundColor: Colors.blue,
                      onPressed: restartStartRadar,
                      child: new Icon(Icons.replay),
                    ),
                  ],
                )
              ],
            )));
  }
}

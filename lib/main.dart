import 'package:flutter/material.dart';
import 'package:radar/src/counter.dart';
import 'package:radar/src/dataPrasing.dart';
import 'package:radar/src/lineCharts.dart';
import 'package:radar/src/functionality.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Radar App',
      theme: ThemeData(primarySwatch: Colors.green),
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
  double _counter = 0;
  var _connectButton = ConnectButton();

  List<List<double>> _plotList = [[],];

  void connectToSocket() async {
    DataToPlot _pulseList = new DataToPlot();

    try {
      await _connectButton.connet();
      _counter = 0;
      for (int i = 0; i < 25; i++) {
        _pulseList = await _connectButton.stratRadar();
        _plotList = [];
        setState(() {
          _plotList = _pulseList.amplitude;
          _counter = i.toDouble(); //_pulseList[0][0][0];
          // _historyList.addAll(_pulseList[0]);
        });
        
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Center(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Counter(counter: _counter),
          Container(
            height: 300,
            child: SimpleLineChart(_plotList),
          )
        ])),
        floatingActionButton: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            FloatingActionButton(
              onPressed: connectToSocket,
              tooltip: 'Connect',
              child: Icon(Icons.play_arrow,),
              
            ),
          ],
        ));
  }
}

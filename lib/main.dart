import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as prefix0;
import 'package:radar/src/counter.dart';
// import 'package:radar/src/dataPrasing.dart';
import 'package:radar/src/line_charts.dart';
import 'package:radar/src/functionality.dart';
// import 'dart:io';


// to Omri
//1- add pop if faild to connect - add massage start host manger
//2- fix the socket connect, send, read - http://jamesslocum.com/post/67566023889 
//3- fix dataParssing 

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
  int _counter = 0;
  // Socket _sock;
  // String _respond;
  var _connectButton=ConnectButton();

  List<int> _historyList = [0];

  void connectToSocket() {
    _connectButton.connet();
    }
  //   try {
  //     _sock = await Socket.connect('127.0.0.1', 12346);
  //     print("test");
  //     print(_sock.toString());
  //     print("test");
  //     print('Connected to: ${_sock.remoteAddress.address}:${_sock.remotePort}');
  //     _sock.listen((data) {
  //       _respond = String.fromCharCodes(data).trim();
  //       print(String.fromCharCodes(data).trim());
  //     }, onDone: () {
  //       print("Done");
  //       _sock.destroy();
  //     });
  //     _sock.write(
  //         '{"Group": "sensing","OpCode": "open","AutoRecovery": true,"SendNotification": false}');
  //     // _sock.write('{"Group":"sensing","OpCode":"change_mode","Mode":"Search","PreferredChannel":9} ');
  //     _sock.write(
  //         '{"Group": "sensing","OpCode": "read_data","MaxSizeDwords": 1024}');

  //     // _sock.write('{"OpCode": "change_mode", "Group": "sensing", "Mode": "Search", "PreferredChannel": 9}');
  //     // for (int i = 0; i < 1; i++) {
  //     //   print("test ${i}");
  //     //   _sock.write(
  //     //       '{"OpCode": "read_data", "Group": "sensing", "MaxSizeDwords": 524288}');
  //     // }
  //   } catch (err) {
  //     print('${err.toString()}');
  //   }
  // }

  // void startSamplingFromSocket() {
  //   // _sock.write('{"OpCode": "read_data", "Group": "sensing", "MaxSizeDwords": 524288}');
  //   // _sock.listen((data) {
  //   //     print(new String.fromCharCodes(data).trim());
  //   //   }, onDone: () {
  //   //     print("Done");
  //   //     // _sock.destroy();
  //   //   });
  //   // print("test");
  //   print(_respond);

  void _incrementCounter() {
    setState(() {
      _counter++;
      // var a = ConverData(
      //     '{\n   "type" : "JsonBasicResponse",\n   "BeginTimestamp" : "2019-03-26 05:48:19.774",\n   "EndTimestamp" : "2019-03-26 05:48:19.798",\n   "Group" : "sensing",\n   "HostVersion" : "1.5.0.6",\n   "OpCode" : "open",\n   "Success" : true\n}');
      // var _a = ConverData(
      //     '{\n   "type" : "SensingReadDataResponse",\n   "BeginTimestamp" : "2019-03-26 05:48:19.856",\n   "DataBase64" : "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",\n   "DriTsfs" : [ 11052313239, 11052313239 ],\n   "DropCntFromLastRead" : 0,\n   "EndTimestamp" : "2019-03-26 05:48:19.873",\n   "Group" : "sensing",\n   "HostVersion" : "1.5.0.6",\n   "NumRemainingBursts" : 0,\n   "OpCode" : "read_data",\n   "Success" : true\n}');
      // DataStructure b = a.getVersion();
      // DataStructurePlus _b = _a.readData();
      // // var decoded = base64.decode(b);

      // print(b.beginTimeStamp);
      // print(_b.dataBase64);
      // Burst burst = Burst(_b.dataBase64);
      // print(burst.mdSizeDw);
      // print("amplitude");
      // print(burst.pulse[0].amplitude);
      // print(burst.pulse[0].phase);
      _historyList.add(_counter);


    });
  }

  void _decrementCounter() {
    setState(() {
      _counter--;
      _historyList.add(_counter);
    });
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
            child: SimpleLineChart(_historyList),
          )
        ])),
        floatingActionButton: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            FloatingActionButton(
              onPressed: _decrementCounter,
              tooltip: 'Test',
              child: Icon(Icons.remove),
            ),
            FloatingActionButton(
              onPressed: _incrementCounter,
              tooltip: 'Increment',
              child: Icon(Icons.add),
            ),
            FloatingActionButton(
              onPressed: connectToSocket,
              tooltip: 'Connect',
              child: Icon(Icons.confirmation_number),
            ),
            // FloatingActionButton(
            //   onPressed: startSamplingFromSocket,
            //   tooltip: 'Start ample',
            //   child: Icon(Icons.mail),
            // ),
          ],
        ));
  }
}

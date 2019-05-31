// import 'package:flutter/material.dart';
import 'package:radar/src/dataPrasing.dart';
import 'package:radar/src/socket.dart';

String getVersion = '{"OpCode": "get_version", "Group": "host"}';
String autoRecovery =
    '{"AutoRecovery": true, "OpCode": "open", "Group": "sensing", "SendNotification": false}';
String changeMode =
    '{"OpCode": "change_mode", "Group": "sensing", "Mode": "Search", "PreferredChannel": 9}';
String readData =
    '{"OpCode": "read_data", "Group": "sensing", "MaxSizeDwords": 524288}';
// int delay=100;

class ConnectButton {
  var simplseSoket = SimplseSoket();

  void connet() async {
    // get Host manger version 1.5.0.6
    var _hostMangerVer = RadarDataStructure(await getHostMangerVersion());
    print("hostMangerVer");
    print(_hostMangerVer.beginTimeStamp);
    print(_hostMangerVer.hostVersion);
    print(_hostMangerVer.opCode);
    print("********************");



    // trigr Auto Recovery
    // var _autoRecovery = RadarDataStructure(await triggerAutoRecovery());
    // print("autoRecovery");
    // print(_autoRecovery.beginTimeStamp);
    // print(_autoRecovery.opCode);
    // print("********************");


    // // trigr Change mode - satrt sample
    // var _changeMode = RadarDataStructure(await triggerChangeMode());
    // print(_changeMode.beginTimeStamp);
    
    // var _readData = RadarDataStructurePulse(await triggerReadData());
    // print(_readData.beginTimeStamp);
    // print(_readData.beginTimeStamp);
    // print(_readData.dataBase64);
  }

  Future<String> getHostMangerVersion() async {
    return simplseSoket.connectAndSend(getVersion);
  }

  Future<String> triggerAutoRecovery() async {
    return simplseSoket.connectAndSend(autoRecovery);
  }

  Future<String> triggerChangeMode() async{
    return simplseSoket.connectAndSend(changeMode);
  }

  Future<String> triggerReadData() async{
    return simplseSoket.connectAndSend(readData);
  }
}

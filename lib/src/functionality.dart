import 'package:radar/src/dataPrasing.dart';
import 'package:radar/src/socketControl.dart';
import 'dart:io';

const String _getVersion = '{"OpCode": "get_version", "Group": "host"}';
const String _autoRecovery =
    '{"AutoRecovery": true, "OpCode": "open", "Group": "sensing", "SendNotification": false}';
const String _changeModeSearch =
    '{"OpCode": "change_mode", "Group": "sensing", "Mode": "Search", "PreferredChannel": 9}';
const String _changeModeStop =
    '{"OpCode": "change_mode", "Group": "sensing", "Mode": "Stop", "PreferredChannel": 0}';
const String _readData =
    '{"OpCode": "read_data", "Group": "sensing", "MaxSizeDwords": 524288}';
const int delayBetweenCommand = 50;
const int delayBetweensampling = 250;

class ConnectButton {
  var socket = SocketControl();

  Future<void> connect() async {
    await socket.connect();
    sleep(const Duration(milliseconds: delayBetweenCommand));
    RadarDataStructure(await socket.writeAndWaitForReponse(_getVersion));
    sleep(const Duration(milliseconds: delayBetweenCommand));
    RadarDataStructure(await socket.writeAndWaitForReponse(_autoRecovery));
  }

  Future<void> startSearch() async {
    await socket.connect();
    sleep(const Duration(milliseconds: delayBetweenCommand));
    RadarDataStructure(await socket.writeAndWaitForReponse(_changeModeStop));
    sleep(const Duration(milliseconds: delayBetweenCommand));
    RadarDataStructure(await socket.writeAndWaitForReponse(_changeModeSearch));
  }

  Future<DataToPlot> readData() async {
    sleep(const Duration(milliseconds: delayBetweensampling));
    Burst burst =
        RadarDataStructurePulse(await socket.writeAndWaitForReponse(_readData))
            .burst;
    DataToPlot dataToPlot = new DataToPlot();
    dataToPlot.amplitude =
        burst.pulse.map<List<double>>((amp) => amp.amplitude).toList();
    dataToPlot.phase =
        burst.pulse.map<List<double>>((pha) => pha.phase).toList();
    dataToPlot.ns = burst.ns;
    dataToPlot.np = burst.np;
    return dataToPlot;
  }

  Future<void> stopRadar() async {
    await socket.connect();
    RadarDataStructure(await socket.writeAndWaitForReponse(_changeModeStop));
  }
}

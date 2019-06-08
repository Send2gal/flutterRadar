import 'package:radar/src/dataPrasing.dart';
import 'package:radar/src/socketControl.dart';
import 'dart:io';

const String getVersion = '{"OpCode": "get_version", "Group": "host"}';
const String autoRecovery =
    '{"AutoRecovery": true, "OpCode": "open", "Group": "sensing", "SendNotification": false}';
const String changeMode =
    '{"OpCode": "change_mode", "Group": "sensing", "Mode": "Search", "PreferredChannel": 9}';
const String readData =
    '{"OpCode": "read_data", "Group": "sensing", "MaxSizeDwords": 524288}';
const int delayBetweenCommand = 50;
const int delayBetweensampling = 250;

class ConnectButton {
  var socket = SocketControl();

  Future<void> connet() async {
    await socket.connect();

    print(
        '${RadarDataStructure(await socket.writeAndWaitForReponse(getVersion)).endTimeStemp} Got version');
    sleep(const Duration(milliseconds: delayBetweenCommand));
    print(
        '${RadarDataStructure(await socket.writeAndWaitForReponse(autoRecovery)).endTimeStemp} autoRecovery');
    sleep(const Duration(milliseconds: delayBetweenCommand));
    print(
        '${RadarDataStructure(await socket.writeAndWaitForReponse(changeMode)).endTimeStemp} changeMode');
  }

  // chnage the dynamic to diffrent
  Future<DataToPlot> stratRadar() async {
    sleep(const Duration(milliseconds: delayBetweensampling));
    Burst burst = RadarDataStructurePulse(await socket.writeAndWaitForReponse(readData)).burst;
    DataToPlot dataToPlot = new DataToPlot();
    dataToPlot.amplitude = burst.pulse.map<List<double>>((amp) => amp.amplitude).toList();
    dataToPlot.phase = burst.pulse.map<List<double>>((pha) => pha.phase).toList();
    return dataToPlot;
  }
}

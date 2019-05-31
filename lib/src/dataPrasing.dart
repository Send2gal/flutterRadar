// import 'dart:typed_data';
import 'dart:convert';
import 'dart:typed_data';
// import 'dart:math';

class RadarDataStructure {
  final String type;
  final String beginTimeStamp;
  final String endTimeStemp;
  final String group;
  final String hostVersion;
  final String opCode;
  final bool success;

  factory RadarDataStructure(String jsonString) {
    Map decoded = jsonDecode(jsonString);
    return new RadarDataStructure._(
        decoded['\$type'],
        decoded['BeginTimestamp'],
        decoded['EndTimestamp'],
        decoded['Group'],
        decoded['HostVersion'],
        decoded['OpCode'],
        decoded['Success']);
  }

  RadarDataStructure._(this.type, this.beginTimeStamp, this.endTimeStemp,
      this.group, this.hostVersion, this.opCode, this.success);
}

// todo: ask Omri how to inherit class like this
class RadarDataStructurePulse{
  final String type;
  final String beginTimeStamp;
  final String endTimeStemp;
  final String group;
  final String hostVersion;
  final String opCode;
  final bool success;
  final String dataBase64;
  final List driTsfs;
  final String dropCntFromLastRead;
  final String numRemainingBursts;

    factory RadarDataStructurePulse(String jsonString) {
    Map decoded = jsonDecode(jsonString);
    return new RadarDataStructurePulse._(
        decoded['\$type'],
        decoded['BeginTimeStamp'],
        decoded['EndTimeStemp'],
        decoded['Group'],
        decoded['HostVersion'],
        decoded['OpCode'],
        decoded['Success'],
        decoded['dataBase64'],
        decoded['driTsfs'],
        decoded['dropCntFromLastRead'],
        decoded['numRemainingBursts']);
  }

  RadarDataStructurePulse._(
      this.type,
      this.beginTimeStamp,
      this.endTimeStemp,
      this.group,
      this.hostVersion,
      this.opCode,
      this.success,
      this.dataBase64,
      this.driTsfs,
      this.dropCntFromLastRead,
      this.numRemainingBursts);

}

// class ConverData {
//   Map decoded;

//   ConverData(String jsonString) {
//     this.decoded = jsonDecode(jsonString);
//   }
//   RadarDataStructure parsing() {
//     return new RadarDataStructure(
//         this.decoded['type'],
//         this.decoded['BeginTimeStamp'],
//         this.decoded['EndTimeStemp'],
//         this.decoded['Group'],
//         this.decoded['HostVersion'],
//         this.decoded['OpCode'],
//         this.decoded['Success']);
//   }

//   DataStructurePlus readData() {
//     return new DataStructurePlus(
//         this.decoded['type'],
//         this.decoded['BeginTimeStamp'],
//         this.decoded['EndTimeStemp'],
//         this.decoded['Group'],
//         this.decoded['HostVersion'],
//         this.decoded['OpCode'],
//         this.decoded['Success'],
//         base64.decode(this.decoded['DataBase64']),
//         this.decoded['DriTsfs'],
//         this.decoded['dropCntFromLastRead'],
//         this.decoded['numRemainingBursts']);
//   }
// }

// class Burst {
//   int fwMagicNumber;
//   int fwTsfDriTime;
//   int fwTsfFirstPulse;
//   int np;
//   int tpUsec;
//   int mdSizeDw;
//   int ns;
//   int burstIdx;
//   int channel;
//   List pulse = [];

//   Burst(Uint8List data) {
//     this.fwMagicNumber =
//         ((data[3] << 24) | (data[2] << 16) | (data[1] << 8) | data[0]);
//     this.fwTsfDriTime =
//         ((data[7] << 24) | (data[6] << 16) | (data[5] << 8) | data[4]);
//     this.fwTsfFirstPulse =
//         ((data[11] << 24) | (data[10] << 16) | (data[9] << 8) | data[8]);
//     this.tpUsec = ((data[13] << 8) | data[12]);
//     this.np = ((data[15] << 8) | data[14]);
//     this.burstIdx = ((data[17] << 8) | data[16]);
//     this.ns = (data[18]);
//     this.mdSizeDw = (data[19]);
//     this.channel = (data[20]);
//     for (int i = 0; i < 26; i++) {
//       List pulseX = data.skip(32 + 104 * i).toList().take(104).toList();
//       pulse.add(Puls(pulseX));
//       // Puls p = Puls(puls_1);
//       // print(p.amplitude);
//       // print(p.phase);
//     }

//     // print(puls_1);
//   }
// }

// class Puls {
//   int burstIndex;
//   int pulseIndex;
//   Uint16List cir;
//   List<double> amplitude = [];
//   List<double> phase = [];

//   Puls(List puls) {
//     // print(puls);
//     this.burstIndex = ((puls[0] << 8) | puls[1]);
//     this.pulseIndex = ((puls[2] << 8) | puls[3]);
//     parsingPulse(puls.skip(4).toList());
//   }

//   void parsingPulse(List allIQ) {
//     // Normalize;
//     double n = 65535;

//     for (int j = 0; j < 25; j++) {
//       List iq = allIQ.skip(4 * j).toList().take(4).toList();
//       int i = ((iq[0] << 8) | iq[1]);
//       int q = ((iq[3] << 8) | iq[2]);

//       double iDouble = i.toDouble() / n;
//       double qDouble = q.toDouble() / n;

//       double amp = sqrt(pow(iDouble, 2) + pow(qDouble, 2));
//       double pha = atan2(i, q);
//       this.amplitude.add(amp);
//       this.phase.add(pha);
//     }
//   }
// }

// // class Sensing extends ConverData {
// //   Burst burst;

// //   Sensing(String jsonString): super(jsonString){
// //     readData();
// //     this.burst = Burst(this.dataBase64);
// //   }

// // }

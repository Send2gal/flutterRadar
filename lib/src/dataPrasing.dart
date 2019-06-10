// import 'dart:typed_data';
import 'dart:convert';
import 'dart:typed_data';
import 'dart:math';

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
class RadarDataStructurePulse extends RadarDataStructure {
  final String dataBase64;
  final Burst burst;
  final List driTsfs;
  final int dropCntFromLastRead;
  final int numRemainingBursts;

  factory RadarDataStructurePulse(String jsonString) {
    Map decoded = jsonDecode(jsonString);
    return new RadarDataStructurePulse._(
        decoded['\$type'],
        decoded['BeginTimestamp'],
        decoded['EndTimestamp'],
        decoded['Group'],
        decoded['HostVersion'],
        decoded['OpCode'],
        decoded['Success'],
        decoded['DataBase64'],
        decoded['DriTsfs'],
        decoded['DropCntFromLastRead'],
        decoded['DumRemainingBursts'],
        Burst(decoded['DataBase64']));
  }

  RadarDataStructurePulse._(
      type,
      beginTimeStamp,
      endTimeStemp,
      group,
      hostVersion,
      opCode,
      success,
      this.dataBase64,
      this.driTsfs,
      this.dropCntFromLastRead,
      this.numRemainingBursts,
      this.burst)
      : super._(type, beginTimeStamp, endTimeStemp, group, hostVersion, opCode,
            success);
}

class Burst {
  int fwMagicNumber;
  int fwTsfDriTime;
  int fwTsfFirstPulse;
  int np;
  int tpUsec;
  int mdSizeDw;
  int ns;
  int burstIdx;
  int channel;
  List pulse = [];

  Burst(String data) {
    Uint8List dataList = base64.decode(data);
    this.fwMagicNumber = ((dataList[3] << 24) |
        (dataList[2] << 16) |
        (dataList[1] << 8) |
        dataList[0]);
    this.fwTsfDriTime = ((dataList[7] << 24) |
        (dataList[6] << 16) |
        (dataList[5] << 8) |
        dataList[4]);
    this.fwTsfFirstPulse = ((dataList[11] << 24) |
        (dataList[10] << 16) |
        (dataList[9] << 8) |
        dataList[8]);
    this.tpUsec = ((dataList[13] << 8) | dataList[12]);
    this.np = ((dataList[15] << 8) | dataList[14]);
    this.burstIdx = ((dataList[17] << 8) | dataList[16]);
    this.ns = (dataList[18]);
    this.mdSizeDw = (dataList[19]);
    this.channel = (dataList[20]);
    for (int i = 0; i < 26; i++) {
      List pulseX = dataList.skip(32 + 104 * i).toList().take(104).toList();
      pulse.add(Puls(pulseX, ns));
    }
  }
}

class Puls {
  final int ns;
  int burstIndex;
  int pulseIndex;
  Uint16List cir;
  List<double> amplitude = [];
  List<double> phase = [];

  Puls(List puls, this.ns) {
    this.burstIndex = ((puls[1] << 8) | puls[0]);
    this.pulseIndex = ((puls[3] << 8) | puls[2]);
    parsingPulse(puls.skip(4).toList());
  }

  int convertToSign(int n){
    if (n < 32768) {
      return n; 
    }
    else{
      return n-65536;
    }
  }
  

  void parsingPulse(List allIQ) {
    // Normalize;
    double n = 65536.0;

    for (int j = 0; j < ns; j++) {
      List iq = allIQ.skip(4 * j).toList().take(4).toList();
      int q = convertToSign((iq[3] << 8) | iq[2]);
      int i = convertToSign((iq[1] << 8) | iq[0]);

      double qDouble = q.toDouble() / n;
      double iDouble = i.toDouble() / n;

      // filter srong signal     
      // if (iDouble >= 0.9) {iDouble=0.0001;}
      // if (qDouble >= 0.9) {qDouble=0.0001;}

      double amp = 20 * (log(sqrt(pow(iDouble, 2) + pow(qDouble, 2)))/log(10));
      double pha = atan2(q, i)*(180.0 / pi);
      // debug print
      // print("i = ${iDouble}, q = ${qDouble}, amp = ${amp}, pha = ${pha}");
      // print("i = ${i}, i(double) = ${iDouble}, i^2 = ${pow(iDouble, 2)}");
      // print("q = ${q}, i(double) = ${qDouble}, i^2 = ${pow(qDouble, 2)}");
      this.amplitude.add(amp);
      this.phase.add(pha);
    }
  }
}

class DataToPlot {
  List<List<double>> amplitude;
  List<List<double>> phase;
  int ns;
  int np;
}


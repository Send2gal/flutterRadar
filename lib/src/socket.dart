import 'dart:io';

const String localIP = "127.0.0.1";
const int port = 12346;
const int delay = 100;

class SimplseSoket {
  Socket _socket;
  String respond = "";
  bool socketConnect = false;

  String connectAndSend(String commnad) {
    Socket.connect(localIP, port).then((socket) {
      //Establish the onData, and onDone callbacks
      socket.listen((data) {
        respond = new String.fromCharCodes(data).trim();
        // print(respond);
      }, onDone: () {
        print("Done");
        socket.destroy();
      });

      //Send the request
      socket.write(commnad);
    });
    return respond;
  }

  // void connect() {
  //   Socket.connect(localIP, port).then((socket) {
  //     socket.listen(dataHandler,
  //         onError: errorHandler, 
  //         onDone: doneHandler, 
  //         cancelOnError: false);
  //   });

  //   //Connect standard in to the socket
  //   stdin.listen(
  //       (data) => socket.write(new String.fromCharCodes(data).trim() + '\n'));
  // }

  // void dataHandler(data) {
  //   String respond = new String.fromCharCodes(data).trim();
  //   print(respond);
  // }

  // void errorHandler(error, StackTrace trace) {
  //   print(error);
  // }

  // void doneHandler() {
  //   _socket.destroy();
  // }

  // void write(String json) {
  // print(json);
  // _socket.write(json);
  // }
}
// void connect() async {
//   try {
//     if (socketConnect == true) {
//       return;
//     }
//       _socket = await Socket.connect(localIP, port).then(onValue);
//       _listener();
//       sleep(const Duration(milliseconds: delay));
//       socketConnect = true;

//   } catch (err) {
//     print('${err.toString()}');
//     socketConnect = false;
//   }
// }

// void disconnect() async {
//   _socket.destroy();
// }

// void writeJson(String json) {
//   print("socket connect $socketConnect");

//   try {
//     print(json);
//     respond = "";
//     print("is connected $socketConnect");
//     _socket.write(json);
//   } catch (err) {
//     print("gal - writeJson");
//     print('${err.toString()}');
//   }
// }

// void _listener() {
//   try {
//     _socket.listen(dataHandler,
//         onError: errorHandler, onDone: doneHandler, cancelOnError: false);
//   } catch (err) {
//     print("gal - read");
//     print('${err.toString()}');
//   }
// }

// String read() {
//   sleep(const Duration(milliseconds: delay));
//   return respond;
// }

// void dataHandler(data) {
//   respond += new String.fromCharCodes(data);
//   print(respond.trim());
// }

// void errorHandler(error, StackTrace trace) {
//   print(error);
// }

// void doneHandler() {
//   _socket.destroy();
//   socketConnect = false;
// }
// }

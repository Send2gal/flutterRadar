import 'dart:async';
import 'dart:io';

class SocketControl {
  bool _isConnected = false;
  Socket _socket;

  List<void Function(String data)> _listeners = [];

  Future<void> connect() async {
    if (_isConnected || _socket != null) {
      dispose();
    }
    _socket = await Socket.connect('127.0.0.1', 12346);
    _isConnected = true;
    _socket.listen(_notifyListeners);
  }

  void write(String data) {
    if (_isConnected) {
      return _socket.write(data);
    } else {
      throw 'Not connected, use "connect" method before writing';
    }
  }

  Future<String> writeAndWaitForReponse(String data) async {
    final result = Completer<String>(); 
    listenOnce(String response){
        result.complete(response);
    }

    addListener(listenOnce);
    write(data);
    var response = await result.future;
    removeListener(listenOnce);
    return response;
  }

  void _notifyListeners(List<int> data) {
    final parsedData = String.fromCharCodes(data).trim();
    _listeners.forEach((f) => f(parsedData));
  }

  void addListener(void Function(String data) listener) {
    _listeners.add(listener);
  }

  void removeListener(void Function(String data) listener) {
    _listeners.removeWhere((f) => f == listener);
  }

  void dispose() {
    _listeners = [];
    _socket.destroy();
    _isConnected = false;
  }
}

class SerialSocket {

}
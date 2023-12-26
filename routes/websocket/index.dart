import 'dart:async';
import 'dart:math';

import 'package:dart_frog/dart_frog.dart';
import 'package:dart_frog_web_socket/dart_frog_web_socket.dart';

Future<Response> onRequest(RequestContext context) async {
  final handler = webSocketHandler((channel, protocol) {
    print('connected');
    channel.sink.add('New user connected');
    Timer.periodic(Duration(seconds: Random().nextInt(10)), (timer) {
      channel.sink.add('Random text from user ${Random().nextInt(20)}');
    });
    channel.stream.listen((message) {
      // Handle incoming client messages.
      print(message);
      channel.sink.add('echo => $message');
    });
  });
  return handler(context);
}

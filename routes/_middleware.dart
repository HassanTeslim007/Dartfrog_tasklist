import 'package:dart_frog/dart_frog.dart';

Handler middleware(Handler handler) {
  return handler.use(requestLogger())
  .use(provider<String>((context) => 'Alpha learns Dart Frog'));
}

import 'package:dart_frog/dart_frog.dart';

String? greeting; //temporary storage (cache)

Handler middleware(Handler handler) {
  return handler.use(provider<String>((context) => greeting ?? 'Hello'));
}

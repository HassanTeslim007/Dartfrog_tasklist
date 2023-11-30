
import 'dart:convert';

import 'package:crypto/crypto.dart';

///extensions on string
extension StringExtension on String{

  /// extension tp get a sha 256 hashed string
  String get getHashValue => sha256.convert(utf8.encode(this)).toString();

}

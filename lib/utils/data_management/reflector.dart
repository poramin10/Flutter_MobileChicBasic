// ignore_for_file: unused_import, unnecessary_const

import 'package:reflectable/reflectable.dart';

class Reflector extends Reflectable {
  const Reflector() : super(invokingCapability);
}

const reflector = const Reflector();
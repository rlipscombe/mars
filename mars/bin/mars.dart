import 'dart:io';

import 'package:mars/parser.dart';

void main(List<String> arguments) async {
  var inputFile = File(arguments[0]);
  var lines = await inputFile.readAsString();

  var definition = RobotsDefinition();
  var parser = definition.build();

  var robots = parser.parse(lines);
  print(robots.value);
}

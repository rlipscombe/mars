import 'dart:io';

import 'package:mars/mars.dart';
import 'package:mars/parser.dart';

void main(List<String> arguments) async {
  var inputFile = File(arguments[0]);
  var lines = await inputFile.readAsString();

  var definition = RobotsDefinition();
  var parser = definition.build();

  var results = parser.parse(lines).value;

  Grid grid = results[0];
  List<Robot> robots = results[1];

  for (var robot in robots) {
    robot.run(grid);
    print("${robot.summary}");
  }
}

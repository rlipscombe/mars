import 'package:mars/mars.dart';
import 'package:petitparser/petitparser.dart';

class RobotsDefinition extends GrammarDefinition {
  @override
  Parser start() => ref0(range);

  Parser range() => (ref0(number).trim() & ref0(number).trim())
      .map((values) => Grid(values[0], values[1]));

  Parser initial() =>
      (ref0(number).trim() & ref0(number).trim() & ref0(direction).trim())
          .map((values) => Robot(values[0], values[1], values[2]));

  Parser<Direction> direction() =>
      (char('N') | char('E') | char('S') | char('W')).map((ch) {
        switch (ch) {
          case 'N':
            return Direction.north;
          case 'E':
            return Direction.east;
          case 'S':
            return Direction.south;
          case 'W':
            return Direction.west;
          default:
            throw ArgumentError.value(ch);
        }
      });

  Parser<int> number() =>
      (digit().plus().flatten()).map((value) => int.parse(value));
}

import 'package:mars/mars.dart';
import 'package:petitparser/petitparser.dart';

class RobotsDefinition extends GrammarDefinition {
  @override
  Parser start() => ref0(range).trim() & ref0(robot).trim().star();

  Parser<Grid> range() => (ref0(number).trim() & ref0(number).trim())
      .map((values) => Grid(values[0], values[1]));

  Parser<Robot> initial() =>
      (ref0(number).trim() & ref0(number).trim() & ref0(direction).trim())
          .map((values) => Robot(values[0], values[1], values[2]));

  // TODO: This is clumsy
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

  Parser<Robot> robot() =>
      (ref0(initial).trim() & ref0(instructions).trim()).map((values) {
        Robot robot = values[0];
        List<Instruction> instructions = values[1];
        robot.instructions = instructions;
        return robot;
      });

  Parser<List<Instruction>> instructions() => ref0(instruction).star();
  Parser<Instruction> instruction() =>
      (char('L') | char('R') | char('F')).map((ch) {
        switch (ch) {
          case 'L':
            return Instruction.left;
          case 'R':
            return Instruction.right;
          case 'F':
            return Instruction.forward;
          default:
            throw ArgumentError.value(ch);
        }
      });

  Parser<int> number() =>
      (digit().plus().flatten()).map((value) => int.parse(value));
}

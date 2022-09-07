import 'package:mars/mars.dart';
import 'package:mars/parser.dart';
import 'package:test/test.dart';

void main() {
  group('range', () {
    test('parse range to grid', () {
      var definition = RobotsDefinition();
      var range = definition.build(start: definition.range);

      expect(range.parse("54 78").value, Grid(54, 78));
    });

    test('parse invalid range', () {
      var definition = RobotsDefinition();
      var range = definition.build(start: definition.range);

      assert(range.parse("54").isFailure);
    });
  });

  group('direction', () {
    test('north', () {
      var definition = RobotsDefinition();
      var direction = definition.build(start: definition.direction);

      expect(direction.parse("N").value, Direction.north);
    });

    test('east', () {
      var definition = RobotsDefinition();
      var direction = definition.build(start: definition.direction);

      expect(direction.parse("E").value, Direction.east);
    });

    test('invalid direction', () {
      var definition = RobotsDefinition();
      var direction = definition.build(start: definition.direction);

      var result = direction.parse("U");
      assert(result.isFailure);
      // TODO: expect(result.message, 'One of "N", "E", "S", "W" expected');
    });
  });

  group('initial', () {
    test('robot 1', () {
      var definition = RobotsDefinition();
      var initial = definition.build(start: definition.initial);

      expect(initial.parse("1 1 E").value, Robot(1, 1, Direction.east));
    });

    test('robot 2', () {
      var definition = RobotsDefinition();
      var initial = definition.build(start: definition.initial);

      expect(initial.parse("3 2 N").value, Robot(3, 2, Direction.north));
    });

    test('robot 3', () {
      var definition = RobotsDefinition();
      var initial = definition.build(start: definition.initial);

      expect(initial.parse("0 3 W").value, Robot(0, 3, Direction.west));
    });
  });

  group('instructions', () {
    test('robot 1', () {
      var definition = RobotsDefinition();
      var instructions = definition.build(start: definition.instructions);

      expect(instructions.parse("RFRFRFRF").value, [
        Instruction.right,
        Instruction.forward,
        Instruction.right,
        Instruction.forward,
        Instruction.right,
        Instruction.forward,
        Instruction.right,
        Instruction.forward,
      ]);
    });
  });

  group('robot', () {
    test('robot 1', () {
      var definition = RobotsDefinition();
      var robot = definition.build<Robot>(start: definition.robot);

      String input = "1 1 E\nRFRFRFRF";

      Robot expected = Robot(1, 1, Direction.east);
      expected.instructions = [
        Instruction.right,
        Instruction.forward,
        Instruction.right,
        Instruction.forward,
        Instruction.right,
        Instruction.forward,
        Instruction.right,
        Instruction.forward,
      ];

      expect(robot.parse(input).value, expected);
    });
  });

  group('input', () {
    test('it', () {
      var definition = RobotsDefinition();
      var parser = definition.build();

      String input = """5 3
1 1 E
RFRFRFRF
3 2 N
FRRFLLFFRRFLL
0 3 W
LLFFFLFLFL""";
      expect(parser.parse(input).value, [
        Grid(5, 3),
        [
          Robot(1, 1, Direction.east)
            ..instructions = [
              Instruction.right,
              Instruction.forward,
              Instruction.right,
              Instruction.forward,
              Instruction.right,
              Instruction.forward,
              Instruction.right,
              Instruction.forward,
            ],
          Robot(3, 2, Direction.north)
            ..instructions = [
              Instruction.forward,
              Instruction.right,
              Instruction.right,
              Instruction.forward,
              Instruction.left,
              Instruction.left,
              Instruction.forward,
              Instruction.forward,
              Instruction.right,
              Instruction.right,
              Instruction.forward,
              Instruction.left,
              Instruction.left,
            ],
          Robot(0, 3, Direction.west)
            ..instructions = [
              Instruction.left,
              Instruction.left,
              Instruction.forward,
              Instruction.forward,
              Instruction.forward,
              Instruction.left,
              Instruction.forward,
              Instruction.left,
              Instruction.forward,
              Instruction.left,
            ],
        ]
      ]);
    });
  });
}

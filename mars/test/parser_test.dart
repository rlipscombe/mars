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
    test('1 1 E', () {
      var definition = RobotsDefinition();
      var initial = definition.build(start: definition.initial);

      expect(initial.parse("1 1 E").value, Robot(1, 1, Direction.east));
    });

    test('3 2 N', () {
      var definition = RobotsDefinition();
      var initial = definition.build(start: definition.initial);

      expect(initial.parse("3 2 N").value, Robot(3, 2, Direction.north));
    });

    test('0 3 W', () {
      var definition = RobotsDefinition();
      var initial = definition.build(start: definition.initial);

      expect(initial.parse("0 3 W").value, Robot(0, 3, Direction.west));
    });
  });
}

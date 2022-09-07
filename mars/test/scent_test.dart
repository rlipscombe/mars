import 'package:mars/mars.dart';
import 'package:mars/parser.dart';
import 'package:test/test.dart';

void main() {
  test('lost robot marks grid', () {
    var definition = RobotsDefinition();
    var parser = definition.build<Robot>(start: definition.robot);

    var grid = Grid(5, 3);
    var input = "3 2 N\nFRRFLLFFRRFLL";
    var robot = parser.parse(input).value;

    robot.run(grid);
    assert(grid.isMarked(Position(3, 3)));
  });

  test('robots should not move off the world if scented', () {
    var grid = Grid(1, 1)..mark(Position(1, 1));
    var robot = Robot(1, 1, Direction.north)
      ..instructions = [Instruction.forward];
    robot.run(grid);
    expect(robot.position.x, 1);
    expect(robot.position.y, 1);
    expect(robot.isLost, false);
  });

  test('robots can move forward on scented squares if safe', () {
    var grid = Grid(1, 1)..mark(Position(1, 1));
    var robot = Robot(1, 1, Direction.west)
      ..instructions = [Instruction.forward];
    robot.run(grid);
    expect(robot.position.x, 0);
    expect(robot.position.y, 1);
    expect(robot.isLost, false);
  });
}

import 'package:mars/mars.dart';
import 'package:mars/parser.dart';
import 'package:test/test.dart';

void main() {
  test('robot 1', () {
    var definition = RobotsDefinition();
    var parser = definition.build(start: definition.robot);

    Grid grid = Grid(5, 3);
    var robot = parser.parse("""1 1 E
RFRFRFRF""").value;

    robot.run(grid);
    expect("${robot.summary}", "1 1 E");
  });

  test('robot 2', () {
    var definition = RobotsDefinition();
    var parser = definition.build(start: definition.robot);

    Grid grid = Grid(5, 3);
    var robot = parser.parse("""3 2 N
FRRFLLFFRRFLL""").value;

    robot.run(grid);
    expect("${robot.summary}", "3 3 N LOST");
  });

  test('robot 3', () {
    var definition = RobotsDefinition();
    var parser = definition.build(start: definition.robot);

    Grid grid = Grid(5, 3);
    grid.mark(Position(3, 3));

    var robot = parser.parse("""0 3 W
LLFFFLFLFL""").value;

    robot.run(grid);
    expect("${robot.summary}", "2 3 S");
  });

  test('robot 3a', () {
    var definition = RobotsDefinition();
    var parser = definition.build(start: definition.robot);

    Grid grid = Grid(5, 3);
    grid.mark(Position(3, 3));

    var robot = parser.parse("""0 3 W
LLFFF""").value;

    robot.run(grid);
    expect("${robot.summary}", "3 3 E");
  });

  test('robot 3b', () {
    var definition = RobotsDefinition();
    var parser = definition.build(start: definition.robot);

    Grid grid = Grid(5, 3);
    grid.mark(Position(3, 3));

    var robot = parser.parse("""0 3 W
LLFFFLF""").value;

    robot.run(grid);
    expect("${robot.summary}", "3 3 N");
  });

  test('robot 3b1', () {
    var definition = RobotsDefinition();
    var parser = definition.build(start: definition.robot);

    Grid grid = Grid(5, 3);
    grid.mark(Position(3, 3));

    var robot = parser.parse("""3 3 E
LF""").value;

    robot.run(grid);
    expect("${robot.summary}", "3 3 N");
  });
}

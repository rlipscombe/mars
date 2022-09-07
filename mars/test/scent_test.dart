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
}

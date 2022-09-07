class Grid {
  final int maxX;
  final int maxY;

  Grid(this.maxX, this.maxY);

  @override
  String toString() {
    return "Grid: $maxX, $maxY";
  }

  @override
  bool operator ==(Object other) {
    if (other is! Grid) return false;
    return maxX == other.maxX && maxY == other.maxY;
  }

  @override
  int get hashCode => (37 * maxX) + maxY;
}

enum Direction {
  north,
  east,
  south,
  west,
}

class Position {
  int x;
  int y;

  Position(this.x, this.y);

  @override
  String toString() {
    return "Position: $x, $y";
  }

  @override
  bool operator ==(Object other) {
    if (other is! Position) return false;
    return x == other.x && y == other.y;
  }

  @override
  int get hashCode => (37 * x) + y;
}

class Robot {
  Position position;
  Direction direction;
  List<Instruction> instructions = [];

  Robot(int x, int y, this.direction) : position = Position(x, y);

  get summary => "${position.x} ${position.y} ${_direction(direction)}";

  @override
  String toString() {
    return "Robot: $position, $direction, $instructions";
  }

  @override
  bool operator ==(Object other) {
    if (other is! Robot) return false;
    return position == other.position &&
        direction == other.direction &&
        instructions.equals(other.instructions);
  }

  @override
  int get hashCode {
    var result = 17;
    result = 37 * result + position.hashCode;
    result = 37 * result + direction.hashCode;
    result = 37 * result + instructions.hashCode;
    return result;
  }
}

enum Instruction {
  left,
  right,
  forward,
}

extension ListExt<T> on List<T> {
  bool equals(List<T> other) {
    if (length != other.length) {
      return false;
    }

    for (int i = 0; i < length; ++i) {
      if (this[i] != other[i]) {
        return false;
      }
    }

    return true;
  }
}

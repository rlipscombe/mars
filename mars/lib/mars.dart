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

class Robot {
  int x;
  int y;
  Direction direction;
  List<Instruction> instructions = [];

  Robot(this.x, this.y, this.direction);

  @override
  String toString() {
    return "Robot: $x, $y, $direction, $instructions";
  }

  @override
  bool operator ==(Object other) {
    if (other is! Robot) return false;
    return x == other.x &&
        y == other.y &&
        direction == other.direction &&
        instructions.equals(other.instructions);
  }

  @override
  int get hashCode {
    var result = 17;
    result = 37 * result + x;
    result = 37 * result + y;
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

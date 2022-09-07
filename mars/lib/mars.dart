class Grid {
  final int maxX;
  final int maxY;

  Grid(this.maxX, this.maxY);

  @override
  String toString() {
    return "$maxX, $maxY";
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

  Robot(this.x, this.y, this.direction);

  @override
  String toString() {
    return "$x, $y, $direction";
  }

  @override
  bool operator ==(Object other) {
    if (other is! Robot) return false;
    return x == other.x && y == other.y && direction == other.direction;
  }

  @override
  int get hashCode {
    var result = 17;
    result = 37 * result + x;
    result = 37 * result + y;
    result = 37 * result + direction.hashCode;
    return result;
  }
}

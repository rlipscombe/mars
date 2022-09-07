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

  bool contains(Position position) {
    return position.x <= maxX && position.y <= maxY;
  }
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
  bool isLost = false;

  Robot(int x, int y, this.direction) : position = Position(x, y);

  get summary =>
      "${position.x} ${position.y} ${_formatDirection(direction)} ${_formatLost(isLost)}";

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

  void run(Grid grid) {
    for (var instruction in instructions) {
      switch (instruction) {
        case Instruction.left:
          direction = turnLeft(direction);
          break;
        case Instruction.right:
          direction = turnRight(direction);
          break;
        case Instruction.forward:
          var nextPosition = moveForward(direction, position);
          if (grid.contains(nextPosition)) {
            position = nextPosition;
          } else {
            isLost = true;
            return;
          }

          break;
      }
    }
  }

  Direction turnLeft(Direction d) {
    return {
      Direction.north: Direction.east,
      Direction.east: Direction.south,
      Direction.south: Direction.west,
      Direction.west: Direction.north,
    }[d]!;
  }

  Direction turnRight(Direction d) {
    return {
      Direction.north: Direction.west,
      Direction.east: Direction.north,
      Direction.south: Direction.east,
      Direction.west: Direction.south,
    }[d]!;
  }

  Position moveForward(Direction d, Position position) {
    switch (d) {
      case Direction.north:
        return Position(position.x, position.y + 1);
      case Direction.east:
        return Position(position.x + 1, position.y);
      case Direction.south:
        return Position(position.x, position.y - 1);
      case Direction.west:
        return Position(position.x - 1, position.y);
    }
  }
}

String _formatDirection(Direction d) {
  return {
    Direction.north: "N",
    Direction.east: "E",
    Direction.south: "S",
    Direction.west: "W"
  }[d]!;
}

String _formatLost(bool isLost) {
  return isLost ? "LOST" : "";
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

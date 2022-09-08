use chumsky::prelude::*;
use std::fs;

mod model;
mod parser;

use model::*;
use parser::*;

impl std::fmt::Display for Direction {
    fn fmt(&self, f: &mut std::fmt::Formatter) -> std::fmt::Result {
        write!(
            f,
            "{}",
            match self {
                Direction::North => "N",
                Direction::East => "E",
                Direction::South => "S",
                Direction::West => "W",
            }
        )
    }
}

impl std::fmt::Display for Robot {
    fn fmt(&self, f: &mut std::fmt::Formatter) -> std::fmt::Result {
        write!(
            f,
            "{} {} {}{}",
            self.x,
            self.y,
            self.direction,
            if self.is_lost { " LOST" } else { "" }
        )
    }
}

impl Problem {
    fn run(&mut self) {
        for robot in &mut self.robots {
            robot.run(&mut self.grid);
            println!("{}", robot);
        }
    }
}

fn turn_left(d: Direction) -> Direction {
    match d {
        Direction::North => Direction::West,
        Direction::East => Direction::North,
        Direction::South => Direction::East,
        Direction::West => Direction::South,
    }
}

fn turn_right(d: Direction) -> Direction {
    match d {
        Direction::North => Direction::East,
        Direction::East => Direction::South,
        Direction::South => Direction::West,
        Direction::West => Direction::North,
    }
}

impl Robot {
    fn run(&mut self, grid: &mut Grid) {
        for instruction in &self.instructions {
            match (instruction, self.x, self.y, self.direction) {
                (Instruction::Left, _, _, _) => {
                    self.direction = turn_left(self.direction);
                }
                (Instruction::Right, _, _, _) => {
                    self.direction = turn_right(self.direction);
                }
                (Instruction::Forward, _, y, Direction::North) if y < grid.y => {
                    self.y = self.y + 1;
                }
                (Instruction::Forward, x, _, Direction::East) if x < grid.x => {
                    self.x = self.x + 1;
                }
                (Instruction::Forward, _, _, Direction::South) => {
                    self.y = self.y - 1;
                }
                (Instruction::Forward, _, _, Direction::West) => {
                    self.x = self.x - 1;
                }
                _ => {
                    if !grid.is_marked(self.x, self.y) {
                        self.is_lost = true;
                        grid.mark(self.x, self.y);
                        return;
                    }
                }
            }
        }
    }
}

fn main() {
    let input = fs::read_to_string("input.txt").expect("read input file");
    let parser = parser();
    let mut problem = parser.parse(input).unwrap();
    problem.run();
}

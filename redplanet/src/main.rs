use chumsky::prelude::*;
use std::fs;

mod model;
mod parser;

use model::*;
use parser::*;

impl std::fmt::Display for Direction {
    fn fmt(&self, f: &mut std::fmt::Formatter) -> std::fmt::Result {
        write!(f, "{}", match self {
            Direction::North => "N",
            Direction::East => "E",
            Direction::South => "S",
            Direction::West => "W",
        })
    }
}

impl std::fmt::Display for Robot {
    fn fmt(&self, f: &mut std::fmt::Formatter) -> std::fmt::Result {
        write!(f, "{} {} {}", self.x, self.y, self.direction)
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
            match instruction {
                Instruction::Left => {
                    self.direction = turn_left(self.direction);
                }
                Instruction::Right => {
                    self.direction = turn_right(self.direction);
                }
                _ => {}
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

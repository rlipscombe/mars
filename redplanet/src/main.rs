use chumsky::prelude::*;
use std::fs;

mod model;
use crate::model::*;

fn parser() -> impl Parser<char, Problem, Error = Simple<char>> {
    let num = text::int(10).map(|s: String| s.parse().unwrap()).padded();

    let grid = num.then(num).map(|(x, y)| Grid { x, y });
    let direction = choice((
        just("N").to(Direction::North),
        just("E").to(Direction::East),
        just("S").to(Direction::South),
        just("W").to(Direction::West),
    )).padded();
    let instruction = choice((
        just("L").to(Instruction::Left),
        just("R").to(Instruction::Right),
        just("F").to(Instruction::Forward),
    ));
    let robot = num
        .then(num)
        .then(direction)
        .then(instruction.repeated().padded())
        .map(|(((x, y), d), instructions)| Robot { x, y, direction: d, instructions });
    let robots = robot.repeated();
    grid.then(robots)
        .map(|(grid, robots)| Problem { grid, robots })
}

fn main() {
    let input = fs::read_to_string("input.txt").expect("read input file");
    let parser = parser();
    let problem = parser.parse(input).unwrap();
    println!("{:?}", problem);
}

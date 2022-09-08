use chumsky::prelude::*;
use std::fs;

mod model;
use crate::model::*;

fn parser() -> impl Parser<char, Grid, Error = Simple<char>> {
    let num = text::int(10).map(|s: String| s.parse().unwrap()).padded();

    let grid = num.then(num).map(|(x, y)| Grid { x, y });
    grid
}

fn main() {
    let input = fs::read_to_string("input.txt").expect("read input file");
    let parser = parser();
    let problem = parser.parse(input).unwrap();
    println!("{:?}", problem);
}

use chumsky::prelude::*;
use std::fs;

mod model;

fn parser() -> impl Parser<char, i32, Error = Simple<char>> {
    let num = text::int(10).map(|s: String| s.parse().unwrap());
    num
}

fn main() {
    let input = fs::read_to_string("input.txt").expect("read input file");
    let parser = parser();
    let problem = parser.parse(input).unwrap();
    println!("{:?}", problem);
}

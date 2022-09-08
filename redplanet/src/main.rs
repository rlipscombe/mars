use std::fs;
use chumsky::prelude::*;

mod parser;
mod model;

use parser::*;

fn main() {
    let input = fs::read_to_string("input.txt").expect("read input file");
    let parser = parser();
    let problem = parser.parse(input).unwrap();
    println!("{:?}", problem);
}

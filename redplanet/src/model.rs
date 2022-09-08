use std::collections::HashSet;

#[derive(Debug, Clone, Copy)]
pub enum Direction {
    North,
    East,
    South,
    West,
}

#[derive(Debug, Clone, Copy)]
pub enum Instruction {
    Left,
    Right,
    Forward,
}

#[derive(Debug)]
pub struct Grid {
    pub x: i32,
    pub y: i32,
    pub scents: HashSet<(i32, i32)>,
}

impl Grid {
    pub fn mark(&mut self, x: i32, y: i32) {
        self.scents.insert((x, y));
    }

    pub fn is_marked(&self, x: i32, y: i32) -> bool {
        self.scents.contains(&(x, y))
    }
}

#[derive(Debug)]
pub struct Robot {
    pub x: i32,
    pub y: i32,
    pub direction: Direction,
    pub is_lost: bool,
    pub instructions: Vec<Instruction>,
}

#[derive(Debug)]
pub struct Problem {
    pub grid: Grid,
    pub robots: Vec<Robot>,
}

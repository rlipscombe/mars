#[derive(Debug, Clone)]
pub enum Direction {
    North,
    East,
    South,
    West,
}

#[derive(Debug, Clone)]
pub enum Instruction {
    Left,
    Right,
    Forward,
}

#[derive(Debug)]
pub struct Grid {
    pub x: i32,
    pub y: i32,
}

#[derive(Debug)]
pub struct Robot {
    pub x: i32,
    pub y: i32,
    pub direction: Direction,
    pub instructions: Vec<Instruction>,
}

#[derive(Debug)]
pub struct Problem {
    pub grid: Grid,
    pub robots: Vec<Robot>,
}

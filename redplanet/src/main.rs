use std::error::Error;
use std::fs;

fn main() -> Result<(), Box<dyn Error>>{
    let input = fs::read_to_string("input.txt")?;
    for line in input.lines() {
        println!("{}", line);
    }
    Ok(())
}

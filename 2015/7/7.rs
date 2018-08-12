use std::fs::File;
use std::io::prelude::*;
use std::collections::HashMap;

#[derive(Debug)]
enum Rule {
    Value(u16),
    Alias(String),
    Operation {
        op: String,
        args: Vec<Rule>,
    },
}

impl Rule {
    fn parse(input: &str) -> Rule {
        let tokens: Vec<_> = input.trim().split(' ').collect();
        match tokens.len() {
            1 => Rule::from_string(tokens[0]),
            2 => {
                Rule::Operation {
                    op: tokens[0].to_string(),
                    args: vec![Rule::from_string(tokens[1])],
                }
            },
            3 => {
                Rule::Operation {
                    op: tokens[1].to_string(),
                    args: vec![
                        Rule::from_string(tokens[0]),
                        Rule::from_string(tokens[2])
                    ],
                }
            },
            _ => panic!(),
        }
    }

    fn from_string(string: &str) -> Rule {
        match string.parse::<u16>() {
            Ok(x) => Rule::Value(x),
            Err(_) => Rule::Alias(string.to_string())
        }
    }
}

struct Circuit<F>
    where F: Fn(Vec<u16>) -> u16
{
    wires: HashMap<String, Rule>,
    operators: HashMap<String, F>,
}

impl<F> Circuit<F>
    where F: Fn(Vec<u16>) -> u16
{
    fn new() -> Circuit<F> {
        let crt = Circuit { wires: HashMap::new(), operators: HashMap::new() };
        crt.add_operator("NOT", |args| !args[0]);
        crt
    }

    fn add_operator(&mut self, symbol: &str, op: F) {
        self.operators.insert(symbol.to_string(), op);
    }

    fn add_wire(&mut self, name: String, rule: Rule) {
        self.wires.insert(name, rule);
    }

    fn parse(input: &str) -> Circuit<F> {
        let lines = input.trim().split('\n');
        let mut result = Circuit::new();
        for line in lines {
            let mut split = line.split("->");
            let rule = Rule::parse(split.next().unwrap());
            let name = split.next().unwrap().to_string();
            result.add_wire(name, rule);
        }
        result
    }
}

fn main() {
    let args = std::env::args();
    let filename = args.skip(1).next().expect("Wrong usage");
    println!("Opening {}", filename);
    let mut file = File::open(filename).expect("Couldn't open file");
    let mut contents = String::new();
    file.read_to_string(&mut contents).expect("Couldn't read file");
    let mut crt = Circuit::parse(&contents[..]);
    crt.add_operator(|x| x.len() as u16);
    //for rule in crt.wires.values() {
        //println!("{:?}", rule);
    //}
}

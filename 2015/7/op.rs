use std::collections::HashMap;

struct Operators<F>
    where F: Fn(Vec<u32>) -> u32
{
    ops: HashMap<String, F>,
}

impl<F> Operators<F>
    where F: Fn(Vec<u32>) -> u32
{
    fn new() -> Operators<F> {
        let mut result: Operators<F> = Operators { ops: HashMap::new() };
        result.add_operator("+".to_string(), |args| args[0] + args[1]);
        result
    }

    fn add_operator(&mut self, name: String, function: F) {
       self.ops.insert(name, function);
    }

    fn calculate(&self, name: &String, args: Vec<u32>) -> u32 {
        self.ops.get(name).unwrap()(args)
    }
}

fn main() {
    let mut ops = Operators::new();
    println!("{}", ops.calculate(&"+".to_string(), vec![4, 5]));
}

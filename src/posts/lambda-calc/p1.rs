// ANCHOR: all
// ANCHOR: definition
#[derive(Debug, Clone, Eq, Hash, Ord, PartialOrd, PartialEq)]
enum Term {
    Var(usize),
    App(Box<Term>, Box<Term>),
    Abs(Box<Term>),
}
// ANCHOR_END: definition

// ANCHOR: helpers
fn abs(t: Term) -> Term {
    Term::Abs(Box::new(t))
}

fn app(t: Term, a: Term) -> Term {
    Term::App(Box::new(t), Box::new(a))
}

fn var(i: usize) -> Term {
    Term::Var(i)
}
// ANCHOR_END: helpers

// ANCHOR: demo1
let a_b_gives_a = abs(abs(var(0)));
let a_b_gives_b = abs(abs(var(1)));
println!("A simple term {:?}", a_b_gives_a);
println!("Another simple term {:?}", a_b_gives_b);
// ANCHOR_END: demo1

fn render(term: &Term) -> String {
    format!("{:?}", term)
}

// ANCHOR_END: all

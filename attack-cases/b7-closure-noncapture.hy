// ATTACK: closure body assigns outer binding after task spawn (A5 perimeter)
fn main() {
    counts := map[string]int{}
    f := fn() {
        for i in 0..10000 { counts["k"] = i }   // capture, no boundary stmt inside
    }
    task run_closure(f)
    for i in 0..10000 { counts["k"] = i }   // concurrent write in main
    fmt.println("{counts["k"]}")
}

fn run_closure(f fn()) {
    f()
}
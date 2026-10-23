// ATTACK: slice of pointers moved while pointees live in caller
struct cell { v int }

fn sink(ps []*cell) {
    for i in 0..len(ps) { ps[i].v++ }
}

fn main() {
    a := cell{v: 1}
    ps := []*cell{&a}
    task sink(move ps)
    a.v = 99                     // write through pointee after move
    fmt.println("{a.v}")
}
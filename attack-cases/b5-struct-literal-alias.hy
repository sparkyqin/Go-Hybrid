// ATTACK: struct literal capturing reference field, then move the struct
struct wrapper { inner []int }

fn sink(w wrapper) {
    for i in 0..len(w.inner) { w.inner[i]++ }
}

fn main() {
    data := []int{1,2,3,4}
    w := wrapper{inner: data}   // literal captures live reference
    task sink(move w)           // struct moved; data should freeze via w's move
    data[0] = 99                // write through original binding after move
    fmt.println("{data[0]}")
}
// ATTACK 6: alias through indexing a struct field then moving the struct
struct box { data []int }

fn sink(b box) {
    for i in 0..len(b.data) { b.data[i]++ }
}

fn main() {
    b := box{data: []int{1,2,3,4}}
    slot := b.data        // alias to field storage
    task sink(move b)     // whole struct moved
    slot[0] = 99          // write through field alias after move
    fmt.println("{slot[0]}")
}
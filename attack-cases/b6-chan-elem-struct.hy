// ATTACK: channel of structs carrying mutable fields
struct shared { m map[string]int }

fn recv(c <-chan shared) {
    s := <-c
    for i in 0..10000 { s.m["k"] = i }
}

fn main() {
    data := map[string]int{"k": 0}
    c := make(chan shared, 1)
    task recv(c)
    c <- shared{m: data}       // send struct carrying live map alias
    for i in 0..10000 { data["k"] = i }   // concurrent write through original
    fmt.println("{data["k"]}")
}
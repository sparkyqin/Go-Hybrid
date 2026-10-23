// ATTACK 7: range variable aliasing shared storage
fn sink(s []int) {
    for i in 0..len(s) { s[i]++ }
}

fn main() {
    big := []int{1,2,3,4,5,6,7,8}
    for v in big {          // range binding over the same storage
        task sink(move big)  // moved inside the loop
        break
    }
    fmt.println("ok")
}
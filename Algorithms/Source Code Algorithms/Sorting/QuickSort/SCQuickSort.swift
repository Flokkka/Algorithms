func sort(_ a: inout [Int], l: Int, r: Int) {
    if l < r {
        let p = a[r]
        var i = l - 1
        var j = r
        repeat {
            repeat {
                i += 1
            } while a[i] < p
            repeat {
                j -= 1
            } while j >= l && a[j] > p
            if i < j {
                let tempAI = a[i]
                a[i] = a[j]
                a[j] = tempAI
            }
        } while i < j
        let tempAI = a[i]
        a[i] = a[r]
        a[r] = tempAI
        sort(&a, l: l, r: i-1)
        sort(&a, l: i+1, r: r)
    }
}

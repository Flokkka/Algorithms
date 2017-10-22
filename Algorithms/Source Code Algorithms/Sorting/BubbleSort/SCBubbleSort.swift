func sort(_ a: inout [Int]) {
    var i = 1
    while i < a.count {
        for j in 0..<a.count-i {
            if a[j] > a[j+1] {
                let tempAJ = a[j]
                a[j] = a[j+1]
                a[j+1] = tempAJ
            }
        }
        i += 1
    }
}

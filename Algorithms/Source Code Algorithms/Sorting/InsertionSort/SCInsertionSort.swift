func sort(_ a: inout [Int]) {
    var i = 1
    while i < a.count {
        var j = i
        while j > 0 && a[j-1] > a[j] {
            let tempAJ = a[j]
            a[j] = a[j-1]
            a[j-1] = tempAJ
            j -= 1
        }
        i += 1
    }
}

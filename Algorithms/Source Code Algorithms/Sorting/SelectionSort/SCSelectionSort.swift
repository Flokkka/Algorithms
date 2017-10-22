func sort(_ a: inout [Int]) {
    for j in 0..<a.count {
        var iMin = j
        for i in j+1..<a.count {
            if a[i] < a[iMin] {
                iMin = i
            }
        }
        if (iMin != j) {
            let tempAJ = a[j]
            a[j] = a[iMin]
            a[iMin] = tempAJ
        }
    }
}

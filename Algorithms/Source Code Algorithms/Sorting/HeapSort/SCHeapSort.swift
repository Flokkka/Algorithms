func sort(_ a: inout [Int]) {
    var i: Int = a.count / 2 - 1
    while i >= 0 {
        heapify(a: &a, n: a.count, i: i)
        i -= 1
    }
    i = a.count - 1
    while i >= 0 {
        let tempA0 = a[0]
        a[0] = a[i]
        a[i] = tempA0
        heapify(a: &a, n: i, i: 0)
        i -= 1
    }
}

func heapify(a: inout [Int], n: Int, i: Int) {
    var largest = i
    let l = 2 * i + 1
    let r = 2 * i + 2
    if l < n && a[l] > a[largest] {
        largest = l
    }
    if r < n && a[r] > a[largest] {
        largest = r
    }
    if largest != i {
        let tempAI = a[i]
        a[i] = a[largest]
        a[largest] = tempAI
        heapify(a: &a, n: n, i: largest)
    }
}

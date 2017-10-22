func sort(_ a: inout [Int], l: Int, r: Int) {
    if l >= r {
        return
    }
    let m: Int = (l + r) / 2
    sort(&a, l: l, r: m)
    sort(&a, l: m + 1, r: r)
    var j = l
    var k = m + 1
    var b = [Int](0 ..< r-l+1)
    for i in 0...r - l {
        if j > m {
            b[i] = a[k]
            k += 1
        }
        else if k > r {
            b[i] = a[j]
            j += 1
        }
        else {
            if a[j] <= a[k] {
                b[i] = a[j]
                j += 1
            }
            else {
                b[i] = a[k]
                k += 1
            }
        }
    }
    for i in 0...r - l {
        a[l+i] = b[i]
    }
}

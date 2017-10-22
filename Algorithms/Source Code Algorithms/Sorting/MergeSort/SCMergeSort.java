void sort(int[] a, int l, int r) {
    if (l >= r)
        return;
    int m = (l + r) / 2;
    sort(a, l,  m);
    sort(a, m + 1, r);
    int j = l;
    int k = m + 1;
    int[] b =  new int[r-l+1];
    for (int i = 0; i <= r-l; i++) {
        if (j > m)
            b[i] = a[k++];
        else if (k > r)
            b[i] = a[j++];
        else {
            if (a[j] <= a[k])
                b[i] = a[j++];
            else
                b[i] = a[k++];
        }
    }
    for (int i = 0; i <= r-l; i++)
        a[l+i] = b[i];
}

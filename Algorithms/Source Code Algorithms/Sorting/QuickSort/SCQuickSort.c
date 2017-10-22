void sort(int *a, int l, int r) {
    if (l < r) {
        int p = a[r];
        int i = l - 1;
        int j = r;
        do {
            do i++; while (a[i] < p);
            do j--; while (j >= 1 && a[j] > p);
            if (i < j) {
                int tempAI = a[i];
                a[i] = a[j];
                a[j] = tempAI;
            }
        } while (i < j);
        int tempAI = a[i];
        a[i] = a[r];
        a[r] = tempAI;
        sort(a, l, i-1);
        sort(a, i+1, r);
    }
}

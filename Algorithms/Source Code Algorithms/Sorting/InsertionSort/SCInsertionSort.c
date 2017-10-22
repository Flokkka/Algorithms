void sort(int *a, int n) {
    for (int i = 1; i < n; i++) {
        for (int j = i; j > 0 && a[j-1] > a[j]; j--) {
            int tempAJ = a[j];
            a[j] = a[j-1];
            a[j-1] = tempAJ;
        }
    }
}

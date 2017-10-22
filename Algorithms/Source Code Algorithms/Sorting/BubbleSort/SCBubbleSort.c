void sort(int *a, int n) {
    for (int i = 1; i < n; i++) {
        for (int j = 0; j < n - i; j++) {
            if (a[j] > a[j+1]) {
                int tempAJ = a[j];
                a[j] = a[j+1];
                a[j+1] = tempAJ;
            }
        }
    }
}

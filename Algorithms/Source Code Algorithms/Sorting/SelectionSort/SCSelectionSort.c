void sort(int *a, int n) {
    for (int j = 0; j < n; j++) {
        int iMin = j;
        for (int i = j + 1; i < n; i++) {
            if (a[i] < a[iMin])
                iMin = i;
        }
        if (iMin != j) {
            int tempAJ = a[j];
            a[j] = a[iMin];
            a[iMin] = tempAJ;
        }
    }
}

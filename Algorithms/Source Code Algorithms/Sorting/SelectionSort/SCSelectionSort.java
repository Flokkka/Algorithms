void sort(int[] a) {
    for (int j = 0; j < a.length; j++) {
        int iMin = j;
        for (int i = j + 1; i < a.length; i++) {
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

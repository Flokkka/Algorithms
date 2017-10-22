void sort(int[] a) {
    for (int i = 1; i < a.length; i++) {
        for (int j = 0; j < a.length - 1; j++) {
            if (a[j] > a[j+1]) {
                int tempAJ = a[j];
                a[j] = a[j+1];
                a[j+1] = tempAJ;
            }
        }
    }
}

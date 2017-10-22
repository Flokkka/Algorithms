void sort(int *a, int n) {
    for (int i = n / 2 - 1; i >= 0; i--)
        heapify(a, n, i);
    for (int i = n - 1; i >= 0; i--) {
        int tempA0 = a[0];
        a[0] = a[i];
        a[i] = tempA0;
        heapify(a, i, 0);
    }
}

void heapify(int *a, int n, int i) {
    int largest = i;
    int l = 2 * i + 1;
    int r = 2 * i + 2;
    if (l < n && a[l] > a[largest])
        largest = l;
    if (r < n && a[r] > a[largest])
        largest = r;
    if (largest != i) {
        int tempAI = a[i];
        a[i] = a[largest];
        a[largest] = tempAI;
        heapify(a, n, largest);
    }
}

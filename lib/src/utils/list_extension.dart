extension ListX<T> on List<T> {
  List<T> separatedBy(T item) {
    var newList = this;
    for (int i = length - 1; i > 0; i--) {
      newList.insert(i, item);
    }
    return newList;
  }
}

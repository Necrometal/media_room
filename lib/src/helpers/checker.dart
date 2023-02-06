dynamic getNextItem(List<dynamic> array, dynamic item) {
  if(array.isEmpty) return null;
  if(item == null && array.length == 1) return array[0];
  if(item == null) return array[0];
  if(array.last == item) return array[0];
  return array[array.indexOf(item) + 1];
}

dynamic getPreviousItem(List<dynamic> array, dynamic item) {
  if(array.isEmpty) return null;
  if(item == null && array.length == 1) return array[0];
  if(item == null) return array.last;
  if(array[0] == item) return array.last;
  return array[array.indexOf(item) - 1];
}

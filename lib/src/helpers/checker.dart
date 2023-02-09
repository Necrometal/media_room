import 'dart:math';

Random random = Random();

dynamic getNextItem(
  List<dynamic> array, 
  dynamic item,
  bool isRandom
) {
  int i = 0;
  if(array.isEmpty) return null;
  if(
    (item == null && isRandom == false)
    || (array.last == item && isRandom == false)
  ){
    i = 0;
  }else if(
    isRandom == true
  ){
    i = random.nextInt(array.length);
  }else{
    i = array.indexOf(item) + 1;
  }

  return array[i];
}

dynamic getPreviousItem(
  List<dynamic> array, 
  dynamic item, 
  bool isRandom
){
  // if(array.isEmpty) return null;
  // if(item == null && array.length == 1) return array[0];
  // if(item == null) return array.last;
  // if(array[0] == item) return array.last;
  // return array[array.indexOf(item) - 1];

  int i = 0;
  if(array.isEmpty) return null;
  if(
    (item == null && isRandom == false)
    || (item == null && array.length == 1)
  ){
    i = array.length - 1;
  }else if(isRandom == true){
    i = random.nextInt(array.length);
  }else{
    i = array.indexOf(item) - 1;
  }

  return array[i];
}

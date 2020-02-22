String dateMask(String date){
  final splitedDate = date.split('-');
  return "${splitedDate[2]}/${splitedDate[1]}/${splitedDate[0]}";
}
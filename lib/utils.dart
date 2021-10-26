String setParseImage(String url) {
  const end = "?";
  final startIndex = 0;
  final endIndex = url.indexOf(end, startIndex);
  return (url.substring(startIndex, endIndex));
}

String setTime(double timestamp) {
  var date = DateTime.fromMillisecondsSinceEpoch(timestamp.toInt() * 1000);
  var dateNow = DateTime.now();
  String str = "";
  if (dateNow.year - date.year > 0) {
    str += "${dateNow.year - date.year}y ";
  } else {
    var months = (dateNow.year - date.year) * 12 + (dateNow.month - date.month);
    str += "${months}m ";
  }
  str += "• ${date.day}/${date.month}/${date.year}";
  return str;
}
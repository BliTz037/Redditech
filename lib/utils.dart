String setParseImage(String url) {
  const end = "?";
  final startIndex = 0;
  final endIndex = url.indexOf(end, startIndex);
  return (url.substring(startIndex, endIndex));
}

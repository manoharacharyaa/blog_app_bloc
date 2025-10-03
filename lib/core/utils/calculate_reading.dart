int calculateReadingTime(String content) {
  final wordCount = content.split(RegExp(r'\s+')).length;
  print('-----WORD COUNT: $wordCount');

  final readingTime = wordCount / 225;

  return readingTime.ceil();
}

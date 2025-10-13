import 'package:flutter/material.dart';

int calculateReadingTime(String content) {
  final wordCount = content.split(RegExp(r'\s+')).length;
  debugPrint('-----WORD COUNT: $wordCount');

  final readingTime = wordCount / 225;

  return readingTime.ceil();
}

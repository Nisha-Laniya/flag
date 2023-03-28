import 'package:flutter/cupertino.dart';
import 'dart:math';

List<String> countryList = [
  'Estonia',
  'France',
  'Germany',
  'Ireland',
  'Italy',
  'Monaco',
  'Nigeria',
  'Poland',
  'Russia',
  'Spain',
  'UK',
  'US'
];

class CountryProvider with ChangeNotifier {

  var element = 'Germany';
  var correctAnswer = 1;
  var score = 0;

  void changeQuestion() {
    //TO get three flag including correct flag with different Index
    Random random = Random();
    int min = 0, max = 3;
    correctAnswer = (min + random.nextInt(max - min));
    print(correctAnswer);

    //for three item shuffled list
    countryList.shuffle();
    // Iterable<String> shuffledList = countryList.take(3);
    print(countryList.take(3));

    //for question item
    element = countryList.elementAt(0);
    notifyListeners();
  }
}
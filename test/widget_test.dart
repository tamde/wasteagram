import 'package:flutter_test/flutter_test.dart';
import 'package:wasteagram/models/post_entry.dart';
import 'package:wasteagram/models/get_date.dart';


void main() {
  test('post entry should hold the correct data types', () {
    var entry = PostEntry();

    entry.imageURL = 'www.hello.com';
    entry.quantity = 3;
    entry.latitude = 394141.0;
    entry.longitude = 912834.2;

    expect(entry.imageURL is String, true);
    expect(entry.quantity is int, true);
    expect(entry.latitude is double, true);
    expect(entry.longitude is double, true);
  });

  test('should return a date as a string', () {
    var dateTime = GetDate();
    
    expect(dateTime.getDate() is String, true);
  });
}
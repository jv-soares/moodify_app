import 'package:flutter_test/flutter_test.dart';

void main() {
  test('should generate mirrored integer list', () {
    var list = _generate(['1', '2', '3', '4', '5', '6', '7']);
    expect(list, [-3, -2, -1, 0, 1, 2, 3]);
    list = _generate(['1', '2', '3', '4', '5']);
    expect(list, [-2, -1, 0, 1, 2]);
  });
}

List<int> _generate(List<String> values) {
  return List.generate(
    values.length,
    (index) => index - (values.length - 1) ~/ 2,
  );
}

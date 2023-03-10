import 'package:flutter_test/flutter_test.dart';
import 'package:moodify_app/src/utils/mirrored_integers_generator.dart';

void main() {
  test('should generate mirrored integer list', () {
    var list = MirroredIntegersGenerator.generate(length: 7);
    expect(list, [-3, -2, -1, 0, 1, 2, 3]);
    list = MirroredIntegersGenerator.generate(length: 5);
    expect(list, [-2, -1, 0, 1, 2]);
  });
}

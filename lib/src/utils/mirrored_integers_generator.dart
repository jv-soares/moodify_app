abstract class MirroredIntegersGenerator {
  static List<int> generate({required int length}) {
    return List.generate(
      length,
      (index) => index - (length - 1) ~/ 2,
    );
  }
}

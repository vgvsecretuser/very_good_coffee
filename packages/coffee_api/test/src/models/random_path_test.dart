import 'package:coffee_api/coffee_api.dart';
import 'package:test/test.dart';

void main() {
  group('Random Json Coffee', () {
    group('fromJson', () {
      test('returns correct RandonPath object', () {
        expect(
          RandomPath.fromJson(
            <String, dynamic>{
              'file': 'https://coffee.alexflipnote.dev/7eAokF8_ro4_coffee.jpg',
            },
          ),
          isA<RandomPath>()
              .having((random) => random.file, 'file', 'https://coffee.alexflipnote.dev/7eAokF8_ro4_coffee.jpg'),
        );
      });
    });
  });
}

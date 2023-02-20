// ignore_for_file: prefer_const_constructors
import 'package:coffee_api/coffee_api.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

class MockHttpClient extends Mock implements http.Client {}

class MockResponse extends Mock implements http.Response {}

class FakeUri extends Fake implements Uri {}

void main() {
  group('CoffeeApi', () {
    late http.Client httpClient;
    late CoffeeApiClient apiClient;

    setUpAll(() {
      registerFallbackValue(FakeUri());
    });

    setUp(() {
      httpClient = MockHttpClient();
      apiClient = CoffeeApiClient(httpClient: httpClient);
    });

    group('constructor', () {
      test('can be instantiated without an httpClient', () {
        expect(CoffeeApiClient(), isNotNull);
      });
    });

    group('locationSearch', () {
      test('makes correct http request', () async {
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(200);
        when(() => response.body).thenReturn('{}');
        when(() => httpClient.get(any())).thenAnswer((_) async => response);
        try {
          await apiClient.randomCoffeeUrl();
        } catch (_) {}
        verify(
          () => httpClient.get(
            Uri.https(
              'coffee.alexflipnote.dev',
              '/random.json',
            ),
          ),
        ).called(1);
      });

      test('throws RandomCoffeeJsonRequestFailure on non-200 response',
          () async {
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(400);
        when(() => httpClient.get(any())).thenAnswer((_) async => response);
        expect(
          () async => apiClient.randomCoffeeUrl(),
          throwsA(isA<RandomCoffeeJsonRequestFailure>()),
        );
      });

      test('throws UnexpectedResponse on invalid response', () async {
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(200);
        when(() => httpClient.get(any())).thenAnswer((_) async => response);
        expect(
          () async => apiClient.randomCoffeeUrl(),
          throwsA(isA<UnexpectedResponse>()),
        );
      });

      test('returns Coffee URI on valid response', () async {
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(200);
        when(() => response.body).thenReturn(
          '''
{
  "file": "https://coffee.alexflipnote.dev/7eAokF8_ro4_coffee.jpg"
}
        ''',
        );
        when(() => httpClient.get(any())).thenAnswer((_) async => response);
        final actual = await apiClient.randomCoffeeUrl();
        expect(
          actual,
          isA<String>().having(
            (url) => url,
            'url',
            'https://coffee.alexflipnote.dev/7eAokF8_ro4_coffee.jpg',
          ),
        );
      });
    });
  });
}

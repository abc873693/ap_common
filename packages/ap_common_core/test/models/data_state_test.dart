import 'package:ap_common_core/src/models/data_state.dart';
import 'package:test/test.dart';

void main() {
  group('DataState', () {
    group('DataLoading', () {
      test('should have correct state flags', () {
        const DataState<String> state = DataLoading<String>();
        expect(state.isLoading, isTrue);
        expect(state.isLoaded, isFalse);
        expect(state.isError, isFalse);
        expect(state.isEmpty, isFalse);
      });

      test('dataOrNull should return null', () {
        const DataState<String> state = DataLoading<String>();
        expect(state.dataOrNull, isNull);
      });
    });

    group('DataLoaded', () {
      test('should have correct state flags', () {
        const DataState<String> state = DataLoaded<String>('hello');
        expect(state.isLoading, isFalse);
        expect(state.isLoaded, isTrue);
        expect(state.isError, isFalse);
        expect(state.isEmpty, isFalse);
      });

      test('dataOrNull should return data', () {
        const DataState<String> state = DataLoaded<String>('hello');
        expect(state.dataOrNull, 'hello');
      });

      test('should store hint', () {
        const DataLoaded<String> state =
            DataLoaded<String>('data', hint: 'offline');
        expect(state.data, 'data');
        expect(state.hint, 'offline');
      });

      test('should allow null hint', () {
        const DataLoaded<String> state = DataLoaded<String>('data');
        expect(state.hint, isNull);
      });
    });

    group('DataError', () {
      test('should have correct state flags', () {
        const DataState<String> state = DataError<String>();
        expect(state.isLoading, isFalse);
        expect(state.isLoaded, isFalse);
        expect(state.isError, isTrue);
        expect(state.isEmpty, isFalse);
      });

      test('dataOrNull should return null', () {
        const DataState<String> state = DataError<String>();
        expect(state.dataOrNull, isNull);
      });

      test('should store hint', () {
        const DataError<String> state =
            DataError<String>(hint: 'Network error');
        expect(state.hint, 'Network error');
      });
    });

    group('DataEmpty', () {
      test('should have correct state flags', () {
        const DataState<String> state = DataEmpty<String>();
        expect(state.isLoading, isFalse);
        expect(state.isLoaded, isFalse);
        expect(state.isError, isFalse);
        expect(state.isEmpty, isTrue);
      });

      test('dataOrNull should return null', () {
        const DataState<String> state = DataEmpty<String>();
        expect(state.dataOrNull, isNull);
      });

      test('should store hint', () {
        const DataEmpty<String> state =
            DataEmpty<String>(hint: 'No data found');
        expect(state.hint, 'No data found');
      });
    });

    group('map', () {
      test('should transform DataLoaded data', () {
        const DataState<int> state = DataLoaded<int>(42);
        final DataState<String> mapped = state.map((int v) => v.toString());
        expect(mapped, isA<DataLoaded<String>>());
        expect((mapped as DataLoaded<String>).data, '42');
      });

      test('should preserve hint on DataLoaded', () {
        const DataState<int> state = DataLoaded<int>(42, hint: 'cached');
        final DataState<String> mapped = state.map((int v) => v.toString());
        expect((mapped as DataLoaded<String>).hint, 'cached');
      });

      test('should pass through DataLoading', () {
        const DataState<int> state = DataLoading<int>();
        final DataState<String> mapped = state.map((int v) => v.toString());
        expect(mapped, isA<DataLoading<String>>());
      });

      test('should pass through DataError with hint', () {
        const DataState<int> state = DataError<int>(hint: 'fail');
        final DataState<String> mapped = state.map((int v) => v.toString());
        expect(mapped, isA<DataError<String>>());
        expect((mapped as DataError<String>).hint, 'fail');
      });

      test('should pass through DataEmpty with hint', () {
        const DataState<int> state = DataEmpty<int>(hint: 'empty');
        final DataState<String> mapped = state.map((int v) => v.toString());
        expect(mapped, isA<DataEmpty<String>>());
        expect((mapped as DataEmpty<String>).hint, 'empty');
      });
    });

    group('when', () {
      test('should call loading callback for DataLoading', () {
        const DataState<String> state = DataLoading<String>();
        final String result = state.when(
          loading: () => 'loading',
          loaded: (String data, String? hint) => 'loaded: $data',
          error: (String? hint) => 'error: $hint',
          empty: (String? hint) => 'empty: $hint',
        );
        expect(result, 'loading');
      });

      test('should call loaded callback for DataLoaded', () {
        const DataState<String> state =
            DataLoaded<String>('hello', hint: 'cached');
        final String result = state.when(
          loading: () => 'loading',
          loaded: (String data, String? hint) => 'loaded: $data ($hint)',
          error: (String? hint) => 'error: $hint',
          empty: (String? hint) => 'empty: $hint',
        );
        expect(result, 'loaded: hello (cached)');
      });

      test('should call error callback for DataError', () {
        const DataState<String> state =
            DataError<String>(hint: 'Network error');
        final String result = state.when(
          loading: () => 'loading',
          loaded: (String data, String? hint) => 'loaded: $data',
          error: (String? hint) => 'error: $hint',
          empty: (String? hint) => 'empty: $hint',
        );
        expect(result, 'error: Network error');
      });

      test('should call empty callback for DataEmpty', () {
        const DataState<String> state = DataEmpty<String>(hint: 'No data');
        final String result = state.when(
          loading: () => 'loading',
          loaded: (String data, String? hint) => 'loaded: $data',
          error: (String? hint) => 'error: $hint',
          empty: (String? hint) => 'empty: $hint',
        );
        expect(result, 'empty: No data');
      });
    });

    group('pattern matching', () {
      test('should work with switch expression', () {
        const DataState<int> state = DataLoaded<int>(42);
        final String result = switch (state) {
          DataLoading<int>() => 'loading',
          DataLoaded<int>(:final int data) => 'loaded: $data',
          DataError<int>() => 'error',
          DataEmpty<int>() => 'empty',
        };
        expect(result, 'loaded: 42');
      });

      test('should be exhaustive', () {
        // This test verifies that all cases are covered at compile time.
        // If a new subclass is added, this will fail to compile.
        const DataState<String> state = DataLoading<String>();
        final bool handled = switch (state) {
          DataLoading<String>() => true,
          DataLoaded<String>() => true,
          DataError<String>() => true,
          DataEmpty<String>() => true,
        };
        expect(handled, isTrue);
      });
    });

    group('type safety', () {
      test('DataLoaded should preserve generic type', () {
        const DataState<List<int>> state =
            DataLoaded<List<int>>(<int>[1, 2, 3]);
        expect(state.dataOrNull, <int>[1, 2, 3]);
        expect(state.dataOrNull, isA<List<int>>());
      });

      test('map should change generic type', () {
        const DataState<int> state = DataLoaded<int>(5);
        final DataState<double> mapped = state.map((int v) => v * 2.0);
        expect(mapped.dataOrNull, 10.0);
        expect(mapped, isA<DataLoaded<double>>());
      });
    });
  });
}

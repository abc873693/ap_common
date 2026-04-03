/// A sealed class representing the state of asynchronous data loading.
///
/// Similar to Riverpod's `AsyncValue<T>`, but includes an [DataEmpty] state
/// for cases where loading succeeded but returned no data.
///
/// Usage:
/// ```dart
/// DataState<CourseData> state = DataLoading();
///
/// // Later, after loading:
/// state = DataLoaded(courseData);
/// // or
/// state = DataError(hint: 'Network error');
/// // or
/// state = DataEmpty(hint: 'No courses found');
///
/// // Pattern matching:
/// switch (state) {
///   case DataLoading():
///     return CircularProgressIndicator();
///   case DataLoaded(:final data):
///     return CourseTable(data: data);
///   case DataError(:final hint):
///     return ErrorWidget(hint);
///   case DataEmpty(:final hint):
///     return EmptyWidget(hint);
/// }
/// ```
sealed class DataState<T> {
  const DataState();

  /// Whether the state is [DataLoading].
  bool get isLoading => this is DataLoading<T>;

  /// Whether the state is [DataLoaded].
  bool get isLoaded => this is DataLoaded<T>;

  /// Whether the state is [DataError].
  bool get isError => this is DataError<T>;

  /// Whether the state is [DataEmpty].
  bool get isEmpty => this is DataEmpty<T>;

  /// Returns the data if this is [DataLoaded], otherwise null.
  T? get dataOrNull => switch (this) {
        DataLoaded<T>(:final T data) => data,
        _ => null,
      };

  /// Maps the data to a new type.
  DataState<R> map<R>(R Function(T data) transform) => switch (this) {
        DataLoaded<T>(:final T data, :final String? hint) =>
          DataLoaded<R>(transform(data), hint: hint),
        DataLoading<T>() => DataLoading<R>(),
        DataError<T>(:final String? hint) => DataError<R>(hint: hint),
        DataEmpty<T>(:final String? hint) => DataEmpty<R>(hint: hint),
      };

  /// Executes the appropriate callback based on the state.
  R when<R>({
    required R Function() loading,
    required R Function(T data, String? hint) loaded,
    required R Function(String? hint) error,
    required R Function(String? hint) empty,
  }) =>
      switch (this) {
        DataLoading<T>() => loading(),
        DataLoaded<T>(:final T data, :final String? hint) => loaded(data, hint),
        DataError<T>(:final String? hint) => error(hint),
        DataEmpty<T>(:final String? hint) => empty(hint),
      };
}

/// Data is currently being loaded.
class DataLoading<T> extends DataState<T> {
  const DataLoading();
}

/// Data was loaded successfully.
class DataLoaded<T> extends DataState<T> {
  const DataLoaded(this.data, {this.hint});

  /// The loaded data.
  final T data;

  /// Optional hint to display (e.g., "Offline data" or "Cached data").
  final String? hint;
}

/// An error occurred while loading data.
class DataError<T> extends DataState<T> {
  const DataError({this.hint});

  /// Optional error hint to display.
  final String? hint;
}

/// Data loaded successfully but was empty.
class DataEmpty<T> extends DataState<T> {
  const DataEmpty({this.hint});

  /// Optional hint to display (e.g., "No courses this semester").
  final String? hint;
}

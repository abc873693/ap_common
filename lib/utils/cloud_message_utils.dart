class CloudMessageUtils {
  static CloudMessageUtils? _instance;

  // ignore: prefer_constructors_over_static_methods
  static CloudMessageUtils get instance {
    return _instance ?? CloudMessageUtils();
  }
}

class CloudMessageUtil {
  static CloudMessageUtil? _instance;

  // ignore: prefer_constructors_over_static_methods
  static CloudMessageUtil get instance {
    return _instance ?? CloudMessageUtil();
  }
}

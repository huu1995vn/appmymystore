class Logger {
  static void write(String text, {bool isError = false}) {
    // ignore: avoid_print
    Future.microtask(() => print('** $text. isError: [$isError]'));
  }
}

class Environment {
  final params = <String, String>{};
  Environment() {
    const args = String.fromEnvironment('args', defaultValue: 'default');

    args.split(',').forEach((element) {
      final keyValues = element.split('=');
      params[keyValues[0]] = keyValues[1];
    });
  }

  String? get apiKey => params['apiKey'];
}

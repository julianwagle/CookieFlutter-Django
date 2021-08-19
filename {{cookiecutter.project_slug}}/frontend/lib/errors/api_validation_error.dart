class ApiValidationError implements Exception {
  ApiValidationError(
    Map<String, dynamic> apiRes,
  ) {
    errors = [];
    Iterable<MapEntry<String, dynamic>> errorEntries = apiRes['errors'].entries;
    errorEntries.forEach((entry) {
      entry.value.forEach((errorStr) {
        errors.add('${entry.key} $errorStr');
      });
    });
  }

  late List<String> errors;
}

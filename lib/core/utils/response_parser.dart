int? parseResponseCode(Map<String, dynamic> response) {
  if (!response.containsKey('code')) return null;

  final codeValue = response['code'];

  // لو already int
  if (codeValue is int) return codeValue;

  // لو String, حاول تحويله
  if (codeValue is String) return int.tryParse(codeValue);

  // أي نوع تاني، رجع null
  return null;
}

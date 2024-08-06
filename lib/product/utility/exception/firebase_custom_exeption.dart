class FirebaseCustomExeption implements Exception {
  final String description;
  FirebaseCustomExeption(this.description);

  @override
  String toString() {
    return "$this $description";
  }
}

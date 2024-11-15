class NameEntry {
  String name;
  String meaning;
  bool isSelected;

  NameEntry({required this.name, required this.meaning, this.isSelected = false,});

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'meaning': meaning,
    };
  }

  factory NameEntry.fromMap(Map<String, dynamic> map) {
    return NameEntry(
      name: map['name'],
      meaning: map['meaning'],
    );
  }
}
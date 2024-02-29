class ChecklistItem {
  String title;
  bool isChecked;

  ChecklistItem({required this.title, this.isChecked = false});

  Map<String, dynamic> toJson() => {
        'title': title,
        'isChecked': isChecked,
      };

  static ChecklistItem fromJson(Map<String, dynamic> json) => ChecklistItem(
        title: json['title'],
        isChecked: json['isChecked'],
      );
}

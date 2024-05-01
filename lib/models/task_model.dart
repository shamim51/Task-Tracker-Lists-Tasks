class Task {
  final String title;
  final String subtitle;

  Task({required this.title, required this.subtitle});

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      title: json['title'],
      subtitle: json['subtitle'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'subtitle': subtitle,
    };
  }
}
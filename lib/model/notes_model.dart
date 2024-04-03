class NotesModel {
  String? title;
  String? notes;
  String? id;
  int? color; 
  NotesModel({
    this.title,
    this.notes,
    this.id,
    this.color,
  });

  factory NotesModel.fromJson(Map<String, dynamic> json) {
    return NotesModel(
      notes: json['notes'],
      title: json['title'],
      id: json['id'],
      color: json['color'], 
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'notes': notes,
      'title': title,
      'id': id,
      'color': color,
    };
  }
}

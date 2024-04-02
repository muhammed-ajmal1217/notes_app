class NotesModel{
  String? title;
  String? notes;
  String? id;
  NotesModel({
    this.title,
    this.notes,
    this.id,
  });
  factory NotesModel.fromJson(Map<String,dynamic>json){
    return NotesModel(
      notes: json['notes'],
      title: json['title'],
      id: json['id'],
    );
  }
  Map<String,dynamic> toJson(){
    return {
      'notes':notes,
      'title':title,
      'id':id,
    };
  }
}
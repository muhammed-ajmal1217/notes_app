import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:notesapp_task/model/notes_model.dart';
import 'package:notesapp_task/service/auth_service.dart';

class FireStoreService {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  AuthService auth = AuthService();
addNotes({String? title, String? note, int? color}) async {
  DocumentReference docRef = firestore
      .collection('users')
      .doc(auth.auth.currentUser!.uid)
      .collection('notes')
      .doc();
  NotesModel notes =
      NotesModel(title: title, notes: note, id: docRef.id, color: color);
  await docRef.set(notes.toJson());
}



  Stream<List<NotesModel>> getNotes() {
    return firestore
        .collection('users')
        .doc(auth.auth.currentUser!.uid)
        .collection('notes')
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => NotesModel.fromJson(doc.data()))
            .toList());
  }

Future<void> deleteNote(String documentId) async {
  try {
    await firestore
        .collection('users')
        .doc(auth.auth.currentUser!.uid)
        .collection('notes')
        .doc(documentId)
        .delete();
    print('Note deleted successfully');
  } catch (error) {
    print('Error deleting note: $error');
  }
}
updateNotes(
    {String? documentId, String? newTitle, String? newNote, int? newColor}) async {
  try {
    await firestore
        .collection('users')
        .doc(auth.auth.currentUser!.uid)
        .collection('notes')
        .doc(documentId!)
        .update({
      'title': newTitle,
      'notes': newNote,
      'color': newColor,
    });
    print('Note updated successfully');
  } catch (error) {
    print('Error updating note: $error');
  }
}



}

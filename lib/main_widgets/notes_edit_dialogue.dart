import 'package:flutter/material.dart';
import 'package:notesapp_task/service/firestore_service.dart';

class NotesEditDialogue extends StatefulWidget {
  String title;
  String notes;
  String id;
  NotesEditDialogue({super.key,required this.title,required this.notes,required this.id});

  @override
  State<NotesEditDialogue> createState() => _NotesEditDialogueState();
}
class _NotesEditDialogueState extends State<NotesEditDialogue> {
  TextEditingController titleController = TextEditingController();
  TextEditingController notesController = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    titleController = TextEditingController(text: widget.title);
    notesController = TextEditingController(text: widget.notes);
  }
  @override
    Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.black,
      title: Text('Add Notes',style: TextStyle(color: Colors.white),),
      actions: [
        TextFormField(
          controller: titleController,
          style: TextStyle(color: Colors.white),
          decoration: InputDecoration(
            hintText: 'Title',
            hintStyle: TextStyle(color: Colors.grey),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            )
          ),
          
        ),
        SizedBox(height: 20,),
        TextFormField(
          maxLines: 5,
          controller: notesController,
          style: TextStyle(color: Colors.white),
          decoration: InputDecoration(
            hintText: 'Notes',
            hintStyle: TextStyle(color: Colors.grey),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            )
          ),
          
        ),
        SizedBox(height: 20,),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            TextButton(onPressed: (){
              updateNotes(widget.id,context);
            }, child: Text('Update')),
            TextButton(onPressed: (){
              Navigator.pop(context);
            }, child: Text('Cancel'))
          ],
        )
    
      ],
    );
  }
  updateNotes(String documentId,BuildContext context){
    final title = titleController.text;
    final notes = notesController.text;
    if(title.isNotEmpty&&notes.isNotEmpty){
      FireStoreService().updateNotes(documentId: documentId,newNote: notes,newTitle: title);
    }else{
       ScaffoldMessenger.maybeOf(context)!.showSnackBar(
        SnackBar(content: Text('Notes or Title is Empty'))
      );
    }
    Navigator.pop(context);
  }
}

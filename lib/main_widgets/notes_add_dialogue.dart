import 'package:flutter/material.dart';
import 'package:notesapp_task/service/firestore_service.dart';

class NotesAddDialogue extends StatelessWidget {
   NotesAddDialogue({
    super.key,
  });
  TextEditingController titleController = TextEditingController();
  TextEditingController notesController = TextEditingController();

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
              addNotes(context);
            }, child: Text('Add')),
            TextButton(onPressed: (){
              Navigator.pop(context);
            }, child: Text('Cancel'))
          ],
        )
    
      ],
    );
  }
  addNotes(BuildContext context){
    final title = titleController.text;
    final notes = notesController.text;
    if(title.isNotEmpty&&notes.isNotEmpty){
      FireStoreService().addNotes(title: title,note: notes);
    }else{
      ScaffoldMessenger.maybeOf(context)!.showSnackBar(
        SnackBar(content: Text('Notes or Title is Empty'))
      );
    }
    Navigator.pop(context);
  }
}
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:notesapp_task/service/firestore_service.dart';

class NotesEditDialogue extends StatefulWidget {
  String title;
  String notes;
  String id;
  int? color;
  NotesEditDialogue({super.key,required this.title,required this.notes,required this.id,this.color});

  @override
  State<NotesEditDialogue> createState() => _NotesEditDialogueState();
}
class _NotesEditDialogueState extends State<NotesEditDialogue> {
  TextEditingController titleController = TextEditingController();
  TextEditingController notesController = TextEditingController();
  Color currentColor = Colors.transparent; 
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    titleController = TextEditingController(text: widget.title);
    notesController = TextEditingController(text: widget.notes);
    currentColor = Color(widget.color??0);
  }
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: AlertDialog(
        backgroundColor: Colors.black,
        title: Text(
          'Edit Notes',
          style: TextStyle(color: Colors.white),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: titleController,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: 'Title',
                hintStyle: TextStyle(color: Colors.grey),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            SizedBox(height: 20),
            TextFormField(
              maxLines: 5,
              controller: notesController,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: 'Notes',
                hintStyle: TextStyle(color: Colors.grey),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            SizedBox(height: 20),
            Row(
              children: [
                TextButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          backgroundColor: Colors.black,
                          title: Text('Pick a color'),
                          content: SingleChildScrollView(
                            child: Container(
                              color: Colors.black,
                              child: ColorPicker(
                                displayThumbColor: true,
                                pickerColor: currentColor,
                                onColorChanged: (Color color) {
                                  setState(() {
                                    currentColor = color;
                                  });
                                },
                                showLabel: true,
                                pickerAreaHeightPercent: 0.8,
                              ),
                            ),
                          ),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text('Got it'),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  child: Text('Open color picker'),
                ),
                SizedBox(width: 10),
                Container(
                  height: 20,
                  width: 20,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: currentColor,
                  ),
                )
              ],
            )
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              updateNotes(widget.id, context);
            },
            child: Text('Update'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('Cancel'),
          )
        ],
      ),
    );
  }
  updateNotes(String documentId,BuildContext context){
    final title = titleController.text;
    final notes = notesController.text;
    if(title.isNotEmpty&&notes.isNotEmpty){
      FireStoreService().updateNotes(
        documentId: documentId,
        newNote: notes,
        newTitle: title,
        newColor: currentColor.value,
      );
    }else{
       ScaffoldMessenger.maybeOf(context)!.showSnackBar(
        SnackBar(content: Text('Notes or Title is Empty'))
      );
    }
    Navigator.pop(context);
  }
}

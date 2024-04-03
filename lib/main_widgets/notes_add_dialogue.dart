import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:notesapp_task/service/firestore_service.dart';

class NotesAddDialogue extends StatefulWidget {
  const NotesAddDialogue({Key? key}) : super(key: key);

  @override
  _NotesAddDialogueState createState() => _NotesAddDialogueState();
}

class _NotesAddDialogueState extends State<NotesAddDialogue> {
  TextEditingController titleController = TextEditingController();
  TextEditingController notesController = TextEditingController();
  Color currentColor = Colors.transparent; 

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: AlertDialog(
        backgroundColor: Colors.black,
        title: Text(
          'Add Notes',
          style: TextStyle(color: Colors.white),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: titleController,
              style: GoogleFonts.raleway(color: Colors.white),
              decoration: InputDecoration(
                hintText: 'Title',
                hintStyle: GoogleFonts.raleway(color: Colors.grey),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            SizedBox(height: 20),
            TextFormField(
              maxLines: 5,
              controller: notesController,
              style: GoogleFonts.raleway(color: Colors.white),
              decoration: InputDecoration(
                hintText: 'Notes',
                hintStyle: GoogleFonts.raleway(color: Colors.grey),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          backgroundColor: Colors.black,
                          title: Text('Pick a color',style: GoogleFonts.raleway(color: Colors.white),),
                          content: SingleChildScrollView(
                              child: Container(
                            color: Color.fromARGB(255, 6, 2, 23),
                            child: ColorPicker(
                              labelTextStyle: GoogleFonts.raleway(color: Colors.white),
                              pickerColor: currentColor,
                              onColorChanged: (Color color) {
                                setState(() {
                                  currentColor = color;
                                });
                              },
                              showLabel: true,
                              pickerAreaHeightPercent: 0.8,
                            ),
                          )),
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
              addNotes(context);
            },
            child: Text('Add'),
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

  addNotes(BuildContext context) {
    final title = titleController.text;
    final notes = notesController.text;
    if (title.isNotEmpty && notes.isNotEmpty) {
      FireStoreService()
          .addNotes(title: title, note: notes, color: currentColor.value);
    } else {
      ScaffoldMessenger.maybeOf(context)!.showSnackBar(
        SnackBar(content: Text('Notes or Title is Empty')),
      );
    }
    Navigator.pop(context);
  }
}

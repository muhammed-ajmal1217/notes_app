import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:notesapp_task/main_widgets/notes_add_dialogue.dart';
import 'package:notesapp_task/main_widgets/notes_edit_dialogue.dart';
import 'package:notesapp_task/model/notes_model.dart';
import 'package:notesapp_task/service/auth_service.dart';
import 'package:notesapp_task/service/firestore_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          'Notes',
          style: GoogleFonts.raleway(color: Colors.white),
        ),
        actions: [
          InkWell(
            onTap: () {
              AuthService().signOut(context);
            },
            child: Icon(
              Icons.logout,
              color: Colors.white,
            ),
          )
        ],
      ),
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder(
              stream: FireStoreService().getNotes(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Text('Snapshot has error');
                } else {
                  final List<NotesModel>? datas =
                      snapshot.data as List<NotesModel>?;

                  if (datas == null || datas.isEmpty) {
                    return Center(
                      child: Icon(
                        Icons.note_add_outlined,
                        size: 100,
                        color: Color.fromARGB(255, 45, 45, 45),
                      ),
                    );
                  }

                  return GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                    ),
                    itemCount: datas.length,
                    itemBuilder: (context, index) {
                      final NotesModel data = datas[index];
                      return Card(
                        color: Color(data.color ?? 0xFF151515).withOpacity(0.4),
                        elevation: 3,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: SingleChildScrollView(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        data.title ?? '',
                                        style: GoogleFonts.raleway(color: Colors.white),
                                      ),
                                      SizedBox(height: 8),
                                      Text(
                                        data.notes != null &&
                                                data.notes!.length > 120
                                            ? '${data.notes!.substring(0, 120)}...'
                                            : data.notes ?? '',
                                        style: GoogleFonts.raleway(color: Colors.grey),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      showDialog(
                                        context: context,
                                        builder: (context) {
                                          return NotesEditDialogue(
                                              title: data.title ?? '',
                                              notes: data.notes ?? '',
                                              id: data.id ?? '',
                                              color: data.color,
                                              );
                                        },
                                      );
                                    },
                                    child: Icon(
                                      Icons.edit,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      FireStoreService().deleteNote(data.id ?? '');
                                    },
                                    child: Icon(
                                      Icons.delete,
                                      color: Colors.red,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                }
              },
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return NotesAddDialogue();
            },
          );
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}

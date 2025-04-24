import 'package:flutter/material.dart';
import 'package:pardikte/features/notes/provider/notes_provider.dart';
import 'package:pardikte/features/notes/widgets/note_card.dart';

import 'package:provider/provider.dart';

class NotesListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final provider = context.watch<NotesProvider>();
    return Scaffold(
      appBar: AppBar(title: Text('My Secure Notes')),
      body: ListView.builder(
        itemCount: provider.notes.length,
        itemBuilder: (context, i) => NoteCard(note: provider.notes[i]),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => provider.createDummyNote(), // contoh
        child: Icon(Icons.add),
      ),
    );
  }
}

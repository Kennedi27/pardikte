import 'package:flutter/material.dart';
import 'package:pardikte/data/models/node_model.dart';
import 'package:pardikte/features/notes/provider/notes_provider.dart';
import 'package:pardikte/features/notes/screens/note_detail_screen.dart';
import 'package:provider/provider.dart';

class NoteCard extends StatelessWidget {
  final Note note;

  const NoteCard({Key? key, required this.note}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Karena di model kita menyimpan decrypted content dalam encryptedContent field
    final content = note.encryptedContent;
    // Tampilkan cuplikan (first 50 chars)
    final snippet = content.length > 50 ? content.substring(0, 50) + '…' : content;

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 3,
      child: ListTile(
        title: Text(
          note.title,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(snippet),
        trailing: PopupMenuButton<String>(
          onSelected: (value) async {
            final provider = context.read<NotesProvider>();
            if (value == 'edit') {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => NoteDetailScreen(note: note),
                ),
              );
            } else if (value == 'delete') {
              // TODO: implement delete in provider
              // await provider.deleteNote(note.id!);
              // provider.loadNotes();
            }
          },
          itemBuilder: (_) => [
            PopupMenuItem(value: 'edit', child: Text('Edit')),
            PopupMenuItem(value: 'delete', child: Text('Delete')),
          ],
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => NoteDetailScreen(note: note),
            ),
          );
        },
      ),
    );
  }
}

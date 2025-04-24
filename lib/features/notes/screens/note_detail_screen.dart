import 'package:flutter/material.dart';
import 'package:pardikte/data/models/node_model.dart';
import 'package:pardikte/features/notes/provider/notes_provider.dart';
import 'package:provider/provider.dart';


class NoteDetailScreen extends StatefulWidget {
  final Note note;
  const NoteDetailScreen({Key? key, required this.note}) : super(key: key);

  @override
  _NoteDetailScreenState createState() => _NoteDetailScreenState();
}

class _NoteDetailScreenState extends State<NoteDetailScreen> {
  late TextEditingController _titleController;
  late TextEditingController _contentController;
  bool _isEditing = false;

  @override
  void initState() {
    super.initState();
    // Karena field encryptedContent sudah berisi teks didekripsi
    _titleController = TextEditingController(text: widget.note.title);
    _contentController = TextEditingController(text: widget.note.encryptedContent);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  Future<void> _saveNote() async {
    final provider = context.read<NotesProvider>();
    final updatedTitle = _titleController.text.trim();
    final updatedContent = _contentController.text.trim();

    if (updatedTitle.isEmpty || updatedContent.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Title and content cannot be empty')),
      );
      return;
    }

    // TODO: implement updateNote in provider & repository
    // await provider.updateNote(
    //   widget.note.id!,
    //   updatedTitle,
    //   updatedContent,
    // );
    // await provider.loadNotes();

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_isEditing ? 'Edit Note' : 'View Note'),
        actions: [
          IconButton(
            icon: Icon(_isEditing ? Icons.check : Icons.edit),
            onPressed: () {
              if (_isEditing) {
                _saveNote();
              }
              setState(() => _isEditing = !_isEditing);
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              enabled: _isEditing,
              decoration: InputDecoration(
                labelText: 'Title',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: TextField(
                controller: _contentController,
                enabled: _isEditing,
                maxLines: null,
                expands: true,
                decoration: InputDecoration(
                  labelText: 'Content',
                  alignLabelWithHint: true,
                  border: OutlineInputBorder(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

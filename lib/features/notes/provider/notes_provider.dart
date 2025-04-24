import 'package:flutter/material.dart';
import 'package:pardikte/data/models/node_model.dart';
import '../../../data/repository/note_repository.dart';
import '../../../core/services/encryption_service.dart';
import '../../../data/database/notes_database.dart';

class NotesProvider extends ChangeNotifier {
  final NoteRepository _repo;

  List<Note> _notes = [];
  List<Note> get notes => _notes;

  NotesProvider({required EncryptionService crypto})
      : _repo = NoteRepository(
          db: NotesDatabase.instance,
          crypto: crypto,
        ) {
    loadNotes();
  }

  Future<void> loadNotes() async {
    // Dapatkan catatan terdekripsi
    _notes = await _repo.getAllNotesDecrypted();
    notifyListeners();
  }

  Future<void> addNote(String title, String content) async {
    final note = await _repo.addNote(title, content);
    // Setelah simpan, reload
    await loadNotes();
  }

  Future<void> createDummyNote() async {
    // Contoh pembuatan catatan dummy
    await addNote('Catatan contoh', 'Ini isi catatan terenkripsi');
  }

  // TODO: updateNote, deleteNote, dsb.
}

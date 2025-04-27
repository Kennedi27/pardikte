import 'package:flutter/material.dart';
import 'package:pardikte/data/models/node_model.dart';
import '../../../data/repository/note_repository.dart';

class NotesProvider extends ChangeNotifier {
  final NoteRepository _repo;

  List<Note> _notes = [];
  List<Note> get notes => _notes;
  
  NotesProvider({required NoteRepository repo}) : _repo = repo {
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

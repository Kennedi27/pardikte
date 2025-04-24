import '../models/node_model.dart';
import '../database/notes_database.dart';
import '../../core/services/encryption_service.dart';

class NoteRepository {
  final NotesDatabase db;
  final EncryptionService crypto;

  NoteRepository({required this.db, required this.crypto});

  Future<Note> addNote(String title, String plainContent) async {
    final encrypted = crypto.encrypt(plainContent);
    final note = Note(title: title, encryptedContent: encrypted);
    return await db.create(note);
  }

  Future<List<Note>> getAllNotesDecrypted() async {
    final notes = await db.readAll();
    return notes.map((n) {
      final decrypted = crypto.decrypt(n.encryptedContent);
      return Note(
        id: n.id,
        title: n.title,
        encryptedContent: decrypted, // reuse field to hold decrypted
        createdAt: n.createdAt,
        updatedAt: n.updatedAt,
      );
    }).toList();
  }
}

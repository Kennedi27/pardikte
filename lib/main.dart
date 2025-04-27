import 'package:flutter/material.dart';
import 'package:pardikte/core/utils/crypto_helper.dart';
import 'package:pardikte/data/database/notes_database.dart';
import 'package:pardikte/data/models/node_model.dart';
import 'package:pardikte/features/notes/provider/notes_provider.dart';
import 'package:pardikte/features/notes/screens/notes_list_screen.dart';
import 'package:provider/provider.dart';
import 'data/repository/note_repository.dart';
import 'features/notes/screens/note_detail_screen.dart';

void main() {
   WidgetsFlutterBinding.ensureInitialized(); // optional, buat safety

  final noteDatabase = NotesDatabase.instance;
  final cryptoHelper = CryptoHelper();
  final noteRepository = NoteRepository(
    db: noteDatabase,
    crypto: cryptoHelper,
  );

  runApp(MyApp(noteRepository: noteRepository));
}

class MyApp extends StatelessWidget {
  final NoteRepository noteRepository;

  const MyApp({Key? key, required this.noteRepository}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => NotesProvider(repo: noteRepository)..loadNotes(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Secure Notes',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: NotesListScreen(),
        onGenerateRoute: (settings) {
          if (settings.name == '/note_detail') {
            final note = settings.arguments as Note;
            return MaterialPageRoute(
              builder: (_) => NoteDetailScreen(note: note),
            );
          }
          return null;
        },
      ),
    );
  }
}

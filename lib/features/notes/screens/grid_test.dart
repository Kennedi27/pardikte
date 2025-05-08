import 'package:flutter/material.dart';
import 'package:pardikte/features/notes/widgets/explore_grid.dart';

class GridTest extends StatelessWidget {
  final List<String> dummyNotes = [
    "Beli susu",
    "Jangan lupa meeting jam 10 pagi sama tim UI/UX",
    "Catatan pribadi rahasia",
    "Ide untuk project: \n- Flutter\n- AI\n- Microservice",
    "Doa dan harapan hari ini",
    "Singkat saja.",
    "Ini contoh catatan yang panjang banget supaya kelihatan tinggi grid-nya menyesuaikan otomatis dan tidak terpotong, serta tetap rapi!",
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Note Grid Demo',
      home: Scaffold(
        appBar: AppBar(title: Text('My Notes')),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: NoteGrid(notes: dummyNotes),
        ),
      ),
    );
  }
}

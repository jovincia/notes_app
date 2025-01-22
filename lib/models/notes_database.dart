import 'package:isar/isar.dart';
import 'package:notes_app/models/notes.dart';
import 'package:provider/provider.dart';
import 'package:path_provider/path_provider.dart';


class NotesDatabase {

  static late Isar isar;

  //INITIALIZE THE DATABASE
  static Future<void> initialize() async{
    final dir = await getApplicationDocumentsDirectory();
    isar = await Isar .open(
      [NotesSchema], directory: dir.path,

      );
  }
  //list of the notes
  final List<Notes> currentNotes = [];
  //CREATE- a note and save it in the db
  //create a new note
  Future<void> addNotes(String textFromUser) async{
    final newNote = Notes().text  = textFromUser;

    //save the note in the 
    await isar.writeTxn(()=> isar.notes.put(newNote as Notes));
    
    //re read the note from the bd 
    fetchNotes();

    }

   
      
  //READ- a note
  Future<void> fetchNotes() async{
    List<void> fetchedNotes = await isar.notes.where().findAll();
    currentNotes.clear();
    currentNotes.addAll(fetchedNotes as Iterable<Notes>);
  }
  //UPDATE- a note in the db
  Future<void> updateNotes(int id, String newText) async{
    final existingNote = await isar.notes.get(id);
    if(existingNote != null){
      existingNote.text = newText;
      await isar.writeTxn(()=>isar.notes.put(existingNote));
      await fetchNotes();
    }

  }

  //DELETE- a note from db

   Future<void> deleteNotes(int id) async{
    await isar.writeTxn(()=> isar.notes.delete(id));
    await fetchNotes();
   }
}
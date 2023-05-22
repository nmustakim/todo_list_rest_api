
import 'package:http/http.dart' as http;
import '../models/todo_model.dart';
import 'package:fluttertoast/fluttertoast.dart';
const baseUrl = 'jsonplaceholder.typicode.com';

class TodoRemoteService {
  Future<List<Todo?>?> getTodosList() async {
    var response = await http.get(Uri.https(baseUrl, "todos"));
    try {
      if (response.statusCode == 200) {
        var json = response.body;
        return todoFromJson(json);
      }
    } catch (error) {
      Fluttertoast.showToast(msg: error.toString());
    }
    return null;
  }
}
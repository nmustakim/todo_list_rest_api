import 'package:flutter/material.dart';
import 'package:todo_list/screens/widgets/todo_tile.dart';

import '../const/const.dart';
import '../models/todo_model.dart';
import '../remote_services/todo_remote_service.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController searchController = TextEditingController();
  List<Todo?>? todosList = [];
  List<Todo?>? searchList = [];
  bool isLoaded = false;

  @override
  void initState() {
    getData();
    super.initState();
  }

  void getData() async {
    todosList = await TodoRemoteService().getTodosList();
    if (todosList != null) {
      setState(() {
        isLoaded = true;
      });
    }
  }

  void runFilter(String enteredString) {
    if (enteredString.isEmpty) {
      setState(() {
        searchList = todosList!;
      });
    } else {
      setState(() {
        searchList = todosList!
            .where((element) => element!.title
                .toLowerCase()
                .contains(enteredString.toLowerCase()))
            .toList();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Todos",
            style: titleTextStyle1,
          ),
          centerTitle: true,
          elevation: 0,
          backgroundColor: Colors.lightBlue,
        ),
        body: SafeArea(
          child: Visibility(
              visible: isLoaded,
              replacement: const Center(child: CircularProgressIndicator()),
              child: Stack(children: [
                Container(
                  color: Colors.lightBlue,
                  height: 150,
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          margin: const EdgeInsets.all(24),
                          height: 41,
                          child: TextField(
                            textAlign: TextAlign.center,
                            onChanged: (v) => runFilter(v),
                            controller: searchController,
                            decoration: InputDecoration(
                              hintText: "Search by title",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(24),
                              ),
                              fillColor: Colors.white70,
                              filled: true,
                            ),
                          ),
                        ),
                      ),
                      IconButton(
                          onPressed: () => runFilter(searchController.text),
                          icon: const Icon(
                            Icons.search,
                            color: Colors.white,
                            size: 35,
                          )),
                      const SizedBox(
                        width: 10,
                      )
                    ],
                  ),
                ),
                searchController.text.isNotEmpty && searchList!.isEmpty
                    ? const Center(
                        child: Text("No todos found"),
                      )
                    : searchList!.isNotEmpty
                        ? Container(
                            margin: const EdgeInsets.only(top: 120),
                            padding: const EdgeInsets.only(top: 20),
                            height: MediaQuery.of(context).size.height / 1.1,
                            decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(30),
                                    topLeft: Radius.circular(30))),
                            child: ListView.builder(
                                itemCount: searchList!.length,
                                itemBuilder: (context, index) {
                                  Todo todo = searchList![index]!;
                                  return TodoTile(
                                    text: todo.title,
                                    icon: todo.completed
                                        ? Icons.check_box_outlined
                                        : Icons
                                            .check_box_outline_blank_outlined,
                                    id: todo.id,
                                  );
                                }),
                          )
                        : todosList!.isEmpty
                            ? const Center(
                                child: Text("No todos here"),
                              )
                            : Container(
                                margin: const EdgeInsets.only(top: 120),
                                padding: const EdgeInsets.only(top: 20),
                                height:
                                    MediaQuery.of(context).size.height / 1.1,
                                decoration: const BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(30),
                                        topLeft: Radius.circular(30))),
                                child: ListView.builder(
                                    itemCount: todosList!.length,
                                    itemBuilder: (context, index) {
                                      Todo todo = todosList![index]!;
                                      return TodoTile(
                                        text: todo.title,
                                        icon: todo.completed
                                            ? Icons.check_box_outlined
                                            : Icons
                                                .check_box_outline_blank_outlined,
                                        id: todo.id,
                                      );
                                    }),
                              )
              ])),
        ));
  }
}

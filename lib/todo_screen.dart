import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app_with_php/apis/Widgets.dart';
import 'package:todo_app_with_php/apis/crud.dart';

import 'apis/services/middleware.dart';
import 'apis/to_do_add.dart';

class ToDoScreen extends StatefulWidget {
  const ToDoScreen({Key? key}) : super(key: key);

  @override
  State<ToDoScreen> createState() => _ToDoScreenState();
}

Crud crud = Crud();
ToDoView() async {
  var response = await crud.getData(linkView);
  if (response["status"] == "success") {
    Get.off(ToDoScreen());
  } else {
    print("${response["status"]}");
  }
}

class _ToDoScreenState extends State<ToDoScreen> {
  ToDoDelete(id) async {
    var response = await crud.postData(linkDelete, {
      "id": id.toString(),
    });
    if (response["status"] == "success") {
      setState(() {});
      Get.off(ToDoScreen());

      //Get.offAndToNamed('/ToDoScreen');
    } else {
      print("${response["status"]}");
    }
  }

  @override
  void initState() {
    super.initState();
    //  viewTask(); // Fetch tasks when the screen initializes
    ToDoDelete(myServices.sharedPrefer.getString("id").toString());
  }

  Crud crud = Crud();

  viewTask() async {
    var userId = myServices.sharedPrefer.getString("id");
    var response = await crud.postData(linkView, {
      "id": userId.toString(),
    });

    print('User ID: $userId');
    return response;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("Todo List")),
        backgroundColor: Colors.blueAccent,
      ),
      body: ListView(
        children: [
          FutureBuilder(
              future: viewTask(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data["status"] == "Fail")
                    return Center(
                        child: Text("you don't have notes to show.. "));

                  return ListView.builder(
                      itemCount: snapshot.data['data'].length,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return TaskItem(
                          // Pass task details to the TaskItem widget
                          name: "${snapshot.data['data'][index]['name']}",
                          time: "${snapshot.data['data'][index]['time']}",
                          date: "${snapshot.data['data'][index]['date']}",
                          onDissmiss: () {
                            ToDoDelete(snapshot.data['data'][index]['id']);
                          },
                        );
                      });
                } else if (snapshot.connectionState ==
                    ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(child: Text("No data available"));
                }
                return Center(child: Text("No Notes available"));
              }),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.off(ToDoAddScreen());
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

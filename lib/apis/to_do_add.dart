import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:todo_app_with_php/todo_screen.dart';

import 'crud.dart';

class ToDoAddScreen extends StatelessWidget {
  var titleController = TextEditingController();
  var timeController = TextEditingController();
  var dateController = TextEditingController();

  var formKey = GlobalKey<FormState>();
  Crud crud = Crud();

  ToDoadd() async {
    var response = await crud.postData(linkAdd, {
      "name": titleController.text,
      "time": timeController.text,
      "date": dateController.text,
    });
    if (response["status"] == "success") {
      Get.to(ToDoScreen());
    } else {
      // print("${response["status"]}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Get.to(ToDoScreen());
              },
              icon: Icon(Icons.arrow_back)),
          title: Center(
            child: Text("add your task"),
          ),
          backgroundColor: Colors.deepPurple[100],
        ),
        body: Padding(
            padding: EdgeInsets.all(15),
            child: Form(
              key: formKey,
              child: SingleChildScrollView(
                  child: Column(children: [
                Column(
                  children: [
                    SizedBox(
                      height: 50,
                    ),
                    defaultTextFromField(
                      controller: titleController,
                      typeOfText: TextInputType.text,
                      validate: (String? value) {
                        if (value!.isEmpty) {
                          return 'title must not be empty';
                        }
                        return null;
                      },
                      label: 'Task name',
                      prefix: Icons.title,
                      onTap: () {},
                    ),
                    const SizedBox(
                      height: 15.0,
                    ),
                    defaultTextFromField(
                      controller: timeController,
                      typeOfText: TextInputType.datetime,
                      onTap: () {
                        showTimePicker(
                                context: context, initialTime: TimeOfDay.now())
                            .then((value) {
                          timeController.text =
                              value!.format(context).toString();
                        });
                      },
                      validate: (String? value) {
                        if (value!.isEmpty) {
                          return 'time must not be empty';
                        }
                        return null;
                      },
                      label: 'Task Time',
                      prefix: Icons.watch_later_outlined,
                    ),
                    const SizedBox(
                      height: 15.0,
                    ),
                    defaultTextFromField(
                      controller: dateController,
                      typeOfText: TextInputType.datetime,
                      onTap: () {
                        showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime.now(),
                          lastDate: DateTime(2025),
                        ).then((value) {
                          if (value != null) {
                            String formattedDate =
                                DateFormat('dd/MM/yyyy').format(value);
                            dateController.text = formattedDate;
                          }
                        });
                      },
                      validate: (String? value) {
                        if (value!.isEmpty) {
                          return 'date must not be empty';
                        }
                        return null;
                      },
                      label: 'Task Date',
                      prefix: Icons.calendar_today,
                    ),
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                MaterialButton(
                    minWidth: double.infinity,
                    color: Colors.deepPurple[100],
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        ToDoadd();
                      }
                    },
                    child: Text("add Task"))
              ])),
            )));
  }
}

Widget defaultTextFromField({
// for email and password button
  required TextEditingController controller,
  required TextInputType typeOfText,
  Function? onSubmit,
  Function? onChange,
  required Function onTap,
  required Function validate,
  required String label,
  bool isPassword = false,
  required IconData prefix,
  IconData? suffix,
  Function()? suffixPressed,
}) =>
    TextFormField(
      controller: controller,
      keyboardType: typeOfText,
      obscureText: isPassword,
      // onFieldSubmitted: (s) {
      //   onSubmit!(s);
      // },
      // onChanged: (s) {
      //   onChange(s);
      // },
      onTap: () {
        onTap();
      },
      validator: (String? value) {
        if (value!.isEmpty) {
          print('The Time Of Task Must Not Be Empty');
          return null;
        }
      },
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(prefix),
        suffixIcon: suffix != null
            ? IconButton(
                onPressed: () {
                  suffixPressed!();
                },
                icon: Icon(suffix))
            : null,
        border: const OutlineInputBorder(),
      ),
    );

// ignore_for_file: prefer_const_constructors, use_build_context_synchronously, unused_import

import 'dart:developer';


import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

import '../models/todo_model.dart';
import '../screens/home_page.dart';

import '../screens/update_page.dart';
import '../services/services.dart';


class SuccessPosts extends StatelessWidget {
    const SuccessPosts({
    Key? key,
    required this.posts,
  }) : super(key: key);
  final List<TodoModel>? posts;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: posts?.length,
      itemBuilder: (BuildContext context, int index) {
        return Card(
          // ignore: sort_child_properties_last
          // ignore: sort_child_properties_last
          child: ListTile(
            onTap: () 
            {
              final post = posts![index];
            
              Navigator.push(context, MaterialPageRoute(builder: (context) =>  UpdatePage(id: post.id.toString(), title: post.title.toString(),)));
            },
           trailing: IconButton(icon: const Icon(Icons.delete) , onPressed: () 
           {
              // ignore: unused_element
              
                    ToDoService? services = ToDoService();
                    Widget cancelButton = ElevatedButton(
                      child: Text("İptal", style: TextStyle(color: Color.fromARGB(255, 255, 255, 255)),),
                      onPressed:  () {
                        Navigator.of(context).pop();
                      },
                    );
                    Widget continueButton = ElevatedButton(
                      child: Text("Sil" , style: TextStyle(color: Color.fromARGB(255, 255, 255, 255)),),
                      onPressed:  () async {
                        // ignore: unused_local_variable
                        final response = await services.toDoDelete(posts![index].id.toString());
                         AwesomeDialog(
                          context: context,
                          dialogType: DialogType.success,
                          animType: AnimType.rightSlide,
                          title: 'Başarılı',
                          desc: 'İşlem Başarılı Bir Şekilde Gerçekleşti.',
                          btnOkOnPress: () 
                          {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => const HomePage()));
                          },
                          btnOkText: "Tamam"
                          ).show();
                      },
                    );
                    AlertDialog alert = AlertDialog(
                      title: Text("Uyarı!"),
                      content: Text("Silmek İstediğinize Emin Misiniz?"),
                      actions: [
                        cancelButton,
                        continueButton,
                      ],
                    );
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return alert;
                      },
                    );
                     


            

            }, color: Colors.red,),
            leading: control(index),//Icon(Icons.assignment_turned_in, color:Colors.green , ),
            title: Text(
              '${posts?[index].title}',  style: const TextStyle(color: Color.fromARGB(255, 0, 0, 0), ), 
            ),
          ),
          elevation: 4.0,
        );
      },
      padding: const EdgeInsets.all(
        10.0,
      ),
    );
  }
  colors(index) 
  {
    if(posts![index].completed == true)
    {
      return Colors.green;
    }
    else
    {
      return Colors.red;
    }
  }
  
  control(index) 
  {
    if(posts![index].completed == true)
    {
      return const Icon(Icons.assignment_turned_in, color:Colors.green , );
    }
    else
    {
      return const Icon(Icons.cancel_sharp, color:Colors.red, );
    }
  }
  showAlertDialog(BuildContext context , String id) {
  ToDoService? services = ToDoService();
  Widget cancelButton = ElevatedButton(
    child: Text("İptal", style: TextStyle(color: Color.fromARGB(255, 255, 255, 255)),),
    onPressed:  () {
      Navigator.of(context).pop();
    },
  );
  Widget continueButton = ElevatedButton(
    child: Text("Sil" , style: TextStyle(color: Color.fromARGB(255, 255, 255, 255)),),
    onPressed:  () async {
      // ignore: unused_local_variable
      final response = await services.toDoDelete(id);
       Navigator.push(context, MaterialPageRoute(builder: (context) => const HomePage()));   
    },
  );
  AlertDialog alert = AlertDialog(
    title: Text("Uyarı!"),
    content: Text("Silmek İstediğinize Emin Misiniz?"),
    actions: [
      cancelButton,
      continueButton,
    ],
  );
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
}

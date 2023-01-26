// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';



import 'package:awesome_dialog/awesome_dialog.dart';

import '../models/todo_model.dart';
import '../request/todo_add_request.dart';
import '../services/services.dart';
import 'home_page.dart';

class AddPage extends StatefulWidget {
  const AddPage({super.key});

  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  TodoModel? todoModel;
  ToDoService? services = ToDoService();
  final TextEditingController titleController = TextEditingController();
   GlobalKey<FormState> globalKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold
    (
      appBar: AppBar(title: const Text("Ekleme Sayafası"),
      ),
      body: Center
      (
        child: Column
        (
          mainAxisAlignment: MainAxisAlignment.center,
          children: 
          [
             Form(
              key: globalKey,
              autovalidateMode: AutovalidateMode.disabled,
              child: TextFormField(
              validator:(value) {
                return value!.isEmpty ? "Bu Alan Boş Geçilemez" : null ;
                },         
              controller: titleController,                 
              decoration: InputDecoration(
              labelText: "Görev Giriniz",
              border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
               ),
               ),
              ),
              ),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton( 
              child: const Text("Ekle"),
              onPressed: () async
              {
                if(globalKey.currentState!.validate())
                {
                
                  ToDoAddRequest todoRequest = ToDoAddRequest();
                  todoRequest.title = titleController.text;
                  final response = await services?.todoAdd(todoRequest);
                  if(response!.successful) 
                    {
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
                      // ignore: avoid_print
                      print("işlem başarılı");
                    }
                    else 
                    {
                        AwesomeDialog(
                        context: context,
                        dialogType: DialogType.error,
                        animType: AnimType.rightSlide,
                        title: 'Başarısız',
                        desc: 'İşlem Başarısız Oldu.',
                        btnOkOnPress: () 
                        {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => const HomePage()));
                        },
                        btnOkText: "Tamam"
                        ).show();
                      // ignore: avoid_print
                      print("hata");
                    }
                      }
                      else 
                      {
                        
                      }

              }
              ),
              
          ],
        ),
      ),
    );
  }
}
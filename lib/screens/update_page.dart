import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';

import '../models/todo_model.dart';
import '../request/todo_update_request.dart';
import '../services/services.dart';
import 'home_page.dart';


// ignore: must_be_immutable
class UpdatePage extends StatefulWidget {
  

   // ignore: prefer_const_constructors_in_immutables
   UpdatePage({Key? key,required this.id,required this.title}) : super(key: key);

final String id;
final String title;
  @override
  
  // ignore: no_logic_in_create_state
  State<UpdatePage> createState() => _UpdatePageState(id , title);
}

class _UpdatePageState extends State<UpdatePage> {
  
  TodoModel? todoModel;
  ToDoService? services = ToDoService();
  
  // ignore: prefer_typing_uninitialized_variables
  var id;
  // ignore: prefer_typing_uninitialized_variables
  var title;
 _UpdatePageState(this.id , this.title);
  late TextEditingController titleController;
  bool? isChecked= false;
  
  @override
  Widget build(BuildContext context) {
    titleController = TextEditingController();
    titleController.text=title;
    return Scaffold
    (
      appBar: AppBar(title: const Text("Güncelleme Sayfası"),
      ),
      body: Center(
        child: Column
        (
          mainAxisAlignment: MainAxisAlignment.center,
          children: 
          [
            TextFormField(      
                     
              controller: titleController, 
              
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
              labelText: "Title Giriniz",
              border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
               ),
               ),
              ),
             Row
             (
              children: 
              [
                const SizedBox(width: 150,),
                // ignore: prefer_const_constructors
                Text("Yapıldı", style:  TextStyle(fontSize: 20),),
                 Checkbox(
                
                value: isChecked, 
                onChanged: (newBool) 
                {
                  setState(() {
                    isChecked = newBool;
                  });
                }),
              ],
             ),
              ElevatedButton( 
              child: const Text("Güncelle"),
              onPressed: () async
              {
                ToDoUpdateRequest toDoUpdateRequest = ToDoUpdateRequest();
                  toDoUpdateRequest.title = titleController.text;
                  toDoUpdateRequest.completed = isChecked;
                  // ignore: unused_local_variable
                  final response = await services?.todoUpdate(toDoUpdateRequest, id);
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
                        print("işlem başarılı");
                      }
                      else 
                      // ignore: duplicate_ignore
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
                        
                        print("işlem başarısız");
                      }
              } 
              )
          ],
        ),
      ),
    );
  }
}
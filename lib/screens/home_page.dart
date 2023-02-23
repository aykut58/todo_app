
// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

import '../models/todo_model.dart';
import '../services/services.dart';
import '../widget/api_error_widget.dart';
import '../widget/loading_widget.dart';
import '../widget/success_posts.dart';
import 'add_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  
  final toDoService = ToDoService(); /// servis sınıfında bir nesne oluşturuyoruz.
  /// Futurebuilder bizden future bekliyor bizde tüm todoları çeken future tanımlıyoruz.
  /// late vermemin sebebi başlangıçta null olabilir ama ileride mutlaka bir değer alacak
  /// burada ?'de kullanılabilir.
  late Future<List<TodoModel>> future; 

 @override  
void initState() 
{
  /// initState sayfa çağrıldığında sayfa yüklenmeden oluşan method.
  /// veri çağırma işlemleri bu bölümde yapılır sayfa yüklenmeden veri alınmış olsun.
   super.initState();
  future = toDoService.tumTodo();
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton
      (
        child: Icon(Icons.add),
        onPressed: () 
        {
          Navigator.push(context, MaterialPageRoute(builder: (context) => const AddPage()));
        },
      ),
      appBar:
      AppBar(title: const Text("Todo List"),),
      body: Center
      (
        child: FutureBuilder
        (
          future: future,
          builder: (BuildContext context , AsyncSnapshot<List<TodoModel>> snapshot) 
          {
            if(snapshot.hasData)
          {
         
            return SuccessPosts (
              posts: snapshot.data,
            );
          }
        else if (snapshot.hasError) {
            return ApiErrorWidget(
              errorMessage: 'Veriler alınamadı. Hata mesajı: ${snapshot.error}',
            );

            /// Veri tamamen gelene kadar [LoadingWidget] widgetini göster.
          } else {
            return const LoadingWidget(
              text: 'Veriler yükleniyor...',
            );
          }
          },
        )
      ),
    );
  }
  }

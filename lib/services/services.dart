// ignore_for_file: unused_local_variable

import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/todo_model.dart';
import '../request/todo_add_request.dart';
import '../request/todo_update_request.dart';
import '../response/todo_add_response.dart';
import '../response/todo_delete_response.dart';
import '../response/todo_update_response.dart';

class ToDoService
{
  final baseUrl ="https://us-central1-todo-app-4f938.cloudfunctions.net/app";
  final requestHeaders = <String, String>{'Content-Type': 'application/json; charset=UTF-8'};
  final path= "/api/v1/todo";


  /// Tüm Posts verilerini getiren GET metodu
  Future <List<TodoModel>> tumTodo () async 
  {
    /// url birleştiriliyor ve parse ediliyor.
    final url = Uri.parse(baseUrl + path);
    
    /// HTTP GET metodunu kullanarak bir İstek(Request)'te bulunuyoruz.
    /// Bu isteğe karşılık REST API'den gelecek olan Yanıt(Response)'ı
    /// response isimli değişkene atıyoruz.
    final response = await http.get(url , headers: requestHeaders);

    /// Gelen Yanıt (Response)'ın body'si bize String olarak döner.
    final responseBody = response.body;

    /// String verileri dart:convert kütüphanesinde yer alan
    /// jsonDecode() metodu yardımıyla List olarak ayrıştırdık (parse ettik)
    /// Neden List?: REST API'den dönen veri bir JSON Array[] olduğu için
    final decodedBody = jsonDecode(responseBody);

    /// Ayrıştırılan List<dynamic> tipindeki verileri
    /// map() metodu ile Iterable<Post> tipine ve
    /// fromJson() metoduyla da Dart nesnesine dönüştürdük.
     var iterable = decodedBody.map((e) => TodoModel.fromJson(e));

    /// from() metodu ile Iterable<Post>'tan
    /// veri tipi List<Post> olan yeni bir liste oluşturduk.
     var listPosts = List<TodoModel>.from(iterable);

    /// Dönen Yanıt (Response) kodu 2XX: Başarılı Cevap Kodlarından olan
    /// 200 OK (Tamam) ise yani yanıt başarılı bir şekilde geri döndüyse
    if(response.statusCode == 200) 
    {
      /// _listPosts'u döndür.
      /// Dikkat: Burada dönen veri tipi ile asenkron metodun veri tipi aynı olmalı.
      /// Yani her ikiside List<Post>> tipinde olmalılar
      return listPosts;
    }
    else 
    {
      /// Status Code 200'den farklı ise
      /// bir Exception hatası fırlat.
       throw Exception(
        'Veriler alınamadı. Hata Kodu: ${response.statusCode}',
      );
    }

  }


   Future<ToDoAddResponse> todoAdd (ToDoAddRequest toDoRequest) async 
  {
    
    /// url birleştiriliyor ve parse ediliyor.
    final url = Uri.parse(baseUrl + path); 

    /// HTTP GET metodunu kullanarak bir İstek(Request)'te bulunuyoruz.
    /// Bu isteğe karşılık REST API'den gelecek olan Yanıt(Response)'ı
    /// response isimli değişkene atıyoruz.
    final response = await http.post(url , headers: requestHeaders , body: jsonEncode(toDoRequest));

    /// Gelen Yanıt (Response)'ın body'si bize String olarak döner.
    final responseBody = response.body;


    final result = jsonDecode(responseBody);

    /// Response sınıfında bir nesne oluşturuoyruz.
    ToDoAddResponse toDoResponse = ToDoAddResponse();

    /// responseden veriye göreye "successful" değerini true yapıyoruz.
    /// truee olması demek görevin yapıldığı anlamına gelecek
    /// ona göre tasrımda değişiklik sağlayacağız.
    toDoResponse.successful=response.statusCode == 201;
    if(response.statusCode == 201)
    {
       toDoResponse.successful = true;
       toDoResponse.completed = result["completed"];
    }
    else
    {
      /// istek başarılı dönmemesi halinde hata kodu fırlatıyor.
      throw Exception(
        'Veriler alınamadı. Hata Kodu: ${response.statusCode}',
      );
    }

     return Future.value(toDoResponse);
  }

  Future<ToDoUpdateResponse> todoUpdate(ToDoUpdateRequest toDoUpdateRequest , String id ) async 
  {
    final url = Uri.parse("$baseUrl$path/$id"); 

    final response = await http.put(url , headers: requestHeaders , body: jsonEncode(toDoUpdateRequest));
    final responseBody = response.body;
    
    final result = jsonDecode(responseBody);
    ToDoUpdateResponse toDoUpdateResponse = ToDoUpdateResponse();
    if(response.statusCode == 200) 
    {
      toDoUpdateResponse.successful = true;
    }
     else
    {
      throw Exception(
        'Veriler alınamadı. Hata Kodu: ${response.statusCode}',
      );
    }
     return Future.value(toDoUpdateResponse);
  }


  Future<TodoDeleteResponse> toDoDelete(String id) async 
  {
    final url = Uri.parse("$baseUrl$path/$id"); 
    final response = await http.delete(url);
     final responseBody = response.body;
    final result = jsonDecode(responseBody);
    TodoDeleteResponse todoDeleteResponse = TodoDeleteResponse();
    if(response.statusCode == 200)
    {
      todoDeleteResponse.successful=true;
    } 
    else
    {
      throw Exception(
        'Veriler alınamadı. Hata Kodu: ${response.statusCode}',
      );
    } 
    return Future.value(todoDeleteResponse);
    }
}
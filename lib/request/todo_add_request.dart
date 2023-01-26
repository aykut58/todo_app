class ToDoAddRequest 
{
  String? title;
  Map<String ,dynamic> toJson() => 
  {
    "title" : title
  };
}
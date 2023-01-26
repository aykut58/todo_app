class ToDoUpdateRequest
{
  String? title;
  bool? completed;

   Map<String ,dynamic> toJson() => 
  {
    "title" : title,
    "completed" : completed
  };
}
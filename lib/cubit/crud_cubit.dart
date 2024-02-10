import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/todo.dart';
import '../services/database_service.dart';

part 'crud_state.dart';

class CrudCubit extends Cubit<CrudState> {
  CrudCubit() : super(CrudInitial());

  void add(Todo todo) async {
    await DatabaseService.instance.create(
      Todo(
        createdTime: todo.createdTime,
        description: todo.description,
        isImportant: todo.isImportant,
        number: todo.number,
        title: todo.title,
      ),
    );
  }

  void update(Todo todo) async {
    await DatabaseService.instance.update(todo: todo);
  }

  void readAll() async {
    final List<Todo> todos = await DatabaseService.instance.readAllTodos();
    emit(DisplayTodos(todos));
  }

  void readById(int id) async {
    Todo todo = await DatabaseService.instance.readTodo(id: id);
    emit(DisplaySpecificTodo(todo));
  }

  void delete(int id) async {
    await DatabaseService.instance.delete(id: id);
    final List<Todo> todos = await DatabaseService.instance.readAllTodos();
    emit(DisplayTodos(todos));
  }
}

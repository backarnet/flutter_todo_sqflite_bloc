part of 'crud_cubit.dart';

sealed class CrudState extends Equatable {
  const CrudState();

  @override
  List<Todo> get props => [];
}

class CrudInitial extends CrudState {
  @override
  List<Todo> get props => [];
}

class DisplayTodos extends CrudState {
  final List<Todo> todos;

  const DisplayTodos(this.todos);
  @override
  List<Todo> get props => todos;
}

class DisplaySpecificTodo extends CrudState {
  final Todo todo;

  const DisplaySpecificTodo(this.todo);
  @override
  List<Todo> get props => [todo];
}

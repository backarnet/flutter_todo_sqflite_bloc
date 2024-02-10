import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/crud_bloc.dart';
import 'details_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CrudBloc, CrudState>(
      builder: (context, state) {
        if (state is CrudInitial) {
          context.read<CrudBloc>().add(const FetchTodos());
        }
        if (state is DisplayTodos) {
          return SafeArea(
            child: Container(
              padding: const EdgeInsets.all(8),
              height: MediaQuery.of(context).size.height,
              child: Column(children: [
                Center(
                  child: Text(
                    'Add a Todo'.toUpperCase(),
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                state.todo.isNotEmpty
                    ? Expanded(
                        child: ListView.builder(
                          scrollDirection: Axis.vertical,
                          padding: const EdgeInsets.all(8),
                          itemCount: state.todo.length,
                          itemBuilder: (context, i) {
                            return GestureDetector(
                              onTap: () {
                                context.read<CrudBloc>().add(
                                    FetchSpecificTodo(id: state.todo[i].id!));
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: ((context) => const DetailsPage()),
                                  ),
                                );
                              },
                              child: Container(
                                height: 80,
                                margin: const EdgeInsets.only(bottom: 14),
                                child: Card(
                                  elevation: 10,
                                  color: Colors.blue,
                                  child: Column(
                                    children: [
                                      ListTile(
                                        title: Text(
                                          state.todo[i].title.toUpperCase(),
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        trailing: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            IconButton(
                                                onPressed: () {
                                                  context.read<CrudBloc>().add(
                                                      DeleteTodo(
                                                          id: state
                                                              .todo[i].id!));
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(
                                                          const SnackBar(
                                                    duration: Duration(
                                                        milliseconds: 500),
                                                    content:
                                                        Text("deleted todo"),
                                                  ));
                                                },
                                                icon: const Icon(
                                                  Icons.delete,
                                                  color: Colors.red,
                                                ))
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      )
                    : const Text(''),
              ]),
            ),
          );
        }
        return Container(
          color: Colors.white,
          child: const Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}

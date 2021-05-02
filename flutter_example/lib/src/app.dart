import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_example/src/bloc/todo_bloc.dart';
import 'package:flutter_example/src/bloc/todo_event.dart';
import 'package:flutter_example/src/bloc/todo_state.dart';
import 'package:flutter_example/src/repository/todo_repository.dart';

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => TodoBloc(
          repository:
              TodoRepository()), // provider를 초기화 하는 작업, child 아래에 있는 모든 widget 에서 bloc class 안에 있는 기능들을 사용할 수 있게 됨
      child: HomeWidget(),
    );
  }
}

class HomeWidget extends StatefulWidget {
  @override
  _HomeWidgetState createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  String title = '';

  @override
  void initState() {
    super.initState();
    // Bloc 불러내는 방법 1
    // ListTodosEvent
    BlocProvider.of<TodoBloc>(context)
        .add(ListTodoEvent()); // add는 기본적으로 Bloc에 있는 이벤트
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter BloC'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Bloc 불러내는 방법 2
          context.read<TodoBloc>().add(CreateTodoEvent(title: title));
        },
        child: Icon(Icons.edit),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              onChanged: (val) {
                title = val;
              },
            ),
            SizedBox(
              height: 16,
            ),
            Expanded(
              child: BlocBuilder<TodoBloc, TodoState>(
                  // BloC 을 사용하기 위한 widget. 2개의 generic (1. BloC, 2. State)
                  builder: (context, state) {
                if (state is Empty) {
                  return Container();
                } else if (state is Loading) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is Error) {
                  return Container(
                    child: Text(state.message),
                  );
                } else if (state is Loaded) {
                  // 여기서 복잡해질 로직
                  final items = state.todos;

                  return ListView.separated(
                      itemBuilder: (_, index) {
                        final item = items[index];
                        return Row(
                          children: [
                            Expanded(child: Text(item.title)),
                            InkWell(
                              onTap: () {
                                // Bloc 불러내는 방법 3
                                BlocProvider.of<TodoBloc>(context)
                                    .add(DeleteTodoEvent(todo: item));
                              },
                              child: Icon(Icons.delete),
                            )
                          ],
                        );
                      },
                      separatorBuilder: (_, index) => Divider(),
                      itemCount: items.length);
                }

                return Container();
              }),
            ),
          ],
        ),
      ),
    );
  }
}

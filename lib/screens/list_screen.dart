import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'form_screen.dart';

class ListScreen extends StatefulWidget {
  const ListScreen({super.key});

  @override
  State<ListScreen> createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  List<dynamic> _tasks = [];

  @override
  void initState() {
    super.initState();
    _fetchTasks();
  }

  Future<void> _fetchTasks() async {
    try {
      final data = await Supabase.instance.client
          .from('notes')
          .select()
          .order('id', ascending: false);

      setState(() {
        _tasks = data;
      });
    } catch (e) {
      print('Error fetching data: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error fetching data: $e')),
      );
    }
  }

  Future<void> _updateTaskCompletion(int id, bool? isCompleted) async {
    try {
      await Supabase.instance.client
          .from('notes')
          .update({'is_completed': isCompleted}).eq('id', id);

      _fetchTasks();
    } catch (e) {
      print('Error updating task: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error updating task: $e')),
      );
    }
  }

  Future<void> _deleteTask(int id) async {
    try {
      await Supabase.instance.client.from('notes').delete().eq('id', id);

      _fetchTasks();
    } catch (e) {
      print('Error deleting task: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error menghapus task: $e')),
      );
    }
  }

  Future<void> _navigateToAddTask() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const FormScreen()),
    );

    if (result == true) {
      _fetchTasks();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('To-Do List'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _fetchTasks,
          ),
        ],
      ),
      body: _tasks.isEmpty
          ? const Center(child: Text('Belum ada task'))
          : ListView.builder(
              itemCount: _tasks.length,
              itemBuilder: (context, index) {
                final task = _tasks[index];
                return Dismissible(
                  key: Key(task['id'].toString()),
                  background: Container(
                    color: Colors.red,
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.only(right: 20),
                    child: const Icon(
                      Icons.delete,
                      color: Colors.white,
                    ),
                  ),
                  direction: DismissDirection.endToStart,
                  onDismissed: (direction) {
                    _deleteTask(task['id']);
                  },
                  child: ListTile(
                    leading: Checkbox(
                      value: task['is_completed'] ?? false,
                      onChanged: (bool? value) {
                        _updateTaskCompletion(task['id'], value);
                      },
                    ),
                    title: Text(
                      task['title'],
                      style: TextStyle(
                        decoration: (task['is_completed'] ?? false)
                            ? TextDecoration.lineThrough
                            : null,
                      ),
                    ),
                    subtitle: Text(task['description'] ?? ''),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: _navigateToAddTask,
        child: const Icon(Icons.add),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class FormScreen extends StatefulWidget {
  const FormScreen({super.key});

  @override
  State<FormScreen> createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  bool _isLoading = false;

  Future<void> _insertData() async {
    final title = _titleController.text.trim();
    final description = _descriptionController.text.trim();

    if (title.isNotEmpty) {
      setState(() {
        _isLoading = true;
      });

      try {
        await Supabase.instance.client.from('notes').insert({
          'title': title,
          'description': description,
          'is_completed': false,
        });

        Navigator.pop(context, true);
      } catch (e) {
        print('Error inserting data: $e');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error menambahkan data: $e')),
        );
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Judul tidak boleh kosong!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tambah Task')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(labelText: 'Judul'),
            ),
            TextField(
              controller: _descriptionController,
              decoration: const InputDecoration(labelText: 'Deskripsi'),
            ),
            const SizedBox(height: 20),
            _isLoading
                ? const CircularProgressIndicator()
                : ElevatedButton(
                    onPressed: _insertData,
                    child: const Text('Simpan'),
                  ),
          ],
        ),
      ),
    );
  }
}

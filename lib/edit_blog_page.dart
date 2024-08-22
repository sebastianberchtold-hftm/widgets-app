import 'package:flutter/material.dart';
import 'package:ui_controls_demo/blog.dart';

import 'blog_repository.dart';

class EditBlogPage extends StatefulWidget {
  final Blog blog;

  const EditBlogPage({Key? key, required this.blog}) : super(key: key);

  @override
  _EditBlogPageState createState() => _EditBlogPageState();
}

class _EditBlogPageState extends State<EditBlogPage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _titleController;
  late TextEditingController _contentController;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.blog.title);
    _contentController = TextEditingController(text: widget.blog.content);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Blog'),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: _saveBlog,
          ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              TextFormField(
                controller: _titleController,
                decoration: InputDecoration(labelText: 'Title'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a title';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _contentController,
                decoration: InputDecoration(labelText: 'Content'),
                maxLines: 8,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some content';
                  }
                  return null;
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _saveBlog() {
    if (_formKey.currentState!.validate()) {
      final updatedBlog = Blog(
        id: widget.blog.id,
        title: _titleController.text,
        content: _contentController.text,
        publishedAt: widget.blog.publishedAt,
      );
      BlogRepository.instance.updateBlogPost(updatedBlog).then((_) {
        Navigator.of(context).pop();
      });
    }
  }
}

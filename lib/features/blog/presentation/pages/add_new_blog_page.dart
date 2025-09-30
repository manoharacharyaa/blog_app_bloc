import 'dart:io';

import 'package:blog_app_bloc/core/theme/app_pallet.dart';
import 'package:blog_app_bloc/core/utils/pick_image.dart';
import 'package:blog_app_bloc/features/blog/presentation/widgets/blog_editor.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

class AddNewBlogPage extends StatefulWidget {
  static route() => MaterialPageRoute(
    builder: (context) => const AddNewBlogPage(),
  );
  const AddNewBlogPage({super.key});

  @override
  State<AddNewBlogPage> createState() => _AddNewBlogPageState();
}

class _AddNewBlogPageState extends State<AddNewBlogPage> {
  final titleController = TextEditingController();
  final contentController = TextEditingController();
  List<String> selectedTopic = [];
  File? image;

  void addAndRemove(String element) {
    if (selectedTopic.contains(element)) {
      selectedTopic.remove(element);
    } else {
      selectedTopic.add(element);
    }
    setState(() {});
  }

  void selectImage() async {
    final pickedImage = await pickImage();
    if (pickedImage != null) {
      setState(() {
        image = pickedImage;
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
    titleController.dispose();
    contentController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.done_rounded),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              image != null
                  ? GestureDetector(
                      onTap: selectImage,
                      child: SizedBox(
                        height: 150,
                        width: double.infinity,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.file(
                            File(image!.path),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    )
                  : GestureDetector(
                      onTap: selectImage,
                      child: DottedBorder(
                        options: const RoundedRectDottedBorderOptions(
                          radius: Radius.circular(10),
                          color: AppPallete.borderColor,
                          dashPattern: [10, 4],
                          strokeCap: StrokeCap.round,
                        ),
                        child: Container(
                          height: 150,
                          width: double.infinity,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.folder_open,
                                size: 40,
                              ),
                              const SizedBox(height: 15),
                              Text(
                                'Select your image',
                                style: TextStyle(fontSize: 15),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
              const SizedBox(height: 20),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children:
                      [
                            'Technology',
                            'Business',
                            'Programming',
                            'Entertainment',
                          ]
                          .map(
                            (e) => Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: GestureDetector(
                                onTap: () => addAndRemove(e),
                                child: Chip(
                                  label: Text(e),
                                  color: selectedTopic.contains(e)
                                      ? WidgetStatePropertyAll(
                                          AppPallete.gradient1,
                                        )
                                      : null,
                                  side: selectedTopic.contains(e)
                                      ? null
                                      : const BorderSide(
                                          color: AppPallete.borderColor,
                                        ),
                                ),
                              ),
                            ),
                          )
                          .toList(),
                ),
              ),
              const SizedBox(height: 10),
              BlogEditor(
                controller: titleController,
                hintText: 'Blog title',
              ),
              const SizedBox(height: 10),
              BlogEditor(
                controller: contentController,
                hintText: 'Blog title',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

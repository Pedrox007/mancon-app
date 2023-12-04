// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

// ignore: must_be_immutable
class FileInput extends StatefulWidget {
  String title = "Anexar arquivo";
  File? attachedFile;
  bool fileAlreadyAttached;
  void Function(File, String) onSelected;
  VoidCallback onRemoved;

  FileInput({
    super.key,
    required this.fileAlreadyAttached,
    required this.onSelected,
    required this.onRemoved,
  }) {
    if (fileAlreadyAttached) {
      title = "Arquivo anexado";
    }
  }

  @override
  State<FileInput> createState() => _FileInputState();
}

class _FileInputState extends State<FileInput> {
  void fileAttached(File file) {
    setState(() {
      widget.attachedFile = file;
      widget.fileAlreadyAttached = true;
      widget.title = "Arquivo anexado";
    });
  }

  void attachPDF() async {
    FilePickerResult? pickedFile = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ["pdf"],
    );

    if (pickedFile != null) {
      File file = File(pickedFile.files.single.path!);
      widget.onSelected(file, "PDF");

      fileAttached(file);
    }

    Navigator.pop(context);
  }

  void attachImage() async {
    XFile? pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      File file = File(pickedFile.path);
      widget.onSelected(file, "IMAGE");

      fileAttached(file);
    }

    Navigator.pop(context);
  }

  void openCamera() async {
    XFile? pickedFile = await ImagePicker().pickImage(
      source: ImageSource.camera,
    );

    if (pickedFile != null) {
      File file = File(pickedFile.path);
      widget.onSelected(file, "IMAGE");

      fileAttached(file);
    }

    Navigator.pop(context);
  }

  void removeFile() {
    setState(() {
      widget.attachedFile = null;
      widget.fileAlreadyAttached = false;
      widget.title = "Anexar arquivo";
    });
    widget.onRemoved();
  }

  void chooseFileAttach(BuildContext context) {
    if (widget.fileAlreadyAttached) {
      removeFile();
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            backgroundColor: Colors.transparent,
            elevation: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                InkWell(
                  onTap: attachPDF,
                  child: Container(
                    height: 90,
                    width: 80,
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primary,
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                    ),
                    child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.file_present_rounded),
                        SizedBox(
                          height: 8,
                        ),
                        Text(
                          "Anexar\nPDF",
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: attachImage,
                  child: Container(
                    height: 90,
                    width: 80,
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primary,
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                    ),
                    child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.photo),
                        SizedBox(
                          height: 8,
                        ),
                        Text(
                          "Anexar\nImagem",
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: openCamera,
                  child: Container(
                    height: 90,
                    width: 80,
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primary,
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                    ),
                    child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.camera_alt_rounded),
                        SizedBox(
                          height: 8,
                        ),
                        Text(
                          "Capturar\nImagem",
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        chooseFileAttach(context);
      },
      child: DottedBorder(
        color: Theme.of(context).colorScheme.primary,
        borderType: BorderType.RRect,
        dashPattern: const [8, 4],
        radius: const Radius.circular(10),
        child: SizedBox(
          height: 55,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  widget.fileAlreadyAttached
                      ? Icon(
                          Icons.file_download_done,
                          color: Theme.of(context).colorScheme.primary,
                        )
                      : Icon(
                          Icons.attach_file,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                  Text(
                    widget.title,
                    style: TextStyle(
                      fontSize: 16,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  )
                ],
              ),
              widget.fileAlreadyAttached
                  ? const Text(
                      "Aperte para desanexá-lo",
                      style: TextStyle(
                        fontSize: 10,
                      ),
                    )
                  : const SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}

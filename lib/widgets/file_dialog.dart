import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';

class FileDialog extends StatefulWidget {
  final String fileUrl;
  final String fileType;

  const FileDialog({
    super.key,
    required this.fileUrl,
    required this.fileType,
  });

  @override
  State<FileDialog> createState() => _FileDialogState();
}

class _FileDialogState extends State<FileDialog> {
  File? file;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();

    loadFile();
  }

  void loadFile() async {
    setState(() {
      isLoading = true;
    });

    final docFile = await DefaultCacheManager().getSingleFile(widget.fileUrl);

    setState(() {
      file = docFile;
      isLoading = false;
    });
  }

  Widget getPdfViewer(BuildContext context) {
    return PDFView(
      filePath: file!.path,
    );
  }

  Widget getImageViewer(BuildContext context) {
    return Image.network(widget.fileUrl);
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        height: 400,
        decoration: BoxDecoration(
          border: Border.all(
            color: Theme.of(context).colorScheme.primary,
            width: 3,
          ),
          borderRadius: const BorderRadius.all(Radius.circular(10)),
        ),
        child: widget.fileType == "PDF"
            ? isLoading
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : getPdfViewer(context)
            : getImageViewer(context),
      ),
    );
  }
}

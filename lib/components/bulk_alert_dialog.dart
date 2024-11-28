import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';

import 'package:csv/csv.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path_provider/path_provider.dart';

import '../main_barrel.dart';

class BulkAlertDialog extends StatefulWidget {
  const BulkAlertDialog({super.key});

  @override
  State<BulkAlertDialog> createState() => _BulkAlertDialogState();
}

class _BulkAlertDialogState extends State<BulkAlertDialog> {
  Uint8List? data;
  PlatformFile? selectedFile;
  final String _extension = "csv";
  String? fileName;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 330,
      width: 450,
      padding: const EdgeInsets.symmetric(horizontal: 25),
      decoration: BoxDecoration(
          color: Palette.secondary, borderRadius: BorderRadius.circular(10)),
      child: BlocBuilder<ProductCubit, ProductState>(builder: (context, state) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: GestureDetector(
                    onTap: () async {
                      generateCSV().then((value) {
                        if (value.isNotEmpty) {
                          if (context.mounted) {
                            snack(context, 'File Saved in Downloads Folder');
                          }
                        }
                      });
                    },
                    child: Text(
                      'Download Sample file',
                      style: CustomFontStyle.regularText
                          .copyWith(fontSize: 16, color: Palette.green),
                    ),
                  ),
                ),
                MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: GestureDetector(
                    onTap: () {
                      if (state is! UploadingFile) {
                        pop(context);
                      }
                    },
                    child: const Icon(
                      Icons.close,
                      color: Palette.black,
                    ),
                  ),
                )
              ],
            ),
            MouseRegion(
              cursor: SystemMouseCursors.click,
              child: GestureDetector(
                onTap: () {
                  selectCSV();
                },
                child: Container(
                  height: 100,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Palette.lightGrey.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(10)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.upload_file_rounded,
                        color: Palette.black,
                      ),
                      Text(
                        fileName ?? 'Select file to upload',
                        style: CustomFontStyle.regularText
                            .copyWith(color: Palette.black),
                      )
                    ],
                  ),
                ),
              ),
            ),
            state is FileUploaded
                ? Text(
                    state.message,
                    style: CustomFontStyle.regularText
                        .copyWith(color: Palette.greenColor),
                  )
                : SizedBox(
                    width: 160,
                    child: ProductFeatureButton(
                        isLoading: state is UploadingFile,
                        iconPath: Assets.uploadFileIcon,
                        text: 'Upload File',
                        onTap: () {
                          if (data != null) {
                            context.read<ProductCubit>().uploadFile(
                                fileName ?? '', data ?? Uint8List(0));
                          }
                        },
                        backgroundColor: Palette.primary,
                        iconColor: Palette.secondary),
                  )
          ],
        );
      }),
    );
  }

  Future<String> generateCSV() async {
    log('generateCSV');
    List<List<String>> itemList = [
      <String>[
        'Product Name',
        'Box Retail Price',
        'Quantity Of Box',
        'Sheets In Box',
        'Tablets In Sheet',
        'Expiry Date',
        'Dosage',
        'Scientific Name',
        'Whole Sale Price',
        "Minimum Purchase",
        "Source",
        "Description",
        "Barcode"
      ]
    ];

    itemList.add(<String>[
      'A-Glip 50MG',
      '350',
      '400',
      '1',
      '0',
      DateFormat('dd/MM/yyyy').format(DateTime.fromMillisecondsSinceEpoch(
          DateTime.now().millisecondsSinceEpoch)),
      'Dosage Optional',
      'Sitagliptin Atco Lab',
      '320',
      '2',
      'Pharma Industry',
      'This medication is used to treat type 2 Diabetes',
      '123456789'
    ]);

    String csvData = const ListToCsvConverter().convert(itemList);
    final byte = utf8.encode(csvData);
    final directory = await getDownloadsDirectory();
    final filePath = '${directory?.path}/sample.csv';
    final file = File(filePath);
    await file.writeAsBytes(byte);
    log('filePath: ${file.path}');
    return file.path;
  }

  void selectCSV() async {
    FilePickerResult? csvFile = await FilePicker.platform.pickFiles(
      allowedExtensions: _extension.replaceAll('', '').split(','),
      type: FileType.custom,
      allowMultiple: false,
    );

    if (csvFile != null) {
      final filePath = csvFile.files.single.path;
      if (filePath == null) {
        return Future.error("File path not found");
      }
      final file = File(filePath);
      log('fileName: ${file.uri}');
      final rawData = await file.readAsBytes();
      setState(() {
        fileName = csvFile.files.first.name;
        data = rawData;
      });
      if (rawData.isEmpty) {
        return Future.error("No data found in file ${csvFile.files[0].name}");
      }
      debugPrint("The File name is =>>>>>>$fileName");
    }
  }
}

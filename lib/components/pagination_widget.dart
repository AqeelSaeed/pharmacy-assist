import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:number_paginator/number_paginator.dart';

import '../main_barrel.dart';

class PaginationWidget extends StatefulWidget {
  final int currentPage;
  final int totalPages;
  final Function(int) onPageChanged;

  const PaginationWidget({
    super.key,
    required this.currentPage,
    required this.totalPages,
    required this.onPageChanged,
  });

  @override

  // ignore: library_private_types_in_public_api
  _PaginationWidgetState createState() => _PaginationWidgetState();
}

class _PaginationWidgetState extends State<PaginationWidget> {
  NumberPaginatorController controller = NumberPaginatorController();

  @override
  void initState() {
    super.initState();

    controller.navigateToPage(widget.currentPage);
  }

  void _onPreviousClick() {
    if (widget.currentPage > 1) {
      setState(() {
        widget.onPageChanged(widget.currentPage - 1);
        controller.prev();
      });
    }
  }

  void _onNextClick() {
    if (widget.currentPage < widget.totalPages) {
      setState(() {
        widget.onPageChanged(widget.currentPage + 1);
        controller.next();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    context.locale.languageCode;
    return Align(
      alignment: Alignment.centerRight,
      child: SizedBox(
        width: widget.totalPages == 1
            ? 250
            : widget.totalPages == 2
                ? 290
                : widget.totalPages == 3
                    ? 340
                    : widget.totalPages == 4
                        ? 380
                        : 450,
        child: NumberPaginator(
          numberPages: widget.totalPages,
          initialPage: widget.currentPage - 1,
          controller: controller,
          showPrevButton: true,
          showNextButton: true,
          onPageChange: (int index) {
            log('pageNumberIndex: $index');

            setState(() {
              widget.onPageChanged(index + 1);
            });
          },
          config: NumberPaginatorUIConfig(
            buttonSelectedBackgroundColor: Palette.primary,
            mainAxisAlignment: MainAxisAlignment.center,
            buttonTextStyle:
                CustomFontStyle.regularText.copyWith(color: Palette.secondary),
            buttonShape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          ),
          nextButtonBuilder: (context) => GestureDetector(
            onTap: () {
              _onNextClick();
            },
            child: TextButton(
                onPressed: _onNextClick,
                child: Row(
                  children: [
                    Text(
                      next.tr(),
                      style: CustomFontStyle.regularText
                          .copyWith(color: Palette.primary),
                    ),
                    const Icon(Icons.chevron_right_rounded),
                  ],
                )),
          ),
          prevButtonBuilder: (context) => TextButton(
            onPressed: () {
              _onPreviousClick();
            },
            child: Row(
              children: [
                const Icon(Icons.chevron_left),
                Text(
                  previous.tr(),
                  style: CustomFontStyle.regularText
                      .copyWith(color: Palette.primary),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

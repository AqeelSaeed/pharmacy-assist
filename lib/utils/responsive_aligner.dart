import 'package:flutter/material.dart';

import 'responsive.dart';

class ResponsiveAligner extends StatelessWidget {
  final List<Widget> children;
  final int rows;

  const ResponsiveAligner({super.key, required this.children, this.rows = 1});

  @override
  Widget build(BuildContext context) {
    final paddedChildren = children.map((e) => Expanded(child: e)).toList();
    return Responsive.isMobile(context)
        ? Column(
            children: children
                .map((e) =>
                    Padding(padding: const EdgeInsets.all(8.0), child: e))
                .expand(
                  (element) => [element, const SizedBox(height: 10)],
                )
                .toList())
        : Column(
            children: [
              Row(
                children: paddedChildren
                    .sublist(0, paddedChildren.length ~/ rows)
                    .expand(
                      (element) => [element, const SizedBox(width: 20)],
                    )
                    .toList(),
              ),
              Row(
                children: paddedChildren
                    .sublist(
                        paddedChildren.length ~/ rows, paddedChildren.length)
                    .expand(
                      (element) => [element, const SizedBox(width: 20)],
                    )
                    .toList(),
              ),
            ]
                .expand(
                  (element) => [element, const SizedBox(height: 10)],
                )
                .toList(),
          );
  }
}

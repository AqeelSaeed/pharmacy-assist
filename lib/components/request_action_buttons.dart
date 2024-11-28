import 'package:flutter/material.dart';

import '../main_barrel.dart';

class ActionButtons extends StatelessWidget {
  final Function()? onTapGraph;
  final Function()? onTapView;
  final Function()? onTapReject;
  final Function()? onTapApprove;
  final Function()? onTapBlock;
  final Function()? onTapDelete;
  final Function()? onTapEdit;
  final Function()? onTapTill;
  final Function()? onTapQR;
  final Function()? onTapReturn;

  const ActionButtons({
    super.key,
    this.onTapGraph,
    this.onTapView,
    this.onTapReject,
    this.onTapApprove,
    this.onTapBlock,
    this.onTapDelete,
    this.onTapEdit,
    this.onTapTill,
    this.onTapQR,
    this.onTapReturn,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45,
      // width: 208,
      margin: EdgeInsets.only(
          right: Responsive.isDesktop(context)
              ? MediaQuery.sizeOf(context).width * 0.04
              : MediaQuery.sizeOf(context).width * 0.07),
      padding: const EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(7),
          boxShadow: [
            BoxShadow(
                color: Colors.grey.shade300,
                blurRadius: 4,
                spreadRadius: 1,
                offset: const Offset(0, 0))
          ]),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (onTapGraph != null)
            _IconButton(
                icon: Assets.cameraIcon, tooltip: 'Graph', onTap: onTapGraph!),
          if (onTapTill != null)
            _IconButton(
                icon: Assets.mailIcon, tooltip: 'Till No.', onTap: onTapTill!),
          if (onTapQR != null)
            _IconButton(
                icon: Assets.locationIcon,
                tooltip: 'Till No.',
                onTap: onTapQR!),
          if (onTapView != null)
            _IconButton(
                icon: Assets.viewIcon, tooltip: 'View', onTap: onTapView!),
          if (onTapReject != null)
            _IconButton(
                icon: Assets.locationIcon,
                tooltip: 'Reject',
                onTap: onTapReject!),
          if (onTapApprove != null)
            _IconButton(
                icon: Assets.editIcon, tooltip: 'Edit', onTap: onTapApprove!),
          if (onTapBlock != null)
            _IconButton(
                icon: Assets.locationIcon,
                tooltip: 'Block',
                onTap: onTapBlock!),
          if (onTapDelete != null)
            _IconButton(
                icon: Assets.trashIcon, tooltip: 'Delete', onTap: onTapDelete!),
          if (onTapEdit != null)
            _IconButton(
                icon: Assets.locationIcon, tooltip: 'Edit', onTap: onTapEdit!),
          if (onTapReturn != null)
            _IconButton(
                icon: Assets.returnsIcon,
                tooltip: 'Return',
                onTap: onTapReturn!),
        ].expand((element) => [element, const SizedBox(width: 16)]).toList()
          ..removeLast(),
      ),
    );
  }
}

class _IconButton extends StatelessWidget {
  final String icon;
  final String tooltip;
  final Function() onTap;

  const _IconButton(
      {required this.icon, required this.tooltip, required this.onTap});
  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: Tooltip(
        message: tooltip,
        waitDuration: const Duration(milliseconds: 200),
        child: GestureDetector(
          onTap: onTap,
          child: Image.asset(
            icon,
            width: 21,
            color: icon == Assets.returnsIcon ? Palette.black : null,
          ),
        ),
      ),
    );
  }
}

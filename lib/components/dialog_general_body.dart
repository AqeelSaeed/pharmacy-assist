import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharmacy_assist/main_barrel.dart';

class DialogGeneralBody extends StatelessWidget {
  final String title;
  final String item;
  final String iconPath;
  final bool? isLoading;
  final Function() onTap;

  const DialogGeneralBody(
      {super.key,
      required this.title,
      required this.item,
      this.isLoading,
      required this.iconPath,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 405,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 118,
            width: 118,
            decoration: const BoxDecoration(
                shape: BoxShape.circle, color: Color(0xFFF9F9F9)),
            child: Center(
              child: Image.asset(iconPath, width: 61),
            ),
          ),
          const SizedBox(height: 28),
          Text(
            '${areYouSure.tr()} ${title.toLowerCase()} ${thiss.tr()} ${item.toLowerCase()}${context.locale.languageCode == 'en' ? '?' : '؟'}',
            style: CustomFontStyle.regularText.copyWith(fontSize: 16),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 28),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ButtonComponent(
                text: cancel.tr(),
                buttonType: 'cancel',
                maxWidth: 178,
                fontWeight: FontWeight.w400,
                onPressed: () {
                  pop(context);
                },
              ),
              BlocListener<ProductCubit, ProductState>(
                listener: (context, state) {
                  if (state is ProductDeleted) {
                    Navigator.pop(context);
                  }
                },
                child: BlocBuilder<ProductCubit, ProductState>(
                    builder: (context, state) {
                  return ButtonComponent(
                    isLoading: state is DeletingProduct,
                    text: yesDelete.tr(),
                    maxWidth: 178,
                    buttonType: 'delete',
                    fontWeight: FontWeight.w400,
                    onPressed: onTap,
                  );
                }),
              )
            ],
          ),
        ],
      ),
    );
  }
}

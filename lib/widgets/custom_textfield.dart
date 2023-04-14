// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../enums/color_constants.dart';


class CustomTextField extends StatelessWidget {
  TextEditingController controller;
  String hint;
  bool? noBorder;
  bool? align;
  int? maxLines;
  bool? absorbing;
  bool? obscure;
  Widget? suffixIcon;
  Widget? prefixIcon;
  Color? borderColor;
  EdgeInsetsGeometry? contentPadding;
  TextInputType? type;
  String? Function(String?)? validator;
  List<TextInputFormatter>? inputFormatters;
  Function(String)? onChanged;
  CustomTextField(
      {Key? key,
        this.noBorder,
        this.contentPadding,
        this.validator,
        this.borderColor,
        this.obscure,
        this.align,
        this.onChanged,
        this.absorbing,
        this.maxLines,
        this.suffixIcon,
        this.prefixIcon,
        this.type,
        required this.controller,
        this.inputFormatters,
        required this.hint})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AbsorbPointer(
      absorbing: absorbing ?? false,
      child: TextFormField(
        validator: validator,
        textAlignVertical: align == null ? null : TextAlignVertical.center,
        onChanged: onChanged,
        style: const TextStyle(
          color: Colors.black,
          fontFamily: "Poppins",
          fontSize: 16,
        ),

        obscureText: obscure?? false,
        controller: controller,
        textInputAction: TextInputAction.done,
        inputFormatters: inputFormatters,
        maxLines: maxLines ?? 1,
        keyboardType: type ?? TextInputType.text,

        decoration: InputDecoration(

          errorStyle: const TextStyle(
            color:redColor,
            fontFamily: "Poppins",
            fontSize: 14,
          ),
          suffixIcon: suffixIcon,
          prefixIcon: prefixIcon,
          isDense: true,
          fillColor: whiteColor,
          filled: true,
          hintText: hint,
          hintStyle: const TextStyle(
            color: greyDark,
            fontFamily: "Poppins",
            fontSize: 16,
          ),
          contentPadding: contentPadding,
          errorBorder:noBorder!=null?const OutlineInputBorder(
              borderRadius: BorderRadius.only(topLeft: Radius.circular(10),bottomLeft: Radius.circular(10)),
              borderSide: BorderSide(color: redColor, width: 1)
          ): OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: redColor, width: 1)
          ),
          focusedErrorBorder:noBorder!=null? const OutlineInputBorder(
              borderRadius: BorderRadius.only(topLeft: Radius.circular(10),bottomLeft: Radius.circular(10)),
              borderSide: BorderSide(color: redColor, width: 1)
          ):  OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: redColor, width: 1)
          ),
          enabledBorder:noBorder!=null?const OutlineInputBorder(
              borderRadius: BorderRadius.only(topLeft: Radius.circular(10),bottomLeft: Radius.circular(10)),
              borderSide: BorderSide(color: textFieldColor, width: 1)):  OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: textFieldColor, width: 1)),
          focusedBorder:noBorder!=null?const OutlineInputBorder(
              borderRadius: BorderRadius.only(topLeft: Radius.circular(10),bottomLeft: Radius.circular(10)),
              borderSide: BorderSide(color: textFieldColor, width: 1)):  OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: textFieldColor, width: 1)),
        ),
      ),
    );
  }
}


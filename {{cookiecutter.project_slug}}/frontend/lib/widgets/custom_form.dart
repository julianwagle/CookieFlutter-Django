import 'package:flutter/material.dart';

class CustomForm extends StatelessWidget {
  const CustomForm({
    required this.children,
    required this.onSubmit,
    required this.submitText,
    this.errors,
    Key? key,
  }) : super(key: key);

  final List<Widget> children;
  final void Function() onSubmit;
  final String submitText;
  final List<String>? errors;

  @override
  Widget build(BuildContext context) {
    return AutofillGroup(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (errors != null)
            ...errors!
                .map(
                  (e) => Text(
                    ' ・ $e',
                    style: TextStyle(
                      color: Color(0xFFB85C5C),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )
                .toList(),
          SizedBox(height: 20),
          ...children
              .expand((formItem) => [
                    formItem,
                    SizedBox(height: 20),
                  ])
              .toList(),
          Row(
            children: [
              Spacer(),
              CustomSubmitButton(
                onSubmit: onSubmit,
                submitText: submitText,
              ),
            ],
          )
        ],
      ),
    );
  }
}

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    this.controller,
    this.hintText,
    this.autofillHints,
    this.maxLines,
    this.maxLength,
    this.initialValue,
    this.onChanged,
  });

  final TextEditingController? controller;
  final String? hintText;
  final Iterable<String>? autofillHints;
  final int? maxLines;
  final int? maxLength;
  final String? initialValue;
  final void Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      autofillHints: autofillHints,
      onChanged: onChanged,
      maxLines: maxLines,
      maxLength: maxLength,
      initialValue: initialValue,
      decoration: InputDecoration(
        hintText: hintText,
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blue),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black12),
        ),
      ),
    );
  }
}

class CustomSubmitButton extends StatelessWidget {
  const CustomSubmitButton({
    required this.onSubmit,
    required this.submitText,
  });

  final void Function() onSubmit;
  final String submitText;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onSubmit,
      style: ButtonStyle(
          foregroundColor: MaterialStateProperty.all(Colors.white),
          backgroundColor:
              MaterialStateProperty.all(Theme.of(context).primaryColor),
          overlayColor: MaterialStateProperty.resolveWith(
            (states) =>
                states.contains(MaterialState.hovered) ? Colors.black12 : null,
          ),
          minimumSize: MaterialStateProperty.all(Size(100, 60)),
          textStyle: MaterialStateProperty.all(TextStyle(fontSize: 18))),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Text(submitText),
      ),
    );
  }
}

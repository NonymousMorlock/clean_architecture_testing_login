import 'package:flutter/material.dart';

class AuthField extends StatelessWidget {
  const AuthField({
    super.key,
    this.labelText,
    this.controller,
    this.onSubmit,
    this.keyboardType,
  });

  final String? labelText;
  final TextEditingController? controller;
  final ValueChanged<String?>? onSubmit;
  final TextInputType? keyboardType;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Center(
      child: SizedBox(
        width: size.width / 4,
        child: TextFormField(
          keyboardType: keyboardType,
          controller: controller,
          decoration: InputDecoration(
            border: const OutlineInputBorder(),
            labelText: labelText,
          ),
          onFieldSubmitted: onSubmit,
          validator: (value) {
            if (value != null && value.isNotEmpty) return null;
            return labelText != null
                ? 'Please enter your $labelText'
                : 'This Field cannot be empty';
          },
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class LanguageTile extends StatelessWidget {
  const LanguageTile({
    super.key,
    required this.label,
    required this.checked,
    this.onChanged,
  });

  final String label;
  final bool checked;
  final ValueChanged<bool?>? onChanged;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.sizeOf(context);
    return ListTile(
      onTap: () {
        if (onChanged != null) {
          onChanged!(!checked);
        }
      },
      leading: const Icon(
        Icons.language,
        color: Colors.black,
      ),
      title: Text(label,
          style: const TextStyle(
              fontWeight: FontWeight.w500,
            ),
          ),
      trailing: Checkbox(
        value: checked,
        onChanged: onChanged,
        activeColor: Colors.black,
        shape: const CircleBorder(),
      ),
    );
  }
}

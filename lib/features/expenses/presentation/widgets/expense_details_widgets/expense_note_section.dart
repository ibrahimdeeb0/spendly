import 'package:spendly/general_exports.dart';

class ExpenseNoteSection extends StatelessWidget {
  final String note;

  const ExpenseNoteSection({super.key, required this.note});

  @override
  Widget build(BuildContext context) {
    final displayNote = note.trim().isEmpty ? context.tr.no_note : note.trim();

    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(context.tr.note, style: Theme.of(context).textTheme.titleMedium),
          SizedBox(height: context.tokens.s8),
          Text(displayNote, style: Theme.of(context).textTheme.bodyMedium),
        ],
      ),
    );
  }
}

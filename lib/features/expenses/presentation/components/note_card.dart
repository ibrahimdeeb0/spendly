import 'package:spendly/general_exports.dart';

class NoteCard extends StatelessWidget {
  final TextEditingController controller;
  const NoteCard({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(context.tr.note, style: Theme.of(context).textTheme.titleMedium),
          SizedBox(height: context.tokens.s12),
          TextField(
            controller: controller,
            maxLines: 3,
            onChanged: context.read<AddExpenseCubit>().setNote,
            decoration: InputDecoration(hintText: context.tr.note_hint),
          ),
        ],
      ),
    );
  }
}

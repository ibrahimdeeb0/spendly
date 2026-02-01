import 'package:spendly/general_exports.dart';

String dayTitle(BuildContext context, DateTime day) {
  final now = DateTime.now();
  final today = DateTime(now.year, now.month, now.day);
  final yesterday = today.subtract(const Duration(days: 1));
  final d = DateTime(day.year, day.month, day.day);

  if (d == today) return context.tr.today;
  if (d == yesterday) return context.tr.yesterday;

  // Simple date formatting without intl (you can switch to intl later)
  return '${day.year}-${day.month.toString().padLeft(2, '0')}-${day.day.toString().padLeft(2, '0')}';
}

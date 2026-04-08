import 'package:spendly/general_exports.dart';

class HomeMobileContent extends StatelessWidget {
  const HomeMobileContent({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        const ExpensesHeaderCard(),
        SizedBox(height: context.tokens.s16),
        const TopCategoriesCard(),
        SizedBox(height: context.tokens.s20),
        const ExpensesList(),
      ],
    );
  }
}

class HomeTabletContent extends StatelessWidget {
  const HomeTabletContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 5,
          child: ListView(
            children: [
              const ExpensesHeaderCard(),
              SizedBox(height: context.tokens.s16),
              const TopCategoriesCard(),
            ],
          ),
        ),
        SizedBox(width: context.tokens.s16),
        const Expanded(flex: 7, child: ExpensesList()),
      ],
    );
  }
}

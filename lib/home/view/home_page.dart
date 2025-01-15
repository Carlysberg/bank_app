import "package:auto_route/annotations.dart";
import "package:bank/common/animated_shapes.dart";
import "package:bank/common/dynamic_list_tile.dart";
import "package:bank/data/bloc/data_cubit.dart";
import "package:bank/data/bloc/data_state.dart";
import "package:bank/home/component/balance_card.dart";
import "package:bank/home/component/home_screen_logics.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:flutter_hooks/flutter_hooks.dart";
import "package:flutter_svg/svg.dart";
import "package:intl/intl.dart";

@RoutePage()
class HomePage extends HookWidget {
  const HomePage({
    required this.onTapSeeAll,
    super.key,
  });

  final VoidCallback onTapSeeAll;

  @override
  Widget build(BuildContext context) {
    final controller =
        useAnimationController(duration: const Duration(seconds: 2));
    useEffect(
      () {
        controller.repeat();
        return null;
      },
    );
    final size = MediaQuery.sizeOf(context).width / 20;
    final logic = HomeScreenLogics();
    final formatter = NumberFormat("#,###.00");
    return Scaffold(
      body: Column(
        children: [
          Stack(
            children: [
              BlocBuilder<DataCubit, DataState>(
                builder: (context, state) {
                  switch (state) {
                    case DataInitial():
                      return BalanceCard(
                        accountBalance: formatter.format(0),
                        onPressed: onTapSeeAll,
                      );
                    case DataLoading():
                      return BalanceCard(
                        accountBalance: formatter.format(0),
                        onPressed: onTapSeeAll,
                      );
                    case DataLoaded():
                      return BalanceCard(
                        accountBalance: formatter.format(
                          logic.balanceCalculator(state.transactionData).$3,
                        ),
                        onPressed: onTapSeeAll,
                      );
                    case DataError():
                      return BalanceCard(
                        accountBalance: formatter.format(0),
                        onPressed: onTapSeeAll,
                      );
                  }
                  return const Center(child: CircularProgressIndicator());
                },
              ),
              Container(
                height: 5,
                color: const Color(0xFF022E64).withOpacity(0.6),
              ),
            ],
          ),
          Expanded(
            child: BlocBuilder<DataCubit, DataState>(
              builder: (context, state) {
                switch (state) {
                  case DataInitial():
                    return Center(
                      child: Hero(
                        tag: "splash",
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                              "assets/images/blue_rectangle.svg",
                              width: size,
                            ),
                            AnimatedShapes(
                              controller: controller,
                              size: size,
                            ),
                          ],
                        ),
                      ),
                    );
                  case DataLoading():
                    return Center(
                      child: Hero(
                        tag: "splash",
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                              "assets/images/blue_rectangle.svg",
                              width: size,
                            ),
                            AnimatedShapes(
                              controller: controller,
                              size: size,
                            ),
                          ],
                        ),
                      ),
                    );
                  case DataLoaded():
                    final balances = logic.balanceCalculator(
                      state.transactionData,
                    );
                    final balanceBeforeTransaction = balances.$2;
                    final balanceAfterTransaction = balances.$1;
                    return ListView.builder(
                      itemCount: state.transactionData.length,
                      itemBuilder: (BuildContext context, int index) {
                        return DynamicListTile(
                          transactionAmount: formatter.format(
                            state.transactionData[index].transactionAmount,
                          ),
                          transactionDirection:
                              state.transactionData[index].transactionDirection,
                          transactionNarration:
                              state.transactionData[index].transactionNarration,
                          transactionDate:
                              state.transactionData[index].transactionDate,
                          balanceBeforeTransaction:
                              formatter.format(balanceBeforeTransaction[index]),
                          balanceAfterTransaction:
                              formatter.format(balanceAfterTransaction[index]),
                        );
                      },
                    );
                  case DataError():
                    return SvgPicture.asset(
                      "assets/images/error_fetching_data.svg",
                    );
                }
                return const Center(child: CircularProgressIndicator());
              },
            ),
          ),
        ],
      ),
    );
  }
}

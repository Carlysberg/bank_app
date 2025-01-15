import "package:auto_route/annotations.dart";
import "package:bank/common/dynamic_list_tile.dart";
import "package:bank/data/bloc/data_cubit.dart";
import "package:bank/data/bloc/data_state.dart";
import "package:bank/home/component/home_screen_logics.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:flutter_svg/svg.dart";
import "package:intl/intl.dart";

@RoutePage()
class TransactionPage extends StatefulWidget {
  const TransactionPage({super.key});
  static String id = "transaction_screen";

  @override
  State<TransactionPage> createState() => _TransactionPageState();
}

class _TransactionPageState extends State<TransactionPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final List<Tab> tabs = [
    const Tab(text: "All"),
    const Tab(text: "Debit"),
    const Tab(text: "Credit"),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: tabs.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final logic = HomeScreenLogics();
    final formatter = NumberFormat("#,###.00");
    return DefaultTabController(
      length: tabs.length,
      child: Scaffold(
        body: Column(
          children: [
            Stack(
              children: [
                ColoredBox(
                  color: const Color(0xFFE1E6F0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(left: 16, top: 16),
                        child: Text(
                          "Transactions",
                          style: TextStyle(
                            fontFamily: "OpenSans",
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      TabBar(
                        tabs: tabs,
                        indicatorColor: const Color(0xFF022E63),
                        labelColor: const Color(0xFF001530),
                        controller: _tabController,
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 5,
                  color: const Color(0xFF022E64).withOpacity(0.6),
                ),
              ],
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  BlocBuilder<DataCubit, DataState>(
                    builder: (context, state) {
                      switch (state) {
                        case DataInitial():
                          return Center(
                            child: Image.asset("assets/images/Loading.png"),
                          );
                        case DataLoading():
                          return Hero(
                            tag: "splash",
                            child: Center(
                              child: SizedBox(
                                height: 40,
                                width: 40,
                                child: Image.asset("assets/images/Loading.png"),
                              ),
                            ),
                          );
                        case DataLoaded():
                          final data = state;
                          final balances =
                              logic.balanceCalculator(data.transactionData);
                          final balanceBeforeTransaction = balances.$2;
                          final balanceAfterTransaction = balances.$1;
                          return ListView.builder(
                            itemCount: data.transactionData.length,
                            itemBuilder: (BuildContext context, int index) {
                              return DynamicListTile(
                                transactionAmount: formatter.format(
                                  data.transactionData[index].transactionAmount,
                                ),
                                transactionDirection: data
                                    .transactionData[index]
                                    .transactionDirection,
                                transactionNarration: data
                                    .transactionData[index]
                                    .transactionNarration,
                                transactionDate:
                                    data.transactionData[index].transactionDate,
                                balanceBeforeTransaction: formatter
                                    .format(balanceBeforeTransaction[index]),
                                balanceAfterTransaction: formatter
                                    .format(balanceAfterTransaction[index]),
                              );
                            },
                          );
                        case DataError():
                          return SvgPicture.asset(
                            "assets/images/error_fetching_data.svg",
                          );
                        default:
                          return const Center(child: Text("Unknown state"));
                      }
                    },
                  ),
                  BlocBuilder<DataCubit, DataState>(
                    builder: (context, state) {
                      switch (state) {
                        case DataInitial():
                        case DataLoading():
                          return Center(
                            child: Image.asset("assets/images/Loading.png"),
                          );
                        case DataLoaded():
                          final data = state;
                          final debitTransactions = data.transactionData
                              .where(
                                (transaction) =>
                                    transaction.transactionDirection == "D",
                              )
                              .toList();
                          final balances =
                              logic.balanceCalculator(debitTransactions);
                          final balanceBeforeTransaction = balances.$2;
                          final balanceAfterTransaction = balances.$1;
                          return ListView.builder(
                            itemCount: debitTransactions.length,
                            itemBuilder: (BuildContext context, int index) {
                              return DynamicListTile(
                                transactionAmount: formatter.format(
                                  debitTransactions[index].transactionAmount,
                                ),
                                transactionDirection: debitTransactions[index]
                                    .transactionDirection,
                                transactionNarration: debitTransactions[index]
                                    .transactionNarration,
                                transactionDate:
                                    debitTransactions[index].transactionDate,
                                balanceBeforeTransaction: formatter
                                    .format(balanceBeforeTransaction[index]),
                                balanceAfterTransaction: formatter
                                    .format(balanceAfterTransaction[index]),
                              );
                            },
                          );
                        case DataError():
                          return SvgPicture.asset(
                            "assets/images/error_fetching_data.svg",
                          );
                        default:
                          return const Center(child: Text("Unknown state"));
                      }
                    },
                  ),
                  BlocBuilder<DataCubit, DataState>(
                    builder: (context, state) {
                      switch (state) {
                        case DataInitial():
                        case DataLoading():
                          return Center(
                            child: Image.asset("assets/images/Loading.png"),
                          );
                        case DataLoaded():
                          final data = state;
                          final creditTransactions = data.transactionData
                              .where(
                                (transaction) =>
                                    transaction.transactionDirection == "C",
                              )
                              .toList();
                          final balances =
                              logic.balanceCalculator(creditTransactions);
                          final balanceBeforeTransaction = balances.$2;
                          final balanceAfterTransaction = balances.$1;
                          return ListView.builder(
                            itemCount: creditTransactions.length,
                            itemBuilder: (BuildContext context, int index) {
                              return DynamicListTile(
                                transactionAmount: formatter.format(
                                  creditTransactions[index].transactionAmount,
                                ),
                                transactionDirection: creditTransactions[index]
                                    .transactionDirection,
                                transactionNarration: creditTransactions[index]
                                    .transactionNarration,
                                transactionDate:
                                    creditTransactions[index].transactionDate,
                                balanceBeforeTransaction: formatter
                                    .format(balanceBeforeTransaction[index]),
                                balanceAfterTransaction: formatter
                                    .format(balanceAfterTransaction[index]),
                              );
                            },
                          );
                        case DataError():
                          return SvgPicture.asset(
                            "assets/images/error_fetching_data.svg",
                          );
                        default:
                          return const Center(child: Text("Unknown state"));
                      }
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

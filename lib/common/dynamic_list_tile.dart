import "package:flutter/material.dart";
import "package:flutter_svg/svg.dart";

class DynamicListTile extends StatelessWidget {
  const DynamicListTile({
    required this.transactionAmount,
    required this.transactionDirection,
    required this.transactionNarration,
    required this.transactionDate,
    required this.balanceBeforeTransaction,
    required this.balanceAfterTransaction,
    super.key,
  });
  final String transactionDate;
  final String transactionAmount;
  final String transactionDirection;
  final String transactionNarration;
  final String balanceBeforeTransaction;
  final String balanceAfterTransaction;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          horizontalTitleGap: 8,
          minLeadingWidth: 8,
          leading: transactionDirection == "C"
              ? SvgPicture.asset(
                  "assets/images/credit.svg",
                )
              : SvgPicture.asset(
                  "assets/images/debit.svg",
                ),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text(
                        "GHC $transactionAmount",
                        style: const TextStyle(
                          fontFamily: "OpenSans",
                          fontWeight: FontWeight.w700,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(width: 7),
                      Container(
                        decoration: BoxDecoration(
                          color: transactionDirection == "C"
                              ? const Color(0xFFE0AD0F).withOpacity(0.08)
                              : const Color(0xFF78C8E1).withOpacity(0.08),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8.76,
                            vertical: 5.26,
                          ),
                          child: Text(
                            transactionDirection == "C" ? "Credit" : "Debit",
                            style: TextStyle(
                              color: transactionDirection == "C"
                                  ? const Color(0xFFE0AD0F)
                                  : const Color(0xFF022E64),
                              fontFamily: "OpenSans",
                              fontWeight: FontWeight.w600,
                              fontSize: 9,
                              letterSpacing: 0.18,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Text(
                    transactionDate,
                    style: const TextStyle(
                      fontSize: 10,
                      fontFamily: "OpenSans",
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF616161),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    "#",
                    style: TextStyle(
                      fontFamily: "OpenSans",
                      fontWeight: FontWeight.w700,
                      fontSize: 12,
                      color: transactionDirection == "C"
                          ? const Color(0xFFE0AD0F)
                          : const Color(0xFF022E64),
                    ),
                  ),
                  Text(
                    transactionNarration,
                    style: const TextStyle(
                      fontFamily: "OpenSans",
                      fontWeight: FontWeight.w400,
                      fontSize: 12,
                      letterSpacing: 0.18,
                    ),
                  ),
                ],
              ),
            ],
          ),
          onTap: () {
            //---------------------------
            //modal bottom sheet
            //---------------------------
            buildShowModalBottomSheet(context);
          },
          shape: Border(
            bottom: BorderSide(
              color: Colors.black.withOpacity(0.1),
            ),
          ),
        ),
      ],
    );
  }

  Future<dynamic> buildShowModalBottomSheet(BuildContext context) {
    return showModalBottomSheet(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(32),
          topRight: Radius.circular(32),
        ),
      ),
      context: context,
      builder: (context) => Column(
        children: [
          Container(
            // small rounded rectangle
            margin: const EdgeInsets.only(top: 16),
            width: 39,
            height: 5,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: const Color(0xffd9d9d9),
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 4,
              vertical: 16,
            ),
            child: Text(
              "Transaction Details",
              style: TextStyle(
                color: Color(0xFF001530),
                fontFamily: "OpenSans",
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          ListTile(
            leading: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Balance Before Transaction",
                  style: TextStyle(
                    fontFamily: "OpenSans",
                    fontWeight: FontWeight.w400,
                    fontSize: 12,
                    color: Color(0xFF212121),
                  ),
                ),
                Text(
                  "Balance After Transaction",
                  style: TextStyle(
                    fontFamily: "OpenSans",
                    fontWeight: FontWeight.w400,
                    fontSize: 12,
                    color: Color(0xFF212121),
                  ),
                ),
              ],
            ),
            trailing: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  "GHC $balanceBeforeTransaction",
                  style: const TextStyle(
                    fontFamily: "OpenSans",
                    fontWeight: FontWeight.w700,
                    fontSize: 12,
                    color: Color(0xFF212121),
                  ),
                ),
                Text(
                  "GHC $balanceAfterTransaction",
                  style: const TextStyle(
                    fontFamily: "OpenSans",
                    fontWeight: FontWeight.w700,
                    fontSize: 12,
                    color: Color(0xFF212121),
                  ),
                ),
              ],
            ),
          ),
          const Divider(
            thickness: 1,
          ),
          ListTile(
            leading: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Transaction Date",
                  style: TextStyle(
                    fontFamily: "OpenSans",
                    fontWeight: FontWeight.w400,
                    fontSize: 12,
                    color: Color(0xFF212121),
                  ),
                ),
                Text(
                  "Transaction Direction",
                  style: TextStyle(
                    fontFamily: "OpenSans",
                    fontWeight: FontWeight.w400,
                    fontSize: 12,
                    color: Color(0xFF212121),
                  ),
                ),
                Text(
                  "Transaction Narration",
                  style: TextStyle(
                    fontFamily: "OpenSans",
                    fontWeight: FontWeight.w400,
                    fontSize: 12,
                    color: Color(0xFF212121),
                  ),
                ),
              ],
            ),
            trailing: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  transactionDate,
                  style: const TextStyle(
                    fontFamily: "OpenSans",
                    fontWeight: FontWeight.w700,
                    fontSize: 12,
                    color: Color(0xFF212121),
                  ),
                ),
                Text(
                  transactionDirection == "C" ? "Credit" : "Debit",
                  style: const TextStyle(
                    fontFamily: "OpenSans",
                    fontWeight: FontWeight.w700,
                    fontSize: 12,
                    color: Color(0xFF212121),
                  ),
                ),
                Text(
                  transactionNarration,
                  style: const TextStyle(
                    fontFamily: "OpenSans",
                    fontWeight: FontWeight.w700,
                    fontSize: 12,
                    color: Color(0xFF212121),
                  ),
                ),
              ],
            ),
          ),
          const Divider(
            thickness: 1,
          ),
        ],
      ),
    );
  }
}

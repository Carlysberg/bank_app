import "package:auto_size_text/auto_size_text.dart";
import "package:flutter/material.dart";

class BalanceCard extends StatelessWidget {
  const BalanceCard({
    required this.onPressed,
    required this.accountBalance,
    super.key,
  });
  final VoidCallback onPressed;
  final String accountBalance;

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.sizeOf(context).height;
    return SizedBox(
      child: Column(
        children: [
          Container(
            height: screenHeight / 4,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: <Color>[
                  Color(0xFFE0AD0F),
                  Color(0xFFA07801),
                ],
              ),
            ),
            child: Stack(
              fit: StackFit.expand,
              children: [
                Image.asset("assets/images/Vector.png", fit: BoxFit.cover),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Spacer(
                        flex: 2,
                      ),
                      Text(
                        "Account Balance",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFFFFFFFF).withOpacity(0.8),
                        ),
                      ),
                      const Spacer(),
                      AutoSizeText(
                        "GHC $accountBalance",
                        maxLines: 1,
                        minFontSize: 34,
                        maxFontSize: 36,
                        stepGranularity: 2,
                        style: const TextStyle(
                          fontWeight: FontWeight.w700,
                          color: Color(0xFFFFFFFF),
                        ),
                      ),
                      const Spacer(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Checking Account",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFFFFFFFF).withOpacity(0.8),
                            ),
                          ),
                          Text(
                            "875431143137098707",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFFFFFFFF).withOpacity(0.8),
                            ),
                          ),
                        ],
                      ),
                      const Spacer(
                        flex: 2,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          ColoredBox(
            color: const Color(0xFFE1E6F0).withOpacity(0.32),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const AutoSizeText(
                    "Recent Transactions",
                    maxLines: 1,
                    minFontSize: 10,
                    maxFontSize: 14,
                    stepGranularity: 2,
                    style: TextStyle(
                      fontFamily: "OpenSans",
                      color: Color(0xFF001530),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  GestureDetector(
                    onTap: onPressed,
                    child: const AutoSizeText(
                      "See All",
                      maxLines: 1,
                      minFontSize: 10,
                      maxFontSize: 14,
                      stepGranularity: 2,
                      style: TextStyle(
                        fontFamily: "OpenSans",
                        color: Color(0xFF022E64),
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:state_management_clean_arch/app/constants.dart';
import 'package:state_management_clean_arch/data/utils/date.dart';

class HistoryContainer extends StatelessWidget {
  final DateTime date;
  final bool isPressed;

  const HistoryContainer({
    required this.date,
    this.isPressed = false,
  });
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      height: 70,
      width: 70,
      decoration: BoxDecoration(
        color: isPressed ? MainColors.kPrimary : MainColors.kLightGrey,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            date.day.toString() +
                ' ' +
                DateUtil.getMonthOFGivenDateTime(date).substring(0, 3),
            style: TextStyle(
              color: isPressed ? MainColors.kCream : MainColors.kBlack,
              fontWeight: FontWeight.w600,
              fontSize: 15,
            ),
          ),
          Text(
            DateUtil.getDayOfGivenDateTime(date).substring(0, 3),
            style: TextStyle(
              color: isPressed ? MainColors.kCream : MainColors.kBlack,
              fontWeight: FontWeight.w500,
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }
}

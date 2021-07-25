import 'package:flutter/material.dart';
import 'package:state_management_clean_arch/app/constants.dart';

class TodoContainer extends StatelessWidget {
  final Size size;
  final bool isCurrent;
  final String title;
  final String date;
  final String duration;

  const TodoContainer({
    required this.size,
    required this.isCurrent,
    required this.title,
    required this.date,
    required this.duration,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      margin: EdgeInsets.only(bottom: 5),
      duration: Duration(milliseconds: 400),
      decoration: BoxDecoration(
          color: isCurrent ? MainColors.kPrimary : Colors.white,
          borderRadius: BorderRadius.circular(
            10,
          )),
      padding: EdgeInsets.only(
        left: 30,
      ),
      width: size.width,
      height: 70,
      child: Row(
        children: [
          Icon(
            Icons.check_box_outline_blank,
            size: 25,
            color: isCurrent ? MainColors.kCream : MainColors.kBlack,
          ),
          SizedBox(
            width: 25,
          ),
          Container(
            width: size.width - 210,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: isCurrent ? MainColors.kCream : MainColors.kBlack,
                    fontSize: 14,
                    fontWeight: isCurrent ? FontWeight.w700 : FontWeight.w500,
                  ),
                ),
                SizedBox(
                  height: 4,
                ),
                Text(
                  date,
                  style: TextStyle(
                    color: isCurrent ? MainColors.kCream : MainColors.kGrey,
                    fontWeight: isCurrent ? FontWeight.w700 : FontWeight.w500,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            width: 25,
          ),
          Text(
            duration,
            style: TextStyle(
              color: isCurrent ? MainColors.kCream : MainColors.kGrey,
              fontSize: 13,
              fontWeight: isCurrent ? FontWeight.w800 : FontWeight.w700,
            ),
          )
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';

class CurrencyCard extends StatelessWidget {

  final String name, code, amount;
  final IconData icon;
  final bool isInverted;

  final Color _blackColor = const Color(0xFF1F2123);

  const CurrencyCard({super.key, required this.name, required this.code, required this.amount, required this.icon, required this.isInverted});


  @override
  Widget build(BuildContext context) {
    return Container(
      // 위젯 크기를 넘어가는 영역을 자르기
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        color: isInverted ? Colors.white : Color(0xFF1F2123) ,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.all(30),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name,
                    style: TextStyle(
                        color: isInverted ? _blackColor : Colors.white,
                        fontSize: 32,
                        fontWeight: FontWeight.w600)),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Text(
                      amount,
                      style: TextStyle(
                          color: isInverted ? _blackColor : Colors.white, fontSize: 20),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      code,
                      style: TextStyle(
                          color: isInverted ? _blackColor : Colors.white.withOpacity(0.8),
                          fontSize: 20),
                    ),
                  ],
                ),
              ],
            ),
            Column(children: [
              // 카드의 크기 변경 없이 아이콘 크기만 변경
              Transform.scale(
                scale: 2.2,
                // 아래로 움직이기(플로팅 효과)
                child: Transform.translate(
                  offset: Offset(-5, 12),
                  child: Icon(
                    icon,
                    color: isInverted ? _blackColor : Colors.white ,
                    size: 88,
                  ),
                ),
              ),
            ],
            ),
          ],
        ),
      ),
    );
  }
}

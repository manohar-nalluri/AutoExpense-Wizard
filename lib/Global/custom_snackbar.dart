
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomSnackBar extends StatelessWidget {
  final String errorMsg;
  const CustomSnackBar({
    required this.errorMsg,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
            padding: const EdgeInsets.all(16),
            height: 90,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: const Color(0xffc72c41),
            ),
            child: Row(
              children: [
                const SizedBox(
                  width: 48,
                ),
                Expanded(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Oh!',
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                    Text(
                      errorMsg,
                      style: const TextStyle(color: Colors.white, fontSize: 12),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                )),
              ],
            )),
        Positioned(
          bottom: 0,
          child: SvgPicture.asset(
            'assets/bubbles.svg',
            height: 48,
            width: 40,
          ),
        ),
        Positioned(
            top: -20,
            left: 0,
            child: Stack(
              alignment: Alignment.center,
              children: [
                SvgPicture.asset(
                  'assets/fail.svg',
                  height: 40,
                ),
                Positioned(
                    top: 10,
                    child: SvgPicture.asset('assets/close.svg', height: 16)),
              ],
            ))
      ],
    );
  }
}

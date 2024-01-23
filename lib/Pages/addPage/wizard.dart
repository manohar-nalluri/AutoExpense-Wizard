import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:expense_tracker/Controller/Providers/gemini_gen_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Controller/Providers/data_display_provider.dart';
import '../../Global/card_display.dart';

class WizardData extends StatelessWidget {
  const WizardData({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    context.read<DataNotifer>().wizardEntries();
    return Column(children: [
      Expanded(
        flex: 1,
        child: SizedBox(
          width: width * 0.9,
          child: ListView.builder(
              reverse: true,
              itemCount: context.watch<DataNotifer>().wizardItemsLength,
              itemBuilder: (context, index) {
                return Consumer<DataNotifer>(builder: (build, value, child) {
                  return cardDisplay(width, value, index, true);
                });
              }),
        ),
      ),
      Container(
          width: width * 0.9,
          constraints: BoxConstraints(maxWidth: width * 0.9),
          padding: const EdgeInsets.fromLTRB(
            4,
            6,
            4,
            6,
          ),
          decoration: BoxDecoration(
              color: Colors.black, borderRadius: BorderRadius.circular(22)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CircleAvatar(
                backgroundImage: AssetImage('assets/Logos/logo.jpg'),
                radius: 34,
              ),
              const SizedBox(
                width: 6,
              ),
              Consumer<GeminiGenNotifier>(builder: (context, value, child) {
                return Expanded(
                    child: AnimatedTextKit(
                  key: ValueKey<bool>(value.castingSpellTrue),
                  animatedTexts: [
                    value.castingSpellTrue
                        ? WavyAnimatedText(value.displayWizardText,
                            textStyle: const TextStyle(
                                fontSize: 16, color: Colors.white))
                        : TyperAnimatedText(value.displayWizardText,
                            textStyle: const TextStyle(
                                fontSize: 16, color: Colors.white))
                  ],
                  isRepeatingAnimation: false,
                ));
              }),
            ],
          )),
      const SizedBox(
        height: 10,
      )
    ]);
  }
}

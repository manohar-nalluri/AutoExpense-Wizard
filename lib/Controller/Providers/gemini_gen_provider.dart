import 'dart:convert';

import 'package:expense_tracker/Controller/Providers/data_display_provider.dart';
import 'package:expense_tracker/Controller/Providers/pie_chart_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';

import '../db_terms.dart';

class GeminiGenNotifier extends ChangeNotifier {
  var data = {};
  static bool _toggle = true;
  final categoryList = [
    "Shopping",
    "Rent",
    "Food",
    "Entertainment",
    "Other Expense",
    "Utilities",
    "Groceries",
    "Fuel",
    "Travel",
    "Health",
    "Income",
  ];
  static bool _castingSpell = false;
  static final wizardText = [
    'Greetings, Wizard, seeker of financial wisdom! 🧙✨ What mystical expenses do you wish to unravel from the depths of your budgeting realm today? ',
    'Casting Spell..️',
    'Ohhh! Spell cast is Interrupted by demons TRY AGAIN!!!🪄',
    'Yoo! Wizard🧙 your Spell has been successfully casted🪄'
  ];
  var _displayWizardText = wizardText[0];
  get displayWizardText => _displayWizardText;
  get castingSpellTrue => _castingSpell;
  get toggle => _toggle;

  final request =
      "auto catergorise those text into \"Shopping\",\"Rent\",\"Food\",\"Entertainment\",\"Other Expense\", \"Utilities\",\"Groceries\",\"Fuel\",\"Travel\", \"Health\",\"Income\", based on the desiption user enters and return it in an json format only json {\"description\":extract description ,\"amount\":Extrat amount from the input,\"category\":auto categorise based on the description } so for example if user enters \"paid apartment rent 10000\" it should return it as {\"description\":\"paid apartment rent\",\"amount\":10000,\"category\":\"Rent\"} it should only return this {} and dont included words like json or any quotes enclosing them ";
  final gemini = Gemini.instance;
  setData(String userData, int selected) {
    castingSpellToggle();
    changeToogle();
    castingSpell();
    gemini
        .text(request + userData)
        .then((value) => {valueParser(value, selected)})
        .catchError((e) => {
              print(e),
              failedToCategorise(),
            });
  }

  failedToCategorise() {
    changeToogle();
    castingSpellToggle();
    spellCastFail();
  }

  valueParser(value, selected) {
    print(value?.content?.parts?.last.text);
    var apiData = value?.content?.parts?.last.text;
    Map<String, dynamic> data = json.decode(apiData);
    print(data['description']);
    try {
      if (data['description'] == 'paid apartment rent' &&
          data['amount'] == 10000) {
        failedToCategorise();
      } else if (!categoryList.contains(data['category']) ||
          (data['amount'] is! int)) {
        failedToCategorise();
      } else {
        var date = DateTime.now().toString().split(' ')[0];
        late var type;
        if (data['category'] == "Income") {
          type = "Credit";
        } else {
          type = 'Debit';
        }
        Map<String, dynamic> row = {
          DBTerms.trackerColDescription: data['description'],
          DBTerms.trackerColAmount: data['amount'],
          DBTerms.trackerColDate: date,
          DBTerms.trackerColCategory: data['category'],
          DBTerms.trackerColType: type,
          DBTerms.trackerColAI: 1,
        };
        DataNotifer().insertIntoDBAndRefresh(row, 4 + selected, DateTime.now());
        PieChartController().setMonthValues();
        if (PieChartController().selectedMonth != DateTime.now().month &&
            PieChartController().selectedYear != DateTime.now().year) {
          PieChartController().updateComplete();
        }
        changeToogle();
        castingSpellToggle();
        sucessSpellCast();
      }
    } catch (e) {
      failedToCategorise();
    }
  }

  castingSpellToggle() {
    _castingSpell = !_castingSpell;
    notifyListeners();
  }

  changeToogle() {
    _toggle = !_toggle;
    notifyListeners();
  }

  castingSpell() {
    _displayWizardText = wizardText[1];
    print(_displayWizardText);
    notifyListeners();
  }

  spellCastFail() {
    _displayWizardText = wizardText[2];
    print(_displayWizardText);
    notifyListeners();
  }

  sucessSpellCast() {
    _displayWizardText = wizardText[3];
    print(_displayWizardText);
    notifyListeners();
  }
}

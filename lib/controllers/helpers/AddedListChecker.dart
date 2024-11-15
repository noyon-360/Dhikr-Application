
import 'package:Dhikrs/controllers/providers/DhikrProvider.dart';
import 'package:Dhikrs/controllers/providers/UserSavedProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/AllahNamesProvider.dart';

class AddedListChecker {
  static List<dynamic> getAllSelectedItems(BuildContext context) {
    final dhikrProvider = Provider.of<DhikrProvider>(context, listen: false);
    final allahNamesProvider = Provider.of<AllahNamesProvider>(context, listen: false);
    final userSaveDuaProvider = Provider.of<UserSaveDuaProvider>(context, listen: false);

    final selectedNames = allahNamesProvider.getSelectedNames();
    final selectedDhikrs = dhikrProvider.getSelectedDhikrs();
    final userAddedList = userSaveDuaProvider.getSelectedSaved();

    return [...selectedNames, ...selectedDhikrs, ...userAddedList];
  }
}

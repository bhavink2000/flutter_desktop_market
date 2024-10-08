import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:marketdesktop/constant/index.dart';
import 'package:marketdesktop/modelClass/profileInfoModelClass.dart';
import 'package:marketdesktop/screens/UserDetailPopups/PositionPopUp/positionPopUpController.dart';
import 'package:marketdesktop/screens/UserDetailPopups/PositionPopUp/positionPopupWrapper.dart';
import 'package:marketdesktop/screens/UserDetailPopups/RejectionLogPopUp/rejectionLogPopUpController.dart';
import 'package:marketdesktop/screens/UserDetailPopups/RejectionLogPopUp/rejectionLogPopUpWrapper.dart';
import 'package:marketdesktop/screens/UserDetailPopups/TradeListPopUp/tradeListPopUpController.dart';
import 'package:marketdesktop/screens/UserDetailPopups/TradeListPopUp/tradeListPopUpWrapper.dart';
import 'package:marketdesktop/screens/UserDetailPopups/AccountSummaryPopUp/accountSummaryPopUpController.dart';
import 'package:marketdesktop/screens/UserDetailPopups/AccountSummaryPopUp/accountSummaryPopUpWrapper.dart';
import 'package:marketdesktop/screens/UserDetailPopups/BrkPopUp/brkPopUpController.dart';
import 'package:marketdesktop/screens/UserDetailPopups/BrkPopUp/brkPopUpWrapper.dart';
import 'package:marketdesktop/screens/UserDetailPopups/CreditPopUp/creditPopUpController.dart';
import 'package:marketdesktop/screens/UserDetailPopups/CreditPopUp/creditPopUpWrapper.dart';
import 'package:marketdesktop/screens/UserDetailPopups/GroupSettingPopUp/groupSettingPopUpController.dart';
import 'package:marketdesktop/screens/UserDetailPopups/GroupSettingPopUp/groupSettingPopUpWrapper.dart';
import 'package:marketdesktop/screens/UserDetailPopups/QuantitySettingPopUp/quantitySettingPopUpController.dart';
import 'package:marketdesktop/screens/UserDetailPopups/QuantitySettingPopUp/quantitySettingPopUpWrapper.dart';
import 'package:marketdesktop/screens/UserDetailPopups/ShareDetailPopUp/shareDetailPopUpController.dart';
import 'package:marketdesktop/screens/UserDetailPopups/ShareDetailPopUp/shareDetailPopUpWrapper.dart';
import 'package:marketdesktop/screens/UserDetailPopups/UserListPopUp/userListPopUpController.dart';
import 'package:marketdesktop/screens/UserDetailPopups/UserListPopUp/userListPopUpWrapper.dart';

import '../../constant/utilities.dart';

class UserDetailsPopUpControllerBinding implements Bindings {
  @override
  void dependencies() {
    // Get.put(() => SignInController());
    Get.put(UserDetailsPopUpController());
  }
}

class UserDetailsPopUpController extends BaseController {
  //*********************************************************************** */
  // Variable Declaration
  //*********************************************************************** */

  List<String> arrUserMenuList = [];
  List<String> arrMasterMenuList = [];
  List<Widget> widgetOptions = <Widget>[];
  int selectedCurrentTab = 0;
  String selectedMenuName = "Position";
  String userName = "";
  String userId = "";
  String userRoll = "";
  ProfileInfoData? selectedUserData;
  FocusNode mainFocus = FocusNode();
  final debouncer = Debouncer(milliseconds: 300);
  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();

    Get.put(PositionPopUpController());
    Get.put(TradeListPopUpController());
    // Get.put(ScriptMasterPopUpController());
    Get.put(GroupSettingPopUpController());
    Get.put(QuantitySettingPopUpController());
    Get.put(BrkPopUpController());
    Get.put(UserListPopUpController());
    Get.put(CreditPopUpController());
    Get.put(AccountSummaryPopUpController());
    // Get.put(SettlementPopUpController());
    Get.put(RejectionLogPopUpController());
    Get.put(ShareDetailPopUpController());

    update();
  }

  deleteAllController() {
    Get.delete<UserDetailsPopUpController>();
    Get.delete<PositionPopUpController>();
    Get.delete<TradeListPopUpController>();
    Get.delete<GroupSettingPopUpController>();
    Get.delete<QuantitySettingPopUpController>();
    Get.delete<BrkPopUpController>();
    Get.delete<UserListPopUpController>();
    Get.delete<CreditPopUpController>();
    Get.delete<AccountSummaryPopUpController>();
    Get.delete<RejectionLogPopUpController>();
    Get.delete<ShareDetailPopUpController>();
  }
//*********************************************************************** */
  // Field Validation
  //*********************************************************************** */

  //*********************************************************************** */
  // Api Calls
  //*********************************************************************** */
  getUSerInfo() async {
    mainFocus.requestFocus();
    update();
    var userResponse = await service.profileInfoByUserIdCall(userId);
    if (userResponse != null) {
      if (userResponse.statusCode == 200) {
        userRoll = userResponse.data!.role!;
        selectedUserData = userResponse.data;
        if (userResponse.data!.role == UserRollList.master || userResponse.data!.role == UserRollList.admin) {
          arrMasterMenuList = [
            "Position",
            "Trades",
            "Group Settings",
            "Quantity Settings",
            "Brk",
            "Credit",
            "User List",
            "Account Summary",
            "Rejection Log",
            "Share Details"
          ];

          widgetOptions.add(const PositionPopUpScreen());
          widgetOptions.add(const TradeListPopUpScreen());
          widgetOptions.add(const GroupSettingPopUpScreen());
          widgetOptions.add(const QuantitySettingPopUpScreen());
          widgetOptions.add(const BrkPopUpScreen());
          widgetOptions.add(const CreditPopUpScreen());
          widgetOptions.add(const UserListPopUpScreen());
          widgetOptions.add(const AccountSummaryPopUpScreen());
          widgetOptions.add(const RejectionLogPopUpScreen());
          widgetOptions.add(const ShareDetailPopUpScreen());
        } else {
          arrUserMenuList = [
            "Position",
            "Trades",
            "Group Settings",
            "Quantity Settings",
            "Brk",
            "Credit",
            "Account Summary",
            "Rejection Log",
          ];
        }

        widgetOptions.add(const PositionPopUpScreen());
        widgetOptions.add(const TradeListPopUpScreen());
        widgetOptions.add(const GroupSettingPopUpScreen());
        widgetOptions.add(const QuantitySettingPopUpScreen());
        widgetOptions.add(const BrkPopUpScreen());
        widgetOptions.add(const CreditPopUpScreen());
        widgetOptions.add(const AccountSummaryPopUpScreen());
        widgetOptions.add(const RejectionLogPopUpScreen());
        widgetOptions.add(const ShareDetailPopUpScreen());
      }

      update();
    }
  }

  KeyEventResult handleKeyEvent(FocusNode node, RawKeyEvent event) {
    if (event.logicalKey.keyLabel == "Escape") {
      debouncer.run(() async {
        Get.back();
        Get.delete<UserDetailsPopUpController>();
      });
    }

    //print(event.logicalKey);
    return event.logicalKey == LogicalKeyboardKey.escape ? KeyEventResult.handled : KeyEventResult.ignored;
  }

  updateUnSelectedView() {
    if (Get.isRegistered<UserDetailsPopUpController>()) {
      Get.find<UserDetailsPopUpController>().update();
    }
    if (Get.isRegistered<PositionPopUpController>()) {
      Get.find<PositionPopUpController>().update();
    }
    if (Get.isRegistered<TradeListPopUpController>()) {
      Get.find<TradeListPopUpController>().update();
    }
    if (Get.isRegistered<GroupSettingPopUpController>()) {
      Get.find<GroupSettingPopUpController>().update();
    }
    if (Get.isRegistered<QuantitySettingPopUpController>()) {
      Get.find<QuantitySettingPopUpController>().update();
    }
    if (Get.isRegistered<BrkPopUpController>()) {
      Get.find<BrkPopUpController>().update();
    }
    if (Get.isRegistered<UserListPopUpController>()) {
      Get.find<UserListPopUpController>().update();
    }
    if (Get.isRegistered<CreditPopUpController>()) {
      Get.find<CreditPopUpController>().update();
    }
    if (Get.isRegistered<AccountSummaryPopUpController>()) {
      Get.find<AccountSummaryPopUpController>().update();
    }
    if (Get.isRegistered<RejectionLogPopUpController>()) {
      Get.find<RejectionLogPopUpController>().update();
    }
    if (Get.isRegistered<ShareDetailPopUpController>()) {
      Get.find<ShareDetailPopUpController>().update();
    }
  }

  updateSelectedView() {
    switch (selectedMenuName) {
      case "Position":
        {
          Get.find<PositionPopUpController>().update();
        }

        break;
      case "Trades":
        {
          Get.find<TradeListPopUpController>().update();
        }
        break;
      case "Group Settings":
        {
          Get.find<GroupSettingPopUpController>().update();
        }
        break;
      case "Quantity Settings":
        {
          Get.find<QuantitySettingPopUpController>().update();
        }
        break;
      case "Brk":
        {
          Get.find<BrkPopUpController>().update();
        }
        break;
      case "Credit":
        {
          Get.find<CreditPopUpController>().update();
        }
        break;
      case "User List":
        {
          Get.find<UserListPopUpController>().update();
        }
        break;
      case "Account Summary":
        {
          Get.find<AccountSummaryPopUpController>().update();
        }
        break;
      case "Rejection Log":
        {
          Get.find<RejectionLogPopUpController>().update();
        }
        break;
      case "Share Details":
        {
          Get.find<ShareDetailPopUpController>().update();
        }
        break;

      default:
    }
  }
}

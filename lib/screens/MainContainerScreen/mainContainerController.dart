import 'dart:async';

import 'package:flutter/services.dart';
import 'package:marketdesktop/constant/utilities.dart';
import 'package:marketdesktop/main.dart';
import 'package:marketdesktop/screens/MainTabs/DashboardTab/dashboardController.dart';
import 'package:marketdesktop/screens/MainTabs/DashboardTab/dashboardWrapper.dart';
import 'package:marketdesktop/screens/MainTabs/ReportTab/AccountSummaryScreen/accountSummaryController.dart';
import 'package:marketdesktop/screens/MainTabs/ReportTab/BillGenerateScreen/billGenerateController.dart';
import 'package:marketdesktop/screens/MainTabs/ReportTab/ClientAccountReportScreen/clientAccountReportController.dart';
import 'package:marketdesktop/screens/MainTabs/ReportTab/LogHistoryScreen/logHistoryController.dart';
import 'package:marketdesktop/screens/MainTabs/ReportTab/LogsHistoryNewScreen/logsHistoryNewController.dart';
import 'package:marketdesktop/screens/MainTabs/ReportTab/ManageTradeScreen/manageTradeController.dart';
import 'package:marketdesktop/screens/MainTabs/ReportTab/OpenPositionScreen/openPositionController.dart';
import 'package:marketdesktop/screens/MainTabs/ReportTab/PercentOpenPositionScreen/percentOpenPositionController.dart';
import 'package:marketdesktop/screens/MainTabs/ReportTab/ProfitAndLossSummaryScreen/profitAndLossSummaryController.dart';
import 'package:marketdesktop/screens/MainTabs/ReportTab/ScriptMasterScreen/scriptMasterController.dart';
import 'package:marketdesktop/screens/MainTabs/ReportTab/SettelmentScreen/settelmentController.dart';
import 'package:marketdesktop/screens/MainTabs/ReportTab/SymbolWisePositionReportScreen/symbolWisePositionReportController.dart';
import 'package:marketdesktop/screens/MainTabs/ReportTab/TradeAccountScreen/tradeAccountController.dart';
import 'package:marketdesktop/screens/MainTabs/ReportTab/TradeLogScreen/tradeLogController.dart';
import 'package:marketdesktop/screens/MainTabs/ReportTab/TradeMarginScreen/tradeMarginListController.dart';
import 'package:marketdesktop/screens/MainTabs/ReportTab/UserScriptPositionTrackScreen/userScriptPositionTrackController.dart';
import 'package:marketdesktop/screens/MainTabs/ReportTab/UserWisePLSummaryScreen/userWisePLSummaryController.dart';
import 'package:marketdesktop/screens/MainTabs/ReportTab/WeeklyAdminScreen/weeklyAdminController.dart';
import 'package:marketdesktop/screens/MainTabs/SettingsTab/notificationSettingController.dart';
import 'package:marketdesktop/screens/MainTabs/ToolsTab/messagesController.dart';
import 'package:marketdesktop/screens/MainTabs/UserTab/UserListScreen/userListController.dart';
import 'package:marketdesktop/screens/MainTabs/UserTab/UserListScreen/userListWrapper.dart';
import 'package:marketdesktop/screens/MainTabs/ViewTab/LoginHistoryScreen/loginHistoryController.dart';
import 'package:marketdesktop/screens/MainTabs/ViewTab/M2mProfitAndLossScreen/m2mProfitAndLossController.dart';
import 'package:marketdesktop/screens/MainTabs/ViewTab/ManualOrderscreen/manualOrderController.dart';
import 'package:marketdesktop/screens/MainTabs/ViewTab/MarketWatchScreen/marketWatchController.dart';
import 'package:marketdesktop/screens/MainTabs/ViewTab/MarketWatchScreen/marketWatchWrapper.dart';
import 'package:marketdesktop/screens/MainTabs/ViewTab/PositionScreen/positionScreenController.dart';
import 'package:marketdesktop/screens/MainTabs/ViewTab/ProfitAndLossScreen/profitAndLossController.dart';
import 'package:marketdesktop/screens/MainTabs/ViewTab/RejectionLogScreen/rejectionLogController.dart';
import 'package:marketdesktop/screens/MainTabs/ViewTab/TradeScreen/successTradeListController.dart';
import 'package:marketdesktop/screens/MainTabs/ViewTab/TradeScreen/tradeListController.dart';
import 'package:marketdesktop/screens/UserDetailPopups/SuperAdminTradePopUp/superAdminTradePopUpController.dart';
import '../../constant/index.dart';
import 'package:get/get.dart';
import 'package:window_manager/window_manager.dart';
import '../../modelClass/getScriptFromSocket.dart';
import '../MainTabs/UserTab/CreateUserScreen/createUserController.dart';

class MainContainerControllerBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MainContainerController());
  }
}

class MainContainerController extends BaseController {
  //*********************************************************************** */
  // Variable Declaration
  //*********************************************************************** */
  ScrollController listcontroller = ScrollController();
  bool isTotalViewExpanded = false;
  TextEditingController textController = TextEditingController();
  FocusNode textFocus = FocusNode();

  int? selectedTab;

  List<String> arrAdditionMenu = [];
  List<String> arrTotalTabs = [
    "Market Watch",
    "Orders",
    "Trades",
    "Positions",
    "Create User",
    "User List",
    "Manual Order",
    "Profit & Loss",
    "M2M Profit & Loss",
    "Rejection Log",
    "Login History",
    "Open Position",
    "Manage Trades",
    "Trade Account",
    "Trade Margin",
    "Trade Logs",
    "Settlement",
    "Account Summary",
    "Symbol Wise Position Report"
        "Bill Generate",
    "% Open Position",
    "Weekly Admin",
    "Logs History",
    "Script Master",
    "P&L Summary",
    "User Logs New",
    "Userwise P&L Summary",
    "User Script Position Tracking",
    "Messages",
    "Dashboard",
    "Account Report",
  ];
  List<String> arrAvailableTabs = [];
  String selectedCurrentTab = "";
  int selectedCurrentTabIndex = -1;
  bool isCreateUserClick = false;
  bool isNotificationSettingClick = false;
  bool isStatusBarVisible = true;
  bool isToolBarVisible = false;
  final FocusNode focusNode = FocusNode();
  List<Widget> widgetOptions = <Widget>[];
  List<BaseController> arrAvailableController = [];
  bool isKeyPressActive = false;
  final debouncer = Debouncer(milliseconds: 300);
  RxDouble? pl;

  @override
  void onInit() async {
    if (userData?.role == UserRollList.user || userData?.role == UserRollList.broker) {
      arrAdditionMenu = [
        AppImages.watchIcon,
        AppImages.addYellowIcon,
        AppImages.addRedIcon,
        AppImages.marketIcon,
      ];
    } else {
      arrAdditionMenu = [AppImages.watchIcon, AppImages.addYellowIcon, AppImages.addRedIcon, AppImages.marketIcon, AppImages.userAddIcon, AppImages.searchColorIcon];
    }

    super.onInit();
    // focusNode.requestFocus();
    Get.put(CreateUserController());
    Get.put(NotificationSettingsController());
    // Size screenSize = WidgetsBinding.instance.platformDispatcher.displays.first.size;

    // await windowManager.setMinimizable(true);
    // await windowManager.setMaximizable(true);
    // await windowManager
    //     .setMinimumSize(Size(screenSize.width != 0 ? screenSize.width : 1920, screenSize.height != 0 ? screenSize.height : 1080));

    await windowManager.setMinimumSize(Size(1280, 800));

    // await windowManager
    //     .setMaximumSize(Size(screenSize.width != 0 ? screenSize.width : 1920, screenSize.height != 0 ? screenSize.height : 1080));

    await windowManager.maximize();
    Timer.periodic(const Duration(seconds: 5), (timer) {
      getOwnProfile();
      getConstantLisT();
    });

    Future.delayed(const Duration(milliseconds: 100), () async {
      update();
    });
    arrAvailableTabs.insert(0, arrTotalTabs[0]);
    selectedCurrentTab = arrTotalTabs[0];
    var marketVC = Get.put(MarketWatchController());

    arrAvailableController.insert(0, marketVC);
    widgetOptions.insert(0, MarketWatchScreen());
    selectedCurrentTabIndex = widgetOptions.indexWhere(
      (element) => element is MarketWatchScreen,
    );
    marketVC.marketWatchScreenIndex = selectedCurrentTabIndex;
    // if (isKeyBoardListenerActive == false) {

    //   isKeyBoardListenerActive = true;
    // }
    RawKeyboard.instance.addListener(handleKeyBoard);

    update();
  }

  @override
  void onClose() {
    RawKeyboard.instance.removeListener(handleKeyBoard);
    super.onClose();
  }

  String setupbottomData() {
    if (userData?.role != UserRollList.user) {
      return "PL : ${pl != null ? pl!.value.toStringAsFixed(2) : userData!.profitLoss!.toStringAsFixed(2)}  | BK : ${userData!.brokerageTotal!.toStringAsFixed(2)} | BAL :  ${userData!.balance!.toStringAsFixed(2)} | CRE : ${userData!.credit!.toStringAsFixed(2)} |";
    } else {
      return "PL : ${pl != null ? pl!.value.toStringAsFixed(2) : userData!.profitLoss!.toStringAsFixed(2)}  | BAL :  ${userData!.balance!.toStringAsFixed(2)} | CRE : ${userData!.credit!.toStringAsFixed(2)} |";
    }
  }

  getConstantLisT() async {
    var response = await service.getConstantCall();
    if (response != null) {
      constantValues = response.data;
      arrStatuslist = constantValues?.status ?? [];
      arrFilterType = constantValues?.userFilterType ?? [];

      arrLeverageList = constantValues?.leverageList ?? [];
      update();
    }
  }

  getOwnProfile() async {
    var userResponse = await service.profileInfoCall();
    if (userResponse != null) {
      if (userResponse.statusCode == 200) {
        userData = userResponse.data;

        setupbottomData();
        update();
        //print("data Updated");
      }
    }
  }

  handleKeyBoard(RawKeyEvent event) {
    if (event.logicalKey.keyLabel == "Escape" && isSuperAdminPopUpOpen) {
      Get.back();
      isSuperAdminPopUpOpen = false;
      Get.delete<SuperAdminTradePopUpController>();
      return;
    }
    if (selectedCurrentTab == "Market Watch" && isCreateUserClick == false) {
      handleMarketWatchKeyEvents(event);
    } else if (selectedCurrentTab == "Positions" && isCreateUserClick == false) {
      handlePositionKeyEvent(event);
    } else {
      if (event.logicalKey.keyLabel == "Escape") {
        debouncer.run(() async {
          isKeyPressActive = true;
          update();

          if (arrAvailableController.isNotEmpty) {
            if (Get.isRegistered<TradeListController>()) {
              if (Get.find<TradeListController>().openPopUpCount != 0) {
                Get.find<TradeListController>().openPopUpCount--;
              } else {
                onKeyHite();
              }
            } else if (arrAvailableController[selectedCurrentTabIndex] is MarketWatchController == false) {
              onKeyHite();
            } else {
              Get.find<MarketWatchController>().isScripDetailOpen = false;
            }
          } else {
            if (isCreateUserClick) {
              //print(Get.find<CreateUserController>().dropdownLeveargeKey?.currentContext);
              // if (Get.find<CreateUserController>().singleDropdownKey.currentState!.context.mounted) {
              isCreateUserClick = false;
              isNotificationSettingClick = false;
              update();
              if (!arrAvailableTabs.contains("User List")) {
                arrAvailableTabs.insert(0, "User List");
                var userListVC = Get.put(UserListController());
                arrAvailableController.insert(0, userListVC);
                widgetOptions.insert(0, UserListScreen());
                selectedCurrentTabIndex = widgetOptions.indexWhere(
                  (element) => element is UserListScreen,
                );
                selectedCurrentTab = "User List";
                update();
                // }
              } else {
                selectedCurrentTabIndex = widgetOptions.indexWhere(
                  (element) => element is UserListScreen,
                );
                selectedCurrentTab = "User List";
                update();
              }
            } else {
              Get.back();
            }
          }
        });
      } else if (event.logicalKey.keyLabel == "F9") {
        debouncer.run(() async {
          var dashBoardVC = Get.find<MainContainerController>();
          if (!dashBoardVC.arrAvailableTabs.contains("Dashboard")) {
            dashBoardVC.arrAvailableTabs.insert(0, "Dashboard");
            var marketVC = Get.put(DashboardController());
            dashBoardVC.arrAvailableController.insert(0, marketVC);
            dashBoardVC.widgetOptions.insert(0, DashboardScreen());
            dashBoardVC.selectedCurrentTabIndex = dashBoardVC.widgetOptions.indexWhere(
              (element) => element is DashboardScreen,
            );
            dashBoardVC.selectedCurrentTab = "Dashboard";
            dashBoardVC.update();
          }
        });
      }
    }
  }

  onKeyHite() async {
    if (isUserDetailPopUpOpen) {
      Get.back();
      isUserDetailPopUpOpen = false;
      return;
    }
    await widgetOptions.removeAt(selectedCurrentTabIndex);
    if (arrAvailableController[selectedCurrentTabIndex] is TradeListController) {
      await Get.delete<TradeListController>();
    } else if (arrAvailableController[selectedCurrentTabIndex] is PositionController) {
      pl = null;
      update();
      await Get.delete<PositionController>();
    } else if (arrAvailableController[selectedCurrentTabIndex] is ProfitAndLossController) {
      await Get.delete<ProfitAndLossController>();
    } else if (arrAvailableController[selectedCurrentTabIndex] is UserListController) {
      await Get.delete<UserListController>();
    } else if (arrAvailableController[selectedCurrentTabIndex] is M2MProfitAndLossController) {
      await Get.delete<M2MProfitAndLossController>();
    } else if (arrAvailableController[selectedCurrentTabIndex] is RejectionLogController) {
      await Get.delete<RejectionLogController>();
    } else if (arrAvailableController[selectedCurrentTabIndex] is LoginHistoryController) {
      await Get.delete<LoginHistoryController>();
    } else if (arrAvailableController[selectedCurrentTabIndex] is OpenPositionController) {
      await Get.delete<OpenPositionController>();
    } else if (arrAvailableController[selectedCurrentTabIndex] is ManageTradeController) {
      await Get.delete<ManageTradeController>();
    } else if (arrAvailableController[selectedCurrentTabIndex] is TradeAccountController) {
      await Get.delete<TradeAccountController>();
    } else if (arrAvailableController[selectedCurrentTabIndex] is SettlementController) {
      await Get.delete<SettlementController>();
    } else if (arrAvailableController[selectedCurrentTabIndex] is AccountSummaryController) {
      await Get.delete<AccountSummaryController>();
    } else if (arrAvailableController[selectedCurrentTabIndex] is BillGenerateController) {
      await Get.delete<BillGenerateController>();
    } else if (arrAvailableController[selectedCurrentTabIndex] is PercentOpenPositionController) {
      await Get.delete<PercentOpenPositionController>();
    } else if (arrAvailableController[selectedCurrentTabIndex] is WeeklyAdminController) {
      await Get.delete<WeeklyAdminController>();
    } else if (arrAvailableController[selectedCurrentTabIndex] is LogHistoryController) {
      await Get.delete<LogHistoryController>();
    } else if (arrAvailableController[selectedCurrentTabIndex] is ScriptMasterController) {
      await Get.delete<ScriptMasterController>();
    } else if (arrAvailableController[selectedCurrentTabIndex] is ProfitAndLossSummaryController) {
      await Get.delete<ProfitAndLossSummaryController>();
    } else if (arrAvailableController[selectedCurrentTabIndex] is LogsHistoryNewController) {
      await Get.delete<LogsHistoryNewController>();
    } else if (arrAvailableController[selectedCurrentTabIndex] is UserWisePLSummaryController) {
      await Get.delete<UserWisePLSummaryController>();
    } else if (arrAvailableController[selectedCurrentTabIndex] is UserScriptPositionTrackController) {
      await Get.delete<UserScriptPositionTrackController>();
    } else if (arrAvailableController[selectedCurrentTabIndex] is MessagesController) {
      await Get.delete<MessagesController>();
    } else if (arrAvailableController[selectedCurrentTabIndex] is DashboardController) {
      await Get.delete<DashboardController>();
    } else if (arrAvailableController[selectedCurrentTabIndex] is SuccessTradeListController) {
      await Get.delete<SuccessTradeListController>();
    } else if (arrAvailableController[selectedCurrentTabIndex] is TradeLogController) {
      await Get.delete<TradeLogController>();
    } else if (arrAvailableController[selectedCurrentTabIndex] is TradeMarginController) {
      await Get.delete<TradeMarginController>();
    } else if (arrAvailableController[selectedCurrentTabIndex] is manualOrderController) {
      await Get.delete<manualOrderController>();
    } else if (arrAvailableController[selectedCurrentTabIndex] is ClientAccountReportController) {
      await Get.delete<ClientAccountReportController>();
    } else if (arrAvailableController[selectedCurrentTabIndex] is SymbolWisePositionReportController) {
      await Get.delete<SymbolWisePositionReportController>();
    }

    await arrAvailableController.removeAt(selectedCurrentTabIndex);
    await arrAvailableTabs.removeAt(selectedCurrentTabIndex);
    if (arrAvailableTabs.length > 0) {
      selectedCurrentTab = arrAvailableTabs[0];
      selectedCurrentTabIndex = 0;
      update();
      updateSelectedView();
    } else {
      update();
    }
    // if (arrAvailableController[selectedCurrentTabIndex] is MarketWatchController) {
    //   Get.find<MarketWatchController>().focusNode.requestFocus();
    // }
    isKeyPressActive = false;
    update();
  }

  handleMarketWatchKeyEvents(RawKeyEvent event) {
    // RawKeyboard.instance.addListener((event) {

    // });
    var marketVC = Get.find<MarketWatchController>();

    // if (marketVC.isBuyOpen != -1 && !event.isKeyPressed(LogicalKeyboardKey.escape)) {
    //   if (marketVC.isBuyOpen != -1 &&
    //       (event.isKeyPressed(LogicalKeyboardKey.enter) || event.isKeyPressed(LogicalKeyboardKey.numpadEnter))) {
    //     debouncer.run(() async {
    //       if (marketVC.isBuyOpen != -1) {
    //         if (userData?.role == UserRollList.user) {
    //           marketVC.initiateTrade(marketVC.isBuyOpen == 1 ? true : false);
    //         } else {
    //           marketVC.initiateManualTrade(marketVC.isBuyOpen == 1 ? true : false);
    //         }
    //       }
    //     });
    //   }
    //   return;
    // }
    if (event.isKeyPressed(LogicalKeyboardKey.f1) || event.isKeyPressed(LogicalKeyboardKey.numpadAdd)) {
      if (userData!.role == UserRollList.admin || userData!.role == UserRollList.superAdmin) {
        return;
      }
      if (marketVC.selectedScriptIndex != -1) {
        if (marketVC.isBuyOpen == -1 && marketVC.isScripDetailOpen == false) {
          var obj = marketVC.arrSymbol.firstWhereOrNull((element) => marketVC.arrScript[marketVC.selectedScriptIndex].symbol == element.symbolName);
          var exchangeObj = arrExchange.firstWhereOrNull((element) => element.exchangeId == obj!.exchangeId!);
          if (exchangeObj != null) {
            marketVC.selectedExchangeFromPopup.value = exchangeObj;
          }
          marketVC.qtyController.text = obj!.ls!.toString();
          marketVC.isValidQty = true.obs;
          if (userData?.role != UserRollList.superAdmin) {
            marketVC.priceController.text = marketVC.arrScript[marketVC.selectedScriptIndex].ask!.toString();
          }

          marketVC.selectedScriptFromPopup.value = marketVC.arrScript[marketVC.selectedScriptIndex];
          marketVC.isBuyOpen = 1;
          debouncer.run(() async {
            isKeyPressActive = true;
            // if (userData?.role == UserRollList.master && userData?.marketOrder == 1) {
            //   marketVC.adminBuySellPopupDialog(isFromBuy: true);
            // } else if (userData?.role == UserRollList.admin && userData?.manualOrder == 1) {
            //   marketVC.adminBuySellPopupDialog(isFromBuy: true);
            // } else if (userData?.role == UserRollList.user) {
            //   marketVC.buySellPopupDialog(isFromBuy: true);
            // } else if (userData?.role == UserRollList.superAdmin) {
            //   marketVC.adminBuySellPopupDialog(isFromBuy: true);
            // } else {
            //   marketVC.isBuyOpen = -1;
            // }
            marketVC.adminBuySellPopupDialog(isFromBuy: true);
            Future.delayed(Duration(milliseconds: 100), () {});
          });
        }
      }
    } else if (event.isKeyPressed(LogicalKeyboardKey.f2) || event.isKeyPressed(LogicalKeyboardKey.numpadSubtract)) {
      if (userData!.role == UserRollList.admin || userData!.role == UserRollList.superAdmin) {
        return;
      }
      if (marketVC.selectedScriptIndex != -1) {
        if (marketVC.isBuyOpen == -1 && marketVC.isScripDetailOpen == false) {
          var obj = marketVC.arrSymbol.firstWhereOrNull((element) => marketVC.arrScript[marketVC.selectedScriptIndex].symbol == element.symbolName);
          var exchangeObj = arrExchange.firstWhereOrNull((element) => element.exchangeId == obj!.exchangeId!);
          if (exchangeObj != null) {
            marketVC.selectedExchangeFromPopup.value = exchangeObj;
          }
          marketVC.isBuyOpen = 2;
          marketVC.qtyController.text = obj!.ls!.toString();
          marketVC.isValidQty = true.obs;
          if (userData?.role != UserRollList.superAdmin) {
            marketVC.priceController.text = marketVC.arrScript[marketVC.selectedScriptIndex].bid!.toString();
          }

          marketVC.selectedScriptFromPopup.value = marketVC.arrScript[marketVC.selectedScriptIndex];
          debouncer.run(() async {
            isKeyPressActive = true;
            // if (userData?.role == UserRollList.master && userData?.marketOrder == 1) {
            //   marketVC.adminBuySellPopupDialog(isFromBuy: false);
            // } else if (userData?.role == UserRollList.admin && userData?.manualOrder == 1) {
            //   marketVC.adminBuySellPopupDialog(isFromBuy: false);
            // } else if (userData?.role == UserRollList.user) {
            //   marketVC.buySellPopupDialog(isFromBuy: false);
            // } else if (userData?.role == UserRollList.superAdmin) {
            //   marketVC.adminBuySellPopupDialog(isFromBuy: false);
            // }
            // Future.delayed(Duration(milliseconds: 100), () {});
            marketVC.adminBuySellPopupDialog(isFromBuy: false);
            Future.delayed(Duration(milliseconds: 100), () {});
          });
        }
      }
    } else if (event.isKeyPressed(LogicalKeyboardKey.escape)) {
      if (marketVC.isBuyOpen != -1) {
        debouncer.run(() async {
          isKeyPressActive = true;
          marketVC.isBuyOpen = -1;
          marketVC.update();
          Get.back();
        });
      } else if (marketVC.isScripDetailOpen) {
        debouncer.run(() async {
          isKeyPressActive = true;
          marketVC.isScripDetailOpen = false;
          marketVC.update();
          Get.back();
        });
      }
    } else if (event.isKeyPressed(LogicalKeyboardKey.f5)) {
      if (marketVC.isBuyOpen == -1) {
        if (marketVC.selectedScriptIndex != -1 && marketVC.isScripDetailOpen == false) {
          marketVC.isScripDetailOpen = true;
          marketVC.selectedExchangeForF5.value = marketVC.arrExchange.firstWhere((element) => element.exchangeId == marketVC.selectedSymbol!.exchangeId);
          marketVC.getScriptList(isFromF5: true);

          showScriptDetailPopUp();
          marketVC.update();
        }
      }
    }
    // else if (event.isKeyPressed(LogicalKeyboardKey.enter) || event.isKeyPressed(LogicalKeyboardKey.numpadEnter)) {
    //   debouncer.run(() async {
    //     if (marketVC.isBuyOpen != -1) {
    //       if (userData?.role == UserRollList.user) {
    //         marketVC.initiateTrade(marketVC.isBuyOpen == 1 ? true : false);
    //       } else {
    //         marketVC.initiateManualTrade(marketVC.isBuyOpen == 1 ? true : false);
    //       }
    //     }
    //   });
    // }
    else if (event.isKeyPressed(LogicalKeyboardKey.delete)) {
      if (marketVC.selectedScriptIndex != -1 && marketVC.isScripDetailOpen == false) {
        marketVC.isFilterClicked = 0;
        if (marketVC.arrScript[marketVC.selectedScriptIndex].symbol != "") {
          var selectedScriptObj = marketVC.arrScript[marketVC.selectedScriptIndex];
          var temp = marketVC.arrSymbol.firstWhereOrNull((value) => value.symbolName == selectedScriptObj.symbol);
          if (temp != null) {
            marketVC.deleteSymbolFromTab(temp.userTabSymbolId!);
          }
        } else {
          marketVC.isFilterClicked = 0;
          marketVC.arrScript.removeAt(marketVC.selectedScriptIndex);
          marketVC.arrPreScript.removeAt(marketVC.selectedScriptIndex);
          // selectedScriptIndex = selectedScriptIndex + 1;
          marketVC.update();
        }
      }
    } else if (event.isKeyPressed(LogicalKeyboardKey.space)) {
      if (marketVC.isBuyOpen == -1) {
        if (marketVC.selectedScriptIndex != -1 && marketVC.isScripDetailOpen == false) {
          marketVC.arrScript.insert(marketVC.selectedScriptIndex + 1, ScriptData());
          marketVC.arrPreScript.insert(marketVC.selectedScriptIndex + 1, ScriptData());
          // selectedScriptIndex = -1;
          marketVC.isFilterClicked = 0;
          marketVC.update();
        }
      }
    } else if (event.isKeyPressed(LogicalKeyboardKey.arrowDown)) {
      if (marketVC.isBuyOpen == -1 && marketVC.isScripDetailOpen == false) {
        if (marketVC.selectedScriptIndex != marketVC.arrScript.length - 1) {
          marketVC.selectedScriptIndex = marketVC.selectedScriptIndex + 1;
          focusNode.requestFocus();

          marketVC.selectedScript.value!.copyObject(ScriptData.fromJson(marketVC.arrScript[marketVC.selectedScriptIndex].toJson()));
          marketVC.selectedScriptForF5.value!.copyObject(ScriptData.fromJson(marketVC.arrScript[marketVC.selectedScriptIndex].toJson()));
          marketVC.scrollToIndex(marketVC.selectedScriptIndex);
          // marketVC.update();
          var indexOfSymbol = marketVC.arrSymbol.indexWhere((element) => marketVC.arrScript[marketVC.selectedScriptIndex].symbol == element.symbolName);
          if (indexOfSymbol != -1) {
            marketVC.selectedSymbol = marketVC.arrSymbol[indexOfSymbol];
            marketVC.update();
          }
        }
        //  else if (marketVC.selectedScriptIndex == marketVC.arrScript.length - 1) {
        //   marketVC.selectedScriptIndex = 0;
        //   marketVC.scrollToIndex(marketVC.selectedScriptIndex);
        //   // marketVC.update();
        // }
      }
    } else if (event.isKeyPressed(LogicalKeyboardKey.arrowUp)) {
      if (marketVC.isBuyOpen == -1 && marketVC.isScripDetailOpen == false) {
        if (marketVC.selectedScriptIndex > 0) {
          marketVC.selectedScriptIndex = marketVC.selectedScriptIndex - 1;
          focusNode.requestFocus();

          marketVC.selectedScript.value!.copyObject(ScriptData.fromJson(marketVC.arrScript[marketVC.selectedScriptIndex].toJson()));
          marketVC.selectedScriptForF5.value!.copyObject(ScriptData.fromJson(marketVC.arrScript[marketVC.selectedScriptIndex].toJson()));
          marketVC.upScrollToIndex(marketVC.selectedScriptIndex);
          marketVC.update();
          var indexOfSymbol = marketVC.arrSymbol.indexWhere((element) => marketVC.arrScript[marketVC.selectedScriptIndex].symbol == element.symbolName);
          if (indexOfSymbol != -1) {
            marketVC.selectedSymbol = marketVC.arrSymbol[indexOfSymbol];
            marketVC.update();
          }
        }
        // else if (marketVC.selectedScriptIndex == 0) {
        //   marketVC.selectedScriptIndex = marketVC.arrScript.length - 1;
        //   marketVC.scrollToIndex(marketVC.selectedScriptIndex);
        //   marketVC.update();
        // }
      }
    }
  }

  handlePositionKeyEvent(RawKeyEvent event) {
    var positionVc = Get.find<PositionController>();

    if (event.isKeyPressed(LogicalKeyboardKey.f1) || event.isKeyPressed(LogicalKeyboardKey.numpadAdd)) {
      if (userData!.role != UserRollList.user) {
        return;
      }
      if (positionVc.selectedScriptIndex != -1) {
        if (positionVc.isBuyOpen == -1) {
          positionVc.isBuyOpen = 1;
          positionVc.qtyController.text = positionVc.arrPositionScriptList[positionVc.selectedScriptIndex].lotSize!.toString();
          positionVc.priceController.text = positionVc.arrPositionScriptList[positionVc.selectedScriptIndex].scriptDataFromSocket.value.bid.toString();
          positionVc.symbolController.text = positionVc.arrPositionScriptList[positionVc.selectedScriptIndex].symbolName ?? "";
          positionVc.exchangeController.text = positionVc.arrPositionScriptList[positionVc.selectedScriptIndex].exchangeName ?? "";
          positionVc.isValidQty = true.obs;
          debouncer.run(() async {
            isKeyPressActive = true;
            if (userData?.role == UserRollList.master && userData?.marketOrder == 1) {
              positionVc.popUpfocusNode.requestFocus();
              positionVc.adminBuySellPopupDialog(isFromBuy: true);
            } else if (userData?.role == UserRollList.admin && userData?.manualOrder == 1) {
              positionVc.popUpfocusNode.requestFocus();
              positionVc.adminBuySellPopupDialog(isFromBuy: true);
            } else if (userData?.role == UserRollList.user) {
              positionVc.buySellPopupDialog(isFromBuy: true);
            } else if (userData?.role == UserRollList.superAdmin) {
              positionVc.popUpfocusNode.requestFocus();
              positionVc.adminBuySellPopupDialog(isFromBuy: true);
            } else {
              positionVc.isBuyOpen = -1;
            }

            Future.delayed(Duration(milliseconds: 100), () {
              positionVc.popUpfocusNode.requestFocus();
            });
          });
        }
      }
    } else if (event.isKeyPressed(LogicalKeyboardKey.f2) || event.isKeyPressed(LogicalKeyboardKey.numpadSubtract)) {
      if (userData!.role != UserRollList.user) {
        return;
      }
      if (positionVc.selectedScriptIndex != -1) {
        if (positionVc.isBuyOpen == -1) {
          positionVc.isBuyOpen = 2;
          positionVc.qtyController.text = positionVc.arrPositionScriptList[positionVc.selectedScriptIndex].lotSize!.toString();
          positionVc.priceController.text = positionVc.arrPositionScriptList[positionVc.selectedScriptIndex].scriptDataFromSocket.value.bid.toString();
          positionVc.symbolController.text = positionVc.arrPositionScriptList[positionVc.selectedScriptIndex].symbolName ?? "";
          positionVc.exchangeController.text = positionVc.arrPositionScriptList[positionVc.selectedScriptIndex].exchangeName ?? "";
          positionVc.isValidQty = true.obs;
          debouncer.run(() async {
            isKeyPressActive = true;

            if (userData?.role == UserRollList.master && userData?.marketOrder == 1) {
              positionVc.adminBuySellPopupDialog(isFromBuy: false);
            } else if (userData?.role == UserRollList.admin && userData?.manualOrder == 1) {
              positionVc.adminBuySellPopupDialog(isFromBuy: false);
            } else if (userData?.role == UserRollList.user) {
              positionVc.buySellPopupDialog(isFromBuy: false);
            } else if (userData?.role == UserRollList.superAdmin) {
              positionVc.popUpfocusNode.requestFocus();
              positionVc.adminBuySellPopupDialog(isFromBuy: false);
            }
            Future.delayed(Duration(milliseconds: 100), () {
              positionVc.popUpfocusNode.requestFocus();
            });
          });
        }
      }
    } else if (event.logicalKey.keyLabel == "Escape") {
      if (positionVc.isBuyOpen == -1) {
        debouncer.run(() async {
          if (arrAvailableController[selectedCurrentTabIndex] is MarketWatchController == false) {
            onKeyHite();
          }
        });
      } else {
        debouncer.run(() async {
          isKeyPressActive = true;
          positionVc.update();
          positionVc.isBuyOpen = -1;
          Get.back();
        });
      }
    } else if (event.isKeyPressed(LogicalKeyboardKey.arrowDown)) {
      if (positionVc.isBuyOpen != -1) {
        return;
      }
      if (positionVc.selectedScriptIndex != positionVc.arrPositionScriptList.length - 1) {
        positionVc.selectedScriptIndex = positionVc.selectedScriptIndex + 1;
        // selectedScript!.value = arrPositionScriptList[selectedScriptIndex];

        positionVc.update();
      }
    } else if (event.isKeyPressed(LogicalKeyboardKey.arrowUp)) {
      if (positionVc.isBuyOpen != -1) {
        return;
      }
      if (positionVc.selectedScriptIndex > 0) {
        positionVc.selectedScriptIndex = positionVc.selectedScriptIndex - 1;
        // selectedScript!.value = arrPositionScriptList[selectedScriptIndex];

        positionVc.update();
      }
    }

    //print(event.logicalKey);
    return KeyEventResult.handled;
  }

  updateUnSelectedView() {
    if (Get.isRegistered<MarketWatchController>()) {
      Get.find<MarketWatchController>().update();
    }
    if (Get.isRegistered<TradeListController>()) {
      Get.find<TradeListController>().update();
    }
    if (Get.isRegistered<SuccessTradeListController>()) {
      Get.find<SuccessTradeListController>().update();
    }
    if (Get.isRegistered<PositionController>()) {
      Get.find<PositionController>().update();
    }
    // if (Get.isRegistered<CreateUserController>()) {
    //   Get.find<CreateUserController>().update();
    // }
    if (Get.isRegistered<UserListController>()) {
      Get.find<UserListController>().update();
    }
    if (Get.isRegistered<ProfitAndLossController>()) {
      Get.find<ProfitAndLossController>().update();
    }
    if (Get.isRegistered<M2MProfitAndLossController>()) {
      Get.find<M2MProfitAndLossController>().update();
    }
    if (Get.isRegistered<RejectionLogController>()) {
      Get.find<RejectionLogController>().update();
    }
    if (Get.isRegistered<LoginHistoryController>()) {
      Get.find<LoginHistoryController>().update();
    }
    if (Get.isRegistered<OpenPositionController>()) {
      Get.find<OpenPositionController>().update();
    }
    if (Get.isRegistered<ManageTradeController>()) {
      Get.find<ManageTradeController>().update();
    }
    if (Get.isRegistered<TradeAccountController>()) {
      Get.find<TradeAccountController>().update();
    }
    if (Get.isRegistered<TradeMarginController>()) {
      Get.find<TradeMarginController>().update();
    }
    if (Get.isRegistered<SettlementController>()) {
      Get.find<SettlementController>().update();
    }
    if (Get.isRegistered<AccountSummaryController>()) {
      Get.find<AccountSummaryController>().update();
    }
    if (Get.isRegistered<BillGenerateController>()) {
      Get.find<BillGenerateController>().update();
    }
    if (Get.isRegistered<WeeklyAdminController>()) {
      Get.find<WeeklyAdminController>().update();
    }
    if (Get.isRegistered<LogHistoryController>()) {
      Get.find<LogHistoryController>().update();
    }
    if (Get.isRegistered<ScriptMasterController>()) {
      Get.find<ScriptMasterController>().update();
    }
    if (Get.isRegistered<ProfitAndLossSummaryController>()) {
      Get.find<ProfitAndLossSummaryController>().update();
    }
    if (Get.isRegistered<LogsHistoryNewController>()) {
      Get.find<LogsHistoryNewController>().update();
    }
    if (Get.isRegistered<UserWisePLSummaryController>()) {
      Get.find<UserWisePLSummaryController>().update();
    }
    if (Get.isRegistered<UserScriptPositionTrackController>()) {
      Get.find<UserScriptPositionTrackController>().update();
    }
    if (Get.isRegistered<MessagesController>()) {
      Get.find<MessagesController>().update();
    }
    if (Get.isRegistered<DashboardController>()) {
      Get.find<DashboardController>().update();
    }
    if (Get.isRegistered<TradeLogController>()) {
      Get.find<TradeLogController>().update();
    }
    if (Get.isRegistered<ClientAccountReportController>()) {
      Get.find<ClientAccountReportController>().update();
    }
  }

  updateSelectedView() {
    switch (selectedCurrentTab) {
      case "Market Watch":
        {
          Get.find<MarketWatchController>().update();
        }

        break;

      case "Orders":
        {
          Get.find<TradeListController>().update();
        }
        break;
      case "Trades":
        {
          Get.find<SuccessTradeListController>().update();
        }
        break;
      case "Positions":
        {
          Get.find<PositionController>().update();
        }
        break;
      // case "Create User":
      //   {
      //     Get.find<CreateUserController>().update();
      //   }
      //   break;
      case "User List":
        {
          Get.find<UserListController>().update();
        }
        break;
      case "Profit & Loss":
        {
          Get.find<ProfitAndLossController>().update();
        }
        break;
      case "M2M Profit & Loss":
        {
          Get.find<M2MProfitAndLossController>().update();
        }
        break;
      case "Rejection Log":
        {
          Get.find<RejectionLogController>().update();
        }
        break;
      case "Login History":
        {
          Get.find<LoginHistoryController>().update();
        }
        break;
      case "Open Position":
        {
          Get.find<OpenPositionController>().update();
        }
        break;
      case "Manage Trades":
        {
          Get.find<ManageTradeController>().update();
        }
        break;
      case "Trade Account":
        {
          Get.find<TradeAccountController>().update();
        }
        break;
      case "Trade Account":
        {
          Get.find<SymbolWisePositionReportController>().update();
        }
        break;
      case "Trade Margin":
        {
          Get.find<TradeMarginController>().update();
        }
        break;
      case "Trade Margin":
        {
          Get.find<SymbolWisePositionReportController>().update();
        }
        break;
      case "Settlement":
        {
          Get.find<SettlementController>().update();
        }
        break;
      case "Account Summary":
        {
          Get.find<AccountSummaryController>().update();
        }
        break;
      case "Bill Generate":
        {
          Get.find<BillGenerateController>().update();
        }
        break;
      case "Weekly Admin":
        {
          Get.find<WeeklyAdminController>().update();
        }
        break;
      case "Logs History":
        {
          Get.find<LogHistoryController>().update();
        }
        break;
      case "Script Master":
        {
          Get.find<ScriptMasterController>().update();
        }
        break;
      case "P&L Summary":
        {
          Get.find<ProfitAndLossSummaryController>().update();
        }
        break;
      case "User Logs New":
        {
          Get.find<LogsHistoryNewController>().update();
        }
        break;
      case "Userwise P&L Summary":
        {
          Get.find<UserWisePLSummaryController>().update();
        }
        break;
      case "User Script Position Tracking":
        {
          Get.find<UserScriptPositionTrackController>().update();
        }
        break;
      case "Messages":
        {
          Get.find<MessagesController>().update();
        }
        break;
      case "Dashboard":
        {
          Get.find<DashboardController>().update();
        }
        break;
      case "Trade Logs":
        {
          Get.find<TradeLogController>().update();
        }
        break;
      case "Account Report":
        {
          Get.find<ClientAccountReportController>().update();
        }
        break;
      default:
    }
  }
}

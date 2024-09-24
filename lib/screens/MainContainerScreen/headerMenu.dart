import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:marketdesktop/main.dart';
import 'package:marketdesktop/navigation/routename.dart';
import 'package:marketdesktop/screens/MainTabs/DashboardTab/dashboardController.dart';
import 'package:marketdesktop/screens/MainTabs/DashboardTab/dashboardWrapper.dart';
import 'package:marketdesktop/screens/MainTabs/ReportTab/ClientAccountReportScreen/clientAccountReportController.dart';
import 'package:marketdesktop/screens/MainTabs/ReportTab/ClientAccountReportScreen/clientAccountReportWrapper.dart';
import 'package:marketdesktop/screens/MainTabs/ReportTab/SettelmentScreen/settelmentController.dart';
import 'package:marketdesktop/screens/MainTabs/ReportTab/SettelmentScreen/settelmentWrapper.dart';
import 'package:marketdesktop/screens/MainTabs/ReportTab/SymbolWisePositionReportScreen/symbolWisePositionReportController.dart';
import 'package:marketdesktop/screens/MainTabs/ReportTab/SymbolWisePositionReportScreen/symbolWisePositionReportWrapper.dart';
import 'package:marketdesktop/screens/MainTabs/ReportTab/TradeLogScreen/tradeLogController.dart';
import 'package:marketdesktop/screens/MainTabs/ReportTab/TradeLogScreen/tradeLogWrapper.dart';
import 'package:marketdesktop/screens/MainTabs/ReportTab/TradeMarginScreen/tradeMarginListController.dart';
import 'package:marketdesktop/screens/MainTabs/ReportTab/TradeMarginScreen/tradeMarginListWrapper.dart';
import 'package:marketdesktop/screens/MainTabs/ViewTab/TradeScreen/successTradeListController.dart';
import 'package:marketdesktop/screens/MainTabs/ViewTab/TradeScreen/successTradeListWrapper.dart';
import 'package:marketdesktop/screens/MainTabs/ReportTab/AccountSummaryScreen/accountSummaryController.dart';
import 'package:marketdesktop/screens/MainTabs/ReportTab/AccountSummaryScreen/accountSummaryWrapper.dart';
import 'package:marketdesktop/screens/MainTabs/ReportTab/BillGenerateScreen/billGenerateController.dart';
import 'package:marketdesktop/screens/MainTabs/ReportTab/BillGenerateScreen/billGenerateWrapper.dart';
import 'package:marketdesktop/screens/MainTabs/ReportTab/LogHistoryScreen/logHistoryController.dart';
import 'package:marketdesktop/screens/MainTabs/ReportTab/LogHistoryScreen/logHistoryWrapper.dart';
import 'package:marketdesktop/screens/MainTabs/ReportTab/LogsHistoryNewScreen/logsHistoryNewController.dart';
import 'package:marketdesktop/screens/MainTabs/ReportTab/LogsHistoryNewScreen/logsHistoryNewWrapper.dart';
import 'package:marketdesktop/screens/MainTabs/ReportTab/ManageTradeScreen/manageTradeController.dart';
import 'package:marketdesktop/screens/MainTabs/ReportTab/ManageTradeScreen/manageTradeWrapper.dart';
import 'package:marketdesktop/screens/MainTabs/ReportTab/OpenPositionScreen/openPositionController.dart';
import 'package:marketdesktop/screens/MainTabs/ReportTab/OpenPositionScreen/openPositionWrapper.dart';
import 'package:marketdesktop/screens/MainTabs/ReportTab/ProfitAndLossSummaryScreen/profitAndLossSummaryController.dart';
import 'package:marketdesktop/screens/MainTabs/ReportTab/ProfitAndLossSummaryScreen/profitAndLossSummaryWrapper.dart';
import 'package:marketdesktop/screens/MainTabs/ReportTab/ScriptMasterScreen/scriptMasterController.dart';
import 'package:marketdesktop/screens/MainTabs/ReportTab/ScriptMasterScreen/scriptMasterWrapper.dart';

import 'package:marketdesktop/screens/MainTabs/ReportTab/TradeAccountScreen/tradeAccountController.dart';
import 'package:marketdesktop/screens/MainTabs/ReportTab/TradeAccountScreen/tradeAccountWrapper.dart';
import 'package:marketdesktop/screens/MainTabs/ReportTab/UserScriptPositionTrackScreen/userScriptPositionTrackController.dart';
import 'package:marketdesktop/screens/MainTabs/ReportTab/UserScriptPositionTrackScreen/userScriptPostionTrackWrapper.dart';
import 'package:marketdesktop/screens/MainTabs/ReportTab/UserWisePLSummaryScreen/userWisePLSummaryController.dart';
import 'package:marketdesktop/screens/MainTabs/ReportTab/UserWisePLSummaryScreen/userWisePLSummaryWrapper.dart';
import 'package:marketdesktop/screens/MainTabs/ReportTab/WeeklyAdminScreen/weeklyAdminController.dart';
import 'package:marketdesktop/screens/MainTabs/ReportTab/WeeklyAdminScreen/weeklyAdminWrapper.dart';
import 'package:marketdesktop/screens/MainTabs/ToolsTab/messagesController.dart';
import 'package:marketdesktop/screens/MainTabs/ToolsTab/messagesWrapper.dart';
import 'package:marketdesktop/screens/MainTabs/UserTab/UserListScreen/userListController.dart';
import 'package:marketdesktop/screens/MainTabs/UserTab/UserListScreen/userListWrapper.dart';
import 'package:marketdesktop/screens/MainTabs/ViewTab/LoginHistoryScreen/loginHistoryController.dart';
import 'package:marketdesktop/screens/MainTabs/ViewTab/LoginHistoryScreen/loginHistoryWrapper.dart';
import 'package:marketdesktop/screens/MainTabs/ViewTab/MarketWatchScreen/marketWatchController.dart';
import 'package:marketdesktop/screens/MainTabs/ViewTab/MarketWatchScreen/marketWatchWrapper.dart';
import 'package:marketdesktop/screens/MainTabs/ViewTab/PositionScreen/positionScreenController.dart';
import 'package:marketdesktop/screens/MainTabs/ViewTab/PositionScreen/positionScreenWrapper.dart';
import 'package:marketdesktop/screens/MainTabs/ViewTab/RejectionLogScreen/rejectionLogController.dart';
import 'package:marketdesktop/screens/MainTabs/ViewTab/RejectionLogScreen/rejectionLogWrapper.dart';
import 'package:marketdesktop/screens/MainTabs/ViewTab/TradeScreen/tradeListController.dart';
import 'package:marketdesktop/screens/MainTabs/ViewTab/TradeScreen/tradeListWrapper.dart';
import 'package:window_manager/window_manager.dart';
import '../../constant/index.dart';
import 'package:marketdesktop/screens/MainContainerScreen/mainContainerController.dart';
import 'package:web_socket_channel/status.dart' as status;

import '../MainTabs/ViewTab/ManualOrderscreen/manualOrderController.dart';
import '../MainTabs/ViewTab/ManualOrderscreen/manualOrderWrapper.dart';
import '../MainTabs/ViewTab/ProfitAndLossScreen/profitAndLossController.dart';
import '../MainTabs/ViewTab/ProfitAndLossScreen/profitAndLossWrapper.dart';

class MenuEntry {
  const MenuEntry({required this.label, this.shortcut, this.onPressed, this.menuChildren}) : assert(menuChildren == null || onPressed == null, 'onPressed is ignored if menuChildren are provided');
  final String label;

  final MenuSerializableShortcut? shortcut;
  final VoidCallback? onPressed;
  final List<MenuEntry>? menuChildren;

  static List<Widget> build(List<MenuEntry> selections) {
    Widget buildSelection(MenuEntry selection) {
      if (selection.menuChildren != null) {
        return SubmenuButton(
          menuChildren: MenuEntry.build(selection.menuChildren!),
          style: selection.label != "File" ? null : ButtonStyle(minimumSize: MaterialStateProperty.all(Size(40, 48))),
          child: Text(
            selection.label,
            style: TextStyle(
              fontSize: 12,
              overflow: TextOverflow.ellipsis,
              fontFamily: CustomFonts.family1Medium,
              color: AppColors().darkText,
            ),
          ),
        );
      }
      return MenuItemButton(
          shortcut: selection.shortcut,
          style: selection.label == "Dashboard" ? null : ButtonStyle(minimumSize: MaterialStateProperty.all(Size(200, 35))),
          onPressed: selection.onPressed,
          child: Text(
            selection.label,
            style: TextStyle(
              fontSize: 12,
              overflow: TextOverflow.ellipsis,
              fontFamily: CustomFonts.family1Medium,
              color: AppColors().darkText,
            ),
          ));
    }

    return selections.map<Widget>(buildSelection).toList();
  }

  static Map<MenuSerializableShortcut, Intent> shortcuts(List<MenuEntry> selections) {
    final Map<MenuSerializableShortcut, Intent> result = <MenuSerializableShortcut, Intent>{};
    for (final MenuEntry selection in selections) {
      if (selection.menuChildren != null) {
        result.addAll(MenuEntry.shortcuts(selection.menuChildren!));
      } else {
        if (selection.shortcut != null && selection.onPressed != null) {
          result[selection.shortcut!] = VoidCallbackIntent(selection.onPressed!);
        }
      }
    }
    return result;
  }
}

ShortcutRegistryEntry? _shortcutsEntry;

class MyMenuBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Expanded(
          child: Obx(() {
            return MenuBar(
              style: MenuStyle(shadowColor: MaterialStatePropertyAll<Color>(Colors.transparent)),
              children: MenuEntry.build(_getMenus(context)),
            );
          }),
        ),
      ],
    );
  }

  List<MenuEntry> _getMenus(BuildContext context) {
    Get.put(MarketWatchController());
    var marketViewObj = Get.find<MarketWatchController>();
    final List<MenuEntry> result = <MenuEntry>[
      MenuEntry(
        label: 'File',
        menuChildren: <MenuEntry>[
          MenuEntry(
            label: isMarketSocketConnected.value ? 'Disconnect' : 'Connect',
            onPressed: () async {
              if (isMarketSocketConnected.value) {
                socket.channel?.sink.close(status.normalClosure);
                isMarketSocketConnected.value = false;
              } else {
                await socket.connectSocket();
                if (socket.arrSymbolNames.isNotEmpty) {
                  var txt = {"symbols": socket.arrSymbolNames};
                  socket.connectScript(jsonEncode(txt));
                }
              }
            },
          ),
          MenuEntry(
            label: 'About',
            onPressed: () {
              showAboutUsPopup();
            },
          ),
          MenuEntry(
            label: 'Change Password',
            onPressed: () {
              showChangePasswordPopUp();
            },
          ),
          MenuEntry(
            label: 'Logout',
            onPressed: () async {
              // GetStorage().erase();
              service.logoutCall();
              socket.arrSymbolNames.clear();
              socket.channel?.sink.close(status.normalClosure);
              socketIO.socketForTrade.emit('unsubscribe', userData!.userName);
              socketIO.socketForTrade.disconnect();
              socketIO.socketForTrade.dispose();
              // socket.channel = null;
              isMarketSocketConnected.value = false;
              CancelToken().cancel();
              isShowToastAfterLogout = true;
              await windowManager.setFullScreen(false);
              Future.delayed(Duration(seconds: 2), () {
                isShowToastAfterLogout = false;
              });
              Get.offAllNamed(RouterName.signInScreen);
            },
          ),
        ],
      ),
      // MenuEntry(
      //   label: 'Dashboard',
      //   // shortcut: const SingleActivator(LogicalKeyboardKey.f9, control: false),
      //   onPressed: () {
      //     var dashBoardVC = Get.find<MainContainerController>();
      //     dashBoardVC.isCreateUserClick = false;
      //     dashBoardVC.isNotificationSettingClick = false;
      //     dashBoardVC.update();

      //     if (!dashBoardVC.arrAvailableTabs.contains("Dashboard")) {
      //       dashBoardVC.arrAvailableTabs.insert(0, "Dashboard");
      //       var marketVC = Get.put(DashboardController());
      //       dashBoardVC.arrAvailableController.insert(0, marketVC);
      //       dashBoardVC.widgetOptions.insert(0, DashboardScreen());
      //       dashBoardVC.selectedCurrentTabIndex = dashBoardVC.widgetOptions.indexWhere(
      //         (element) => element is DashboardScreen,
      //       );
      //       dashBoardVC.selectedCurrentTab = "Dashboard";
      //       dashBoardVC.update();
      //     }
      //   },
      // ),
      MenuEntry(
        label: 'View',
        menuChildren: <MenuEntry>[
          MenuEntry(
            label: 'Market Watch',
            shortcut: const SingleActivator(LogicalKeyboardKey.keyM, control: true),
            onPressed: () {
              var dashBoardVC = Get.find<MainContainerController>();
              dashBoardVC.isCreateUserClick = false;
              dashBoardVC.isNotificationSettingClick = false;
              dashBoardVC.update();

              if (!dashBoardVC.arrAvailableTabs.contains("Market Watch")) {
                dashBoardVC.arrAvailableTabs.insert(0, "Market Watch");
                var marketVC = Get.put(MarketWatchController());
                dashBoardVC.arrAvailableController.insert(0, marketVC);
                dashBoardVC.widgetOptions.insert(0, MarketWatchScreen());
                dashBoardVC.selectedCurrentTabIndex = dashBoardVC.widgetOptions.indexWhere(
                  (element) => element is MarketWatchScreen,
                );
                dashBoardVC.selectedCurrentTab = "Market Watch";
                dashBoardVC.updateSelectedView();
                dashBoardVC.updateUnSelectedView();
                dashBoardVC.update();
              } else {
                dashBoardVC.selectedCurrentTabIndex = dashBoardVC.widgetOptions.indexWhere(
                  (element) => element is MarketWatchScreen,
                );

                dashBoardVC.selectedCurrentTab = "Market Watch";
                dashBoardVC.updateSelectedView();
                dashBoardVC.updateUnSelectedView();
                dashBoardVC.update();
              }
            },
          ),
          MenuEntry(
            label: 'Orders',
            shortcut: const SingleActivator(LogicalKeyboardKey.f3),
            onPressed: () {
              if (marketViewObj.isBuyOpen == -1) {
                var dashBoardVC = Get.find<MainContainerController>();
                dashBoardVC.isCreateUserClick = false;
                dashBoardVC.isNotificationSettingClick = false;
                dashBoardVC.update();

                if (!dashBoardVC.arrAvailableTabs.contains("Orders")) {
                  dashBoardVC.arrAvailableTabs.insert(0, "Orders");
                  var tradeVC = Get.put(TradeListController());
                  dashBoardVC.arrAvailableController.insert(0, tradeVC);
                  dashBoardVC.widgetOptions.insert(0, TradeListScreen());
                  dashBoardVC.selectedCurrentTabIndex = dashBoardVC.widgetOptions.indexWhere(
                    (element) => element is TradeListScreen,
                  );

                  dashBoardVC.selectedCurrentTab = "Orders";
                  dashBoardVC.updateSelectedView();
                  dashBoardVC.updateUnSelectedView();
                  dashBoardVC.update();
                } else {
                  dashBoardVC.selectedCurrentTabIndex = dashBoardVC.widgetOptions.indexWhere(
                    (element) => element is TradeListScreen,
                  );
                  dashBoardVC.selectedCurrentTab = "Orders";
                  dashBoardVC.updateSelectedView();
                  dashBoardVC.updateUnSelectedView();
                  dashBoardVC.update();
                }
              }
            },
          ),
          MenuEntry(
            label: 'Trades',
            shortcut: const SingleActivator(LogicalKeyboardKey.f8),
            onPressed: () {
              if (marketViewObj.isBuyOpen != -1) {
                return;
              }
              var dashBoardVC = Get.find<MainContainerController>();
              dashBoardVC.isCreateUserClick = false;
              dashBoardVC.isNotificationSettingClick = false;
              dashBoardVC.update();
              if (!dashBoardVC.arrAvailableTabs.contains("Trades")) {
                dashBoardVC.arrAvailableTabs.insert(0, "Trades");
                var tradeVC = Get.put(SuccessTradeListController());
                dashBoardVC.arrAvailableController.insert(0, tradeVC);
                dashBoardVC.widgetOptions.insert(0, SuccessTradeListScreen());
                dashBoardVC.selectedCurrentTabIndex = dashBoardVC.widgetOptions.indexWhere(
                  (element) => element is SuccessTradeListScreen,
                );
                dashBoardVC.selectedCurrentTab = "Trades";
                dashBoardVC.updateSelectedView();
                dashBoardVC.updateUnSelectedView();
                dashBoardVC.update();
              } else {
                dashBoardVC.selectedCurrentTabIndex = dashBoardVC.widgetOptions.indexWhere(
                  (element) => element is SuccessTradeListScreen,
                );
                dashBoardVC.selectedCurrentTab = "Trades";
                dashBoardVC.updateSelectedView();
                dashBoardVC.updateUnSelectedView();
                dashBoardVC.update();
              }
            },
          ),

          MenuEntry(
            label: 'Positions',
            shortcut: const SingleActivator(LogicalKeyboardKey.f6),
            onPressed: () {
              if (marketViewObj.isBuyOpen != -1) {
                return;
              }
              var dashBoardVC = Get.find<MainContainerController>();
              // dashBoardVC.isCreateUserClick = false;
              // dashBoardVC.isNotificationSettingClick = false;
              dashBoardVC.update();
              if (!dashBoardVC.arrAvailableTabs.contains("Positions")) {
                dashBoardVC.arrAvailableTabs.insert(0, "Positions");
                var positionVC = Get.put(PositionController());
                dashBoardVC.arrAvailableController.insert(0, positionVC);
                dashBoardVC.widgetOptions.insert(0, PositionScreen());
                dashBoardVC.selectedCurrentTabIndex = dashBoardVC.widgetOptions.indexWhere(
                  (element) => element is PositionScreen,
                );
                dashBoardVC.selectedCurrentTab = "Positions";
                dashBoardVC.updateSelectedView();
                dashBoardVC.updateUnSelectedView();

                dashBoardVC.update();
              } else {
                dashBoardVC.selectedCurrentTabIndex = dashBoardVC.widgetOptions.indexWhere(
                  (element) => element is PositionScreen,
                );
                dashBoardVC.selectedCurrentTab = "Positions";
                dashBoardVC.updateSelectedView();
                dashBoardVC.updateUnSelectedView();
                dashBoardVC.update();
              }
            },
          ),
          // MenuEntry(
          //   label: 'Dashboard',
          //   // shortcut: const SingleActivator(LogicalKeyboardKey.f9, control: false),
          //   onPressed: () {
          //     var dashBoardVC = Get.find<MainContainerController>();
          //     dashBoardVC.isCreateUserClick = false;
          //     dashBoardVC.isNotificationSettingClick = false;
          //     dashBoardVC.update();

          //     if (!dashBoardVC.arrAvailableTabs.contains("Dashboard")) {
          //       dashBoardVC.arrAvailableTabs.insert(0, "Dashboard");
          //       var marketVC = Get.put(DashboardController());
          //       dashBoardVC.arrAvailableController.insert(0, marketVC);
          //       dashBoardVC.widgetOptions.insert(0, DashboardScreen());
          //       dashBoardVC.selectedCurrentTabIndex = dashBoardVC.widgetOptions.indexWhere(
          //         (element) => element is DashboardScreen,
          //       );
          //       dashBoardVC.selectedCurrentTab = "Dashboard";
          //       dashBoardVC.update();
          //     }
          //   },
          // ),
          if (userData?.role != UserRollList.user && userData?.role != UserRollList.broker)
            MenuEntry(
              label: 'Profit & Loss',
              onPressed: () {
                var dashBoardVC = Get.find<MainContainerController>();
                dashBoardVC.isCreateUserClick = false;
                dashBoardVC.isNotificationSettingClick = false;
                dashBoardVC.update();
                if (!dashBoardVC.arrAvailableTabs.contains("Profit & Loss")) {
                  dashBoardVC.arrAvailableTabs.insert(0, "Profit & Loss");
                  var profitAndLossVC = Get.put(ProfitAndLossController());
                  dashBoardVC.arrAvailableController.insert(0, profitAndLossVC);
                  dashBoardVC.widgetOptions.insert(0, ProfitAndLossScreen());
                  dashBoardVC.selectedCurrentTabIndex = dashBoardVC.widgetOptions.indexWhere(
                    (element) => element is ProfitAndLossScreen,
                  );
                  dashBoardVC.selectedCurrentTab = "Profit & Loss";
                  dashBoardVC.update();
                }
              },
            ),
          // if (userData?.role != UserRollList.user &&
          //     userData?.role != UserRollList.broker)
          //   MenuEntry(
          //     label: 'M2M Profit & Loss',
          //     onPressed: () {
          //       var dashBoardVC = Get.find<MainContainerController>();
          //       dashBoardVC.isCreateUserClick = false;
          //       dashBoardVC.isNotificationSettingClick = false;
          //       dashBoardVC.update();
          //       if (!dashBoardVC.arrAvailableTabs
          //           .contains("M2M Profit & Loss")) {
          //         dashBoardVC.arrAvailableTabs.insert(0, "M2M Profit & Loss");
          //         var profitAndLossVC = Get.put(M2MProfitAndLossController());
          //         dashBoardVC.arrAvailableController.insert(0, profitAndLossVC);
          //         dashBoardVC.widgetOptions.insert(0, M2MProfitAndLossScreen());
          //         dashBoardVC.selectedCurrentTabIndex =
          //             dashBoardVC.widgetOptions.indexWhere(
          //           (element) => element is M2MProfitAndLossScreen,
          //         );
          //         dashBoardVC.selectedCurrentTab = "M2M Profit & Loss";
          //         dashBoardVC.update();
          //       } else {
          //         dashBoardVC.selectedCurrentTabIndex =
          //             dashBoardVC.widgetOptions.indexWhere(
          //           (element) => element is M2MProfitAndLossScreen,
          //         );
          //         dashBoardVC.selectedCurrentTab = "M2M Profit & Loss";
          //         dashBoardVC.update();
          //       }
          //     },
          //   ),
          MenuEntry(
            label: 'Rejection Log',
            onPressed: () {
              if (marketViewObj.isBuyOpen != -1) {
                return;
              }
              var dashBoardVC = Get.find<MainContainerController>();
              dashBoardVC.isCreateUserClick = false;
              dashBoardVC.isNotificationSettingClick = false;
              dashBoardVC.update();
              if (!dashBoardVC.arrAvailableTabs.contains("Rejection Log")) {
                dashBoardVC.arrAvailableTabs.insert(0, "Rejection Log");
                var rejectionVC = Get.put(RejectionLogController());
                dashBoardVC.arrAvailableController.insert(0, rejectionVC);
                dashBoardVC.widgetOptions.insert(0, RejectionLogScreen());
                dashBoardVC.selectedCurrentTabIndex = dashBoardVC.widgetOptions.indexWhere(
                  (element) => element is RejectionLogScreen,
                );
                dashBoardVC.selectedCurrentTab = "Rejection Log";
                dashBoardVC.updateSelectedView();
                dashBoardVC.updateUnSelectedView();
                dashBoardVC.update();
              } else {
                dashBoardVC.selectedCurrentTabIndex = dashBoardVC.widgetOptions.indexWhere(
                  (element) => element is RejectionLogScreen,
                );
                dashBoardVC.selectedCurrentTab = "Rejection Log";
                dashBoardVC.updateSelectedView();
                dashBoardVC.updateUnSelectedView();
                dashBoardVC.update();
              }
            },
          ),
          MenuEntry(
            label: 'Login History',
            onPressed: () {
              if (marketViewObj.isBuyOpen != -1) {
                return;
              }
              var dashBoardVC = Get.find<MainContainerController>();
              dashBoardVC.isCreateUserClick = false;
              dashBoardVC.isNotificationSettingClick = false;
              dashBoardVC.update();
              if (!dashBoardVC.arrAvailableTabs.contains("Login History")) {
                dashBoardVC.arrAvailableTabs.insert(0, "Login History");
                var loginHistoryVC = Get.put(LoginHistoryController());
                dashBoardVC.arrAvailableController.insert(0, loginHistoryVC);
                dashBoardVC.widgetOptions.insert(0, LoginHistoryScreen());
                dashBoardVC.selectedCurrentTabIndex = dashBoardVC.widgetOptions.indexWhere(
                  (element) => element is LoginHistoryScreen,
                );
                dashBoardVC.selectedCurrentTab = "Login History";
                dashBoardVC.updateSelectedView();
                dashBoardVC.updateUnSelectedView();
                dashBoardVC.update();
              } else {
                dashBoardVC.selectedCurrentTabIndex = dashBoardVC.widgetOptions.indexWhere(
                  (element) => element is LoginHistoryScreen,
                );
                dashBoardVC.selectedCurrentTab = "Login History";
                dashBoardVC.updateSelectedView();
                dashBoardVC.updateUnSelectedView();
                dashBoardVC.update();
              }
            },
          ),
          if (userData!.role == UserRollList.superAdmin || (userData!.role == UserRollList.admin && userData!.manualOrder == 1))
            MenuEntry(
              label: 'Manual Order',
              onPressed: () {
                var dashBoardVC = Get.find<MainContainerController>();
                dashBoardVC.isCreateUserClick = false;
                dashBoardVC.isNotificationSettingClick = false;
                dashBoardVC.update();
                if (!dashBoardVC.arrAvailableTabs.contains("Manual Order")) {
                  dashBoardVC.arrAvailableTabs.insert(0, "Manual Order");
                  var orderVC = Get.put(manualOrderController());
                  dashBoardVC.arrAvailableController.insert(0, orderVC);
                  dashBoardVC.widgetOptions.insert(0, ManualOrderScreen());
                  dashBoardVC.selectedCurrentTabIndex = dashBoardVC.widgetOptions.indexWhere(
                    (element) => element is ManualOrderScreen,
                  );
                  dashBoardVC.selectedCurrentTab = "Manual Order";
                  dashBoardVC.update();
                }
              },
            ),
        ],
      ),
      if (userData?.role != UserRollList.user && userData?.role != UserRollList.broker)
        MenuEntry(
          label: 'Users',
          menuChildren: <MenuEntry>[
            MenuEntry(
              label: 'Create User',
              onPressed: () {
                if (marketViewObj.isBuyOpen != -1) {
                  return;
                }
                var dashbaordScreen = Get.find<MainContainerController>();
                dashbaordScreen.isCreateUserClick = true;
                dashbaordScreen.isNotificationSettingClick = false;
                dashbaordScreen.widgetOptions.clear();
                dashbaordScreen.arrAvailableController.clear();
                dashbaordScreen.arrAvailableTabs.clear();
                // dashbaordScreen.updateSelectedView();
                // dashbaordScreen.updateUnSelectedView();
                dashbaordScreen.update();
              },
            ),
            MenuEntry(
              label: 'User List',
              onPressed: () {
                if (marketViewObj.isBuyOpen != -1) {
                  return;
                }
                var dashBoardVC = Get.find<MainContainerController>();
                dashBoardVC.focusNode.requestFocus();
                dashBoardVC.isCreateUserClick = false;
                dashBoardVC.isNotificationSettingClick = false;
                dashBoardVC.update();
                if (!dashBoardVC.arrAvailableTabs.contains("User List")) {
                  dashBoardVC.arrAvailableTabs.insert(0, "User List");
                  var userListVC = Get.put(UserListController());
                  dashBoardVC.arrAvailableController.insert(0, userListVC);
                  dashBoardVC.widgetOptions.insert(0, UserListScreen());
                  dashBoardVC.selectedCurrentTabIndex = dashBoardVC.widgetOptions.indexWhere(
                    (element) => element is UserListScreen,
                  );
                  dashBoardVC.selectedCurrentTab = "User List";
                  dashBoardVC.updateSelectedView();
                  dashBoardVC.updateUnSelectedView();
                  dashBoardVC.update();
                } else {
                  dashBoardVC.selectedCurrentTabIndex = dashBoardVC.widgetOptions.indexWhere(
                    (element) => element is UserListScreen,
                  );
                  dashBoardVC.selectedCurrentTab = "User List";
                  dashBoardVC.updateSelectedView();
                  dashBoardVC.updateUnSelectedView();
                  dashBoardVC.update();
                }
              },
            ),
            // MenuEntry(
            //   label: 'Search User',
            //   onPressed: () {},
            // ),
          ],
        ),
      MenuEntry(
        label: 'Report',
        menuChildren: <MenuEntry>[
          if (userData?.role != UserRollList.user && userData?.role != UserRollList.broker)
            MenuEntry(
              label: 'Open Positions',
              onPressed: () {
                if (marketViewObj.isBuyOpen != -1) {
                  return;
                }
                var dashBoardVC = Get.find<MainContainerController>();
                dashBoardVC.isCreateUserClick = false;
                dashBoardVC.isNotificationSettingClick = false;
                dashBoardVC.update();
                if (!dashBoardVC.arrAvailableTabs.contains("Open Position")) {
                  dashBoardVC.arrAvailableTabs.insert(0, "Open Position");
                  var OpenPositionyVC = Get.put(OpenPositionController());
                  dashBoardVC.arrAvailableController.insert(0, OpenPositionyVC);
                  dashBoardVC.widgetOptions.insert(0, OpenPositionScreen());
                  dashBoardVC.selectedCurrentTabIndex = dashBoardVC.widgetOptions.indexWhere(
                    (element) => element is OpenPositionScreen,
                  );
                  dashBoardVC.selectedCurrentTab = "Open Position";
                  dashBoardVC.updateSelectedView();
                  dashBoardVC.updateUnSelectedView();
                  dashBoardVC.update();
                } else {
                  dashBoardVC.selectedCurrentTabIndex = dashBoardVC.widgetOptions.indexWhere(
                    (element) => element is OpenPositionScreen,
                  );
                  dashBoardVC.selectedCurrentTab = "Open Position";
                  dashBoardVC.updateSelectedView();
                  dashBoardVC.updateUnSelectedView();
                  dashBoardVC.update();
                }
              },
            ),
          if (userData?.role != UserRollList.user && userData?.role != UserRollList.broker)
            MenuEntry(
              label: 'Manage Trades',
              onPressed: () {
                if (marketViewObj.isBuyOpen != -1) {
                  return;
                }
                var dashBoardVC = Get.find<MainContainerController>();
                dashBoardVC.isCreateUserClick = false;
                dashBoardVC.isNotificationSettingClick = false;
                dashBoardVC.update();
                if (!dashBoardVC.arrAvailableTabs.contains("Manage Trades")) {
                  dashBoardVC.arrAvailableTabs.insert(0, "Manage Trades");
                  var manageTradeVC = Get.put(ManageTradeController());
                  dashBoardVC.arrAvailableController.insert(0, manageTradeVC);
                  dashBoardVC.widgetOptions.insert(0, ManageTradeScreen());
                  dashBoardVC.selectedCurrentTabIndex = dashBoardVC.widgetOptions.indexWhere(
                    (element) => element is ManageTradeScreen,
                  );
                  dashBoardVC.selectedCurrentTab = "Manage Trades";
                  dashBoardVC.updateSelectedView();
                  dashBoardVC.updateUnSelectedView();
                  dashBoardVC.update();
                } else {
                  dashBoardVC.selectedCurrentTabIndex = dashBoardVC.widgetOptions.indexWhere(
                    (element) => element is ManageTradeScreen,
                  );
                  dashBoardVC.selectedCurrentTab = "Manage Trades";
                  dashBoardVC.updateSelectedView();
                  dashBoardVC.updateUnSelectedView();
                  dashBoardVC.update();
                }
              },
            ),
          // if (userData?.role == UserRollList.master || userData?.role == UserRollList.superAdmin)
          MenuEntry(
            label: 'Trade Logs',
            onPressed: () {
              if (marketViewObj.isBuyOpen != -1) {
                return;
              }
              var dashBoardVC = Get.find<MainContainerController>();
              dashBoardVC.isCreateUserClick = false;
              dashBoardVC.isNotificationSettingClick = false;
              dashBoardVC.update();
              if (!dashBoardVC.arrAvailableTabs.contains("Trade Logs")) {
                dashBoardVC.arrAvailableTabs.insert(0, "Trade Logs");
                var manageTradeVC = Get.put(TradeLogController());
                dashBoardVC.arrAvailableController.insert(0, manageTradeVC);
                dashBoardVC.widgetOptions.insert(0, TradeLogScreen());
                dashBoardVC.selectedCurrentTabIndex = dashBoardVC.widgetOptions.indexWhere(
                  (element) => element is TradeLogScreen,
                );
                dashBoardVC.selectedCurrentTab = "Trade Logs";
                dashBoardVC.updateSelectedView();
                dashBoardVC.updateUnSelectedView();
                dashBoardVC.update();
              } else {
                dashBoardVC.selectedCurrentTabIndex = dashBoardVC.widgetOptions.indexWhere(
                  (element) => element is TradeLogScreen,
                );
                dashBoardVC.selectedCurrentTab = "Trade Logs";
                dashBoardVC.updateSelectedView();
                dashBoardVC.updateUnSelectedView();
                dashBoardVC.update();
              }
            },
          ),
          if (userData?.role != UserRollList.user && userData?.role != UserRollList.broker)
            MenuEntry(
              label: 'Trade Account',
              onPressed: () {
                if (marketViewObj.isBuyOpen != -1) {
                  return;
                }
                var dashBoardVC = Get.find<MainContainerController>();
                dashBoardVC.isCreateUserClick = false;
                dashBoardVC.isNotificationSettingClick = false;
                dashBoardVC.update();
                if (!dashBoardVC.arrAvailableTabs.contains("Trade Account")) {
                  dashBoardVC.arrAvailableTabs.insert(0, "Trade Account");
                  var tradeAccountVC = Get.put(TradeAccountController());
                  dashBoardVC.arrAvailableController.insert(0, tradeAccountVC);
                  dashBoardVC.widgetOptions.insert(0, TradeAccountScreen());
                  dashBoardVC.selectedCurrentTabIndex = dashBoardVC.widgetOptions.indexWhere(
                    (element) => element is TradeAccountScreen,
                  );
                  dashBoardVC.selectedCurrentTab = "Trade Account";
                  dashBoardVC.updateSelectedView();
                  dashBoardVC.updateUnSelectedView();
                  dashBoardVC.update();
                } else {
                  dashBoardVC.selectedCurrentTabIndex = dashBoardVC.widgetOptions.indexWhere(
                    (element) => element is TradeAccountScreen,
                  );
                  dashBoardVC.selectedCurrentTab = "Trade Account";
                  dashBoardVC.updateSelectedView();
                  dashBoardVC.updateUnSelectedView();
                  dashBoardVC.update();
                }
              },
            ),
          MenuEntry(
            label: 'Account Report',
            onPressed: () {
              if (marketViewObj.isBuyOpen != -1) {
                return;
              }
              var dashBoardVC = Get.find<MainContainerController>();
              dashBoardVC.isCreateUserClick = false;
              dashBoardVC.isNotificationSettingClick = false;
              dashBoardVC.update();
              if (!dashBoardVC.arrAvailableTabs.contains("Account Report")) {
                dashBoardVC.arrAvailableTabs.insert(0, "Account Report");
                var tradeAccountVC = Get.put(ClientAccountReportController());
                dashBoardVC.arrAvailableController.insert(0, tradeAccountVC);
                dashBoardVC.widgetOptions.insert(0, ClientAccountReportScreen());
                dashBoardVC.selectedCurrentTabIndex = dashBoardVC.widgetOptions.indexWhere(
                  (element) => element is ClientAccountReportScreen,
                );
                dashBoardVC.selectedCurrentTab = "Account Report";
                dashBoardVC.updateSelectedView();
                dashBoardVC.updateUnSelectedView();
                dashBoardVC.update();
              } else {
                dashBoardVC.selectedCurrentTabIndex = dashBoardVC.widgetOptions.indexWhere(
                  (element) => element is ClientAccountReportScreen,
                );
                dashBoardVC.selectedCurrentTab = "Account Report";
                dashBoardVC.updateSelectedView();
                dashBoardVC.updateUnSelectedView();
                dashBoardVC.update();
              }
            },
          ),
          MenuEntry(
            label: 'Trade Margin',
            onPressed: () {
              if (marketViewObj.isBuyOpen != -1) {
                return;
              }
              var dashBoardVC = Get.find<MainContainerController>();
              dashBoardVC.isCreateUserClick = false;
              dashBoardVC.isNotificationSettingClick = false;
              dashBoardVC.update();
              if (!dashBoardVC.arrAvailableTabs.contains("Trade Margin")) {
                dashBoardVC.arrAvailableTabs.insert(0, "Trade Margin");
                var tradeAccountVC = Get.put(TradeMarginController());
                dashBoardVC.arrAvailableController.insert(0, tradeAccountVC);
                dashBoardVC.widgetOptions.insert(0, TradeMarginScreen());
                dashBoardVC.selectedCurrentTabIndex = dashBoardVC.widgetOptions.indexWhere(
                  (element) => element is TradeMarginScreen,
                );
                dashBoardVC.selectedCurrentTab = "Trade Margin";
                dashBoardVC.updateSelectedView();
                dashBoardVC.updateUnSelectedView();
                dashBoardVC.update();
              } else {
                dashBoardVC.selectedCurrentTabIndex = dashBoardVC.widgetOptions.indexWhere(
                  (element) => element is TradeMarginScreen,
                );
                dashBoardVC.selectedCurrentTab = "Trade Margin";
                dashBoardVC.updateSelectedView();
                dashBoardVC.updateUnSelectedView();
                dashBoardVC.update();
              }
            },
          ),
          if (userData?.role != UserRollList.user && userData?.role != UserRollList.broker)
            MenuEntry(
              label: 'Settlement',
              onPressed: () {
                if (marketViewObj.isBuyOpen != -1) {
                  return;
                }
                var dashBoardVC = Get.find<MainContainerController>();
                dashBoardVC.isCreateUserClick = false;
                dashBoardVC.isNotificationSettingClick = false;
                dashBoardVC.update();
                if (!dashBoardVC.arrAvailableTabs.contains("Settlement")) {
                  dashBoardVC.arrAvailableTabs.insert(0, "Settlement");
                  var SettlementVC = Get.put(SettlementController());
                  dashBoardVC.arrAvailableController.insert(0, SettlementVC);
                  dashBoardVC.widgetOptions.insert(0, SettlementScreen());
                  dashBoardVC.selectedCurrentTabIndex = dashBoardVC.widgetOptions.indexWhere(
                    (element) => element is SettlementScreen,
                  );
                  dashBoardVC.selectedCurrentTab = "Settlement";
                  dashBoardVC.updateSelectedView();
                  dashBoardVC.updateUnSelectedView();
                  dashBoardVC.update();
                } else {
                  dashBoardVC.selectedCurrentTabIndex = dashBoardVC.widgetOptions.indexWhere(
                    (element) => element is SettlementScreen,
                  );
                  dashBoardVC.selectedCurrentTab = "Settlement";
                  dashBoardVC.updateSelectedView();
                  dashBoardVC.updateUnSelectedView();
                  dashBoardVC.update();
                }
              },
            ),
          MenuEntry(
            label: 'Account Summary',
            onPressed: () {
              if (marketViewObj.isBuyOpen != -1) {
                return;
              }
              var dashBoardVC = Get.find<MainContainerController>();
              dashBoardVC.isCreateUserClick = false;
              dashBoardVC.isNotificationSettingClick = false;
              dashBoardVC.update();
              if (!dashBoardVC.arrAvailableTabs.contains("Account Summary")) {
                dashBoardVC.arrAvailableTabs.insert(0, "Account Summary");
                var accountSummaryVC = Get.put(AccountSummaryController());
                dashBoardVC.arrAvailableController.insert(0, accountSummaryVC);
                dashBoardVC.widgetOptions.insert(0, AccountSummaryScreen());
                dashBoardVC.selectedCurrentTabIndex = dashBoardVC.widgetOptions.indexWhere(
                  (element) => element is AccountSummaryScreen,
                );
                dashBoardVC.selectedCurrentTab = "Account Summary";
                dashBoardVC.updateSelectedView();
                dashBoardVC.updateUnSelectedView();
                dashBoardVC.update();
              } else {
                dashBoardVC.selectedCurrentTabIndex = dashBoardVC.widgetOptions.indexWhere(
                  (element) => element is AccountSummaryScreen,
                );
                dashBoardVC.selectedCurrentTab = "Account Summary";
                dashBoardVC.updateSelectedView();
                dashBoardVC.updateUnSelectedView();
                dashBoardVC.update();
              }
            },
          ),
          MenuEntry(
            label: 'Bill Generate',
            onPressed: () {
              if (marketViewObj.isBuyOpen != -1) {
                return;
              }
              var dashBoardVC = Get.find<MainContainerController>();
              dashBoardVC.isCreateUserClick = false;
              dashBoardVC.isNotificationSettingClick = false;
              dashBoardVC.update();
              if (!dashBoardVC.arrAvailableTabs.contains("Bill Generate")) {
                dashBoardVC.arrAvailableTabs.insert(0, "Bill Generate");
                var billGenerateVC = Get.put(BillGenerateController());
                dashBoardVC.arrAvailableController.insert(0, billGenerateVC);
                dashBoardVC.widgetOptions.insert(0, BillGenerateScreen());
                dashBoardVC.selectedCurrentTabIndex = dashBoardVC.widgetOptions.indexWhere(
                  (element) => element is BillGenerateScreen,
                );
                dashBoardVC.selectedCurrentTab = "Bill Generate";
                dashBoardVC.updateSelectedView();
                dashBoardVC.updateUnSelectedView();
                dashBoardVC.update();
              } else {
                dashBoardVC.selectedCurrentTabIndex = dashBoardVC.widgetOptions.indexWhere(
                  (element) => element is BillGenerateScreen,
                );
                dashBoardVC.selectedCurrentTab = "Bill Generate";
                dashBoardVC.updateSelectedView();
                dashBoardVC.updateUnSelectedView();
                dashBoardVC.update();
              }
            },
          ),
          // if (userData?.role != UserRollList.user && userData?.role != UserRollList.broker)
          //   MenuEntry(
          //     label: '% Open Position',
          //     onPressed: () {
          //       var dashBoardVC = Get.find<MainContainerController>();
          //       dashBoardVC.isCreateUserClick = false;
          //       dashBoardVC.isNotificationSettingClick = false;
          //       dashBoardVC.update();
          //       if (!dashBoardVC.arrAvailableTabs.contains("% Open Position")) {
          //         dashBoardVC.arrAvailableTabs.insert(0, "% Open Position");
          //         var percentOpenPositionVC = Get.put(PercentOpenPositionController());
          //         dashBoardVC.arrAvailableController.insert(0, percentOpenPositionVC);
          //         dashBoardVC.widgetOptions.insert(0, PercentOpenPositionScreen());
          //         dashBoardVC.selectedCurrentTabIndex = dashBoardVC.widgetOptions.indexWhere(
          //           (element) => element is PercentOpenPositionScreen,
          //         );
          //         dashBoardVC.selectedCurrentTab = "% Open Position";
          //         dashBoardVC.update();
          //       } else {
          //         dashBoardVC.selectedCurrentTabIndex = dashBoardVC.widgetOptions.indexWhere(
          //           (element) => element is PercentOpenPositionScreen,
          //         );
          //         dashBoardVC.selectedCurrentTab = "% Open Position";
          //         dashBoardVC.update();
          //       }
          //     },
          //   ),
          if (userData?.role != UserRollList.user && userData?.role != UserRollList.broker)
            MenuEntry(
              label: 'Weekly Admin',
              onPressed: () {
                if (marketViewObj.isBuyOpen != -1) {
                  return;
                }
                var dashBoardVC = Get.find<MainContainerController>();
                dashBoardVC.isCreateUserClick = false;
                dashBoardVC.isNotificationSettingClick = false;
                dashBoardVC.update();
                if (!dashBoardVC.arrAvailableTabs.contains("Weekly Admin")) {
                  dashBoardVC.arrAvailableTabs.insert(0, "Weekly Admin");
                  var weeklyAdminVC = Get.put(WeeklyAdminController());
                  dashBoardVC.arrAvailableController.insert(0, weeklyAdminVC);
                  dashBoardVC.widgetOptions.insert(0, WeeklyAdminScreen());
                  dashBoardVC.selectedCurrentTabIndex = dashBoardVC.widgetOptions.indexWhere(
                    (element) => element is WeeklyAdminScreen,
                  );
                  dashBoardVC.selectedCurrentTab = "Weekly Admin";
                  dashBoardVC.updateSelectedView();
                  dashBoardVC.updateUnSelectedView();
                  dashBoardVC.update();
                } else {
                  dashBoardVC.selectedCurrentTabIndex = dashBoardVC.widgetOptions.indexWhere(
                    (element) => element is WeeklyAdminScreen,
                  );
                  dashBoardVC.selectedCurrentTab = "Weekly Admin";
                  dashBoardVC.updateSelectedView();
                  dashBoardVC.updateUnSelectedView();
                  dashBoardVC.update();
                }
              },
            ),
          MenuEntry(
            label: 'Logs History',
            onPressed: () {
              if (marketViewObj.isBuyOpen != -1) {
                return;
              }
              var dashBoardVC = Get.find<MainContainerController>();
              dashBoardVC.isCreateUserClick = false;
              dashBoardVC.isNotificationSettingClick = false;
              dashBoardVC.update();
              if (!dashBoardVC.arrAvailableTabs.contains("Logs History")) {
                dashBoardVC.arrAvailableTabs.insert(0, "Logs History");
                var logHistoryVC = Get.put(LogHistoryController());
                dashBoardVC.arrAvailableController.insert(0, logHistoryVC);
                dashBoardVC.widgetOptions.insert(0, LogHistoryScreen());
                dashBoardVC.selectedCurrentTabIndex = dashBoardVC.widgetOptions.indexWhere(
                  (element) => element is LogHistoryScreen,
                );
                dashBoardVC.selectedCurrentTab = "Logs History";
                dashBoardVC.updateSelectedView();
                dashBoardVC.updateUnSelectedView();
                dashBoardVC.update();
              } else {
                dashBoardVC.selectedCurrentTabIndex = dashBoardVC.widgetOptions.indexWhere(
                  (element) => element is LogHistoryScreen,
                );
                dashBoardVC.selectedCurrentTab = "Logs History";
                dashBoardVC.updateSelectedView();
                dashBoardVC.updateUnSelectedView();
                dashBoardVC.update();
              }
            },
          ),
          if (userData?.role != UserRollList.user && userData?.role != UserRollList.broker)
            MenuEntry(
              label: 'Script Master',
              onPressed: () {
                if (marketViewObj.isBuyOpen != -1) {
                  return;
                }
                var dashBoardVC = Get.find<MainContainerController>();
                dashBoardVC.isCreateUserClick = false;
                dashBoardVC.isNotificationSettingClick = false;
                dashBoardVC.update();
                if (!dashBoardVC.arrAvailableTabs.contains("Script Master")) {
                  dashBoardVC.arrAvailableTabs.insert(0, "Script Master");
                  var scriptMasterVC = Get.put(ScriptMasterController());
                  dashBoardVC.arrAvailableController.insert(0, scriptMasterVC);
                  dashBoardVC.widgetOptions.insert(0, ScriptMasterScreen());
                  dashBoardVC.selectedCurrentTabIndex = dashBoardVC.widgetOptions.indexWhere(
                    (element) => element is ScriptMasterScreen,
                  );
                  dashBoardVC.selectedCurrentTab = "Script Master";
                  dashBoardVC.updateSelectedView();
                  dashBoardVC.updateUnSelectedView();
                  dashBoardVC.update();
                } else {
                  dashBoardVC.selectedCurrentTabIndex = dashBoardVC.widgetOptions.indexWhere(
                    (element) => element is ScriptMasterScreen,
                  );
                  dashBoardVC.selectedCurrentTab = "Script Master";
                  dashBoardVC.updateSelectedView();
                  dashBoardVC.updateUnSelectedView();
                  dashBoardVC.update();
                }
              },
            ),
          MenuEntry(
            label: 'Scriptwise P&L Summary',
            onPressed: () {
              if (marketViewObj.isBuyOpen != -1) {
                return;
              }
              var dashBoardVC = Get.find<MainContainerController>();
              dashBoardVC.isCreateUserClick = false;
              dashBoardVC.isNotificationSettingClick = false;
              dashBoardVC.update();
              if (!dashBoardVC.arrAvailableTabs.contains("P&L Summary")) {
                dashBoardVC.arrAvailableTabs.insert(0, "P&L Summary");
                var plSummaryVC = Get.put(ProfitAndLossSummaryController());
                dashBoardVC.arrAvailableController.insert(0, plSummaryVC);
                dashBoardVC.widgetOptions.insert(0, ProfitAndLossSummaryScreen());
                dashBoardVC.selectedCurrentTabIndex = dashBoardVC.widgetOptions.indexWhere(
                  (element) => element is ProfitAndLossSummaryScreen,
                );
                dashBoardVC.selectedCurrentTab = "P&L Summary";
                dashBoardVC.updateSelectedView();
                dashBoardVC.updateUnSelectedView();
                dashBoardVC.update();
              } else {
                dashBoardVC.selectedCurrentTabIndex = dashBoardVC.widgetOptions.indexWhere(
                  (element) => element is ProfitAndLossSummaryScreen,
                );
                dashBoardVC.selectedCurrentTab = "P&L Summary";
                dashBoardVC.updateSelectedView();
                dashBoardVC.updateUnSelectedView();
                dashBoardVC.update();
              }
            },
          ),
          // if (userData?.role != UserRollList.user && userData?.role != UserRollList.broker)
          //   MenuEntry(
          //     label: 'User Logs New',
          //     onPressed: () {
          //       if (marketViewObj.isBuyOpen != -1) {
          //         return;
          //       }
          //       var dashBoardVC = Get.find<MainContainerController>();
          //       dashBoardVC.isCreateUserClick = false;
          //       dashBoardVC.isNotificationSettingClick = false;
          //       dashBoardVC.update();
          //       if (!dashBoardVC.arrAvailableTabs.contains("User Logs New")) {
          //         dashBoardVC.arrAvailableTabs.insert(0, "User Logs New");
          //         var logsHistoryVC = Get.put(LogsHistoryNewController());
          //         dashBoardVC.arrAvailableController.insert(0, logsHistoryVC);
          //         dashBoardVC.widgetOptions.insert(0, LogsHistoryNewScreen());
          //         dashBoardVC.selectedCurrentTabIndex = dashBoardVC.widgetOptions.indexWhere(
          //           (element) => element is LogsHistoryNewScreen,
          //         );
          //         dashBoardVC.selectedCurrentTab = "User Logs New";
          //         dashBoardVC.updateSelectedView();
          //         dashBoardVC.updateUnSelectedView();
          //         dashBoardVC.update();
          //       } else {
          //         dashBoardVC.selectedCurrentTabIndex = dashBoardVC.widgetOptions.indexWhere(
          //           (element) => element is LogsHistoryNewScreen,
          //         );
          //         dashBoardVC.selectedCurrentTab = "User Logs New";
          //         dashBoardVC.updateSelectedView();
          //         dashBoardVC.updateUnSelectedView();
          //         dashBoardVC.update();
          //       }
          //     },
          //   ),
          if (userData?.role != UserRollList.user && userData?.role != UserRollList.broker)
            MenuEntry(
              label: 'Userwise P&L Summary',
              onPressed: () {
                if (marketViewObj.isBuyOpen != -1) {
                  return;
                }
                var dashBoardVC = Get.find<MainContainerController>();
                dashBoardVC.isCreateUserClick = false;
                dashBoardVC.isNotificationSettingClick = false;
                dashBoardVC.update();
                if (!dashBoardVC.arrAvailableTabs.contains("Userwise P&L Summary")) {
                  dashBoardVC.arrAvailableTabs.insert(0, "Userwise P&L Summary");
                  var userWisePlSummaryVC = Get.put(UserWisePLSummaryController());
                  dashBoardVC.arrAvailableController.insert(0, userWisePlSummaryVC);
                  dashBoardVC.widgetOptions.insert(0, UserWisePLSummaryScreen());
                  dashBoardVC.selectedCurrentTabIndex = dashBoardVC.widgetOptions.indexWhere(
                    (element) => element is UserWisePLSummaryScreen,
                  );
                  dashBoardVC.selectedCurrentTab = "Userwise P&L Summary";
                  dashBoardVC.updateSelectedView();
                  dashBoardVC.updateUnSelectedView();
                  dashBoardVC.update();
                } else {
                  dashBoardVC.selectedCurrentTabIndex = dashBoardVC.widgetOptions.indexWhere(
                    (element) => element is UserWisePLSummaryScreen,
                  );
                  dashBoardVC.selectedCurrentTab = "Userwise P&L Summary";
                  dashBoardVC.updateSelectedView();
                  dashBoardVC.updateUnSelectedView();
                  dashBoardVC.update();
                }
              },
            ),
          if (userData?.role != UserRollList.user && userData?.role != UserRollList.broker)
            MenuEntry(
              label: 'User Script Position Track',
              onPressed: () {
                if (marketViewObj.isBuyOpen != -1) {
                  return;
                }
                var dashBoardVC = Get.find<MainContainerController>();
                dashBoardVC.isCreateUserClick = false;
                dashBoardVC.isNotificationSettingClick = false;
                dashBoardVC.update();
                if (!dashBoardVC.arrAvailableTabs.contains("User Script Position Tracking")) {
                  dashBoardVC.arrAvailableTabs.insert(0, "User Script Position Tracking");
                  var plSummaryVC = Get.put(UserScriptPositionTrackController());
                  dashBoardVC.arrAvailableController.insert(0, plSummaryVC);
                  dashBoardVC.widgetOptions.insert(0, UserScriptPositionTrackScreen());
                  dashBoardVC.selectedCurrentTabIndex = dashBoardVC.widgetOptions.indexWhere(
                    (element) => element is UserScriptPositionTrackScreen,
                  );
                  dashBoardVC.selectedCurrentTab = "User Script Position Tracking";
                  dashBoardVC.updateSelectedView();
                  dashBoardVC.updateUnSelectedView();
                  dashBoardVC.update();
                } else {
                  dashBoardVC.selectedCurrentTabIndex = dashBoardVC.widgetOptions.indexWhere(
                    (element) => element is UserScriptPositionTrackScreen,
                  );
                  dashBoardVC.selectedCurrentTab = "User Script Position Tracking";
                  dashBoardVC.updateSelectedView();
                  dashBoardVC.updateUnSelectedView();
                  dashBoardVC.update();
                }
              },
            ),
          MenuEntry(
            label: 'Symbol Wise Position Report',
            onPressed: () {
              if (marketViewObj.isBuyOpen != -1) {
                return;
              }
              var dashBoardVC = Get.find<MainContainerController>();
              dashBoardVC.isCreateUserClick = false;
              dashBoardVC.isNotificationSettingClick = false;
              dashBoardVC.update();
              if (!dashBoardVC.arrAvailableTabs.contains("Symbol Wise Position Report")) {
                dashBoardVC.arrAvailableTabs.insert(0, "Symbol Wise Position Report");
                var plSummaryVC = Get.put(SymbolWisePositionReportController());
                dashBoardVC.arrAvailableController.insert(0, plSummaryVC);
                dashBoardVC.widgetOptions.insert(0, SymbolWisePositionReportScreen());
                dashBoardVC.selectedCurrentTabIndex = dashBoardVC.widgetOptions.indexWhere(
                  (element) => element is SymbolWisePositionReportScreen,
                );
                dashBoardVC.selectedCurrentTab = "Symbol Wise Position Report";
                dashBoardVC.updateSelectedView();
                dashBoardVC.updateUnSelectedView();
                dashBoardVC.update();
              } else {
                dashBoardVC.selectedCurrentTabIndex = dashBoardVC.widgetOptions.indexWhere(
                  (element) => element is SymbolWisePositionReportScreen,
                );
                dashBoardVC.selectedCurrentTab = "Symbol Wise Position Report";
                dashBoardVC.updateSelectedView();
                dashBoardVC.updateUnSelectedView();
                dashBoardVC.update();
              }
            },
          ),
        ],
      ),
      MenuEntry(
        label: 'Settings',
        menuChildren: <MenuEntry>[
          MenuEntry(
            label: 'Notification Alert',
            onPressed: () {
              if (marketViewObj.isBuyOpen != -1) {
                return;
              }
              var dashbaordScreen = Get.find<MainContainerController>();
              dashbaordScreen.isCreateUserClick = false;
              dashbaordScreen.isNotificationSettingClick = true;
              dashbaordScreen.update();
            },
          ),
        ],
      ),
      MenuEntry(
        label: 'Tools',
        menuChildren: <MenuEntry>[
          MenuEntry(
            label: 'Status Bar',
            onPressed: () async {
              if (marketViewObj.isBuyOpen != -1) {
                return;
              }
              var dashBoardVC = Get.find<MainContainerController>();
              dashBoardVC.isCreateUserClick = false;
              dashBoardVC.isNotificationSettingClick = false;
              dashBoardVC.update();
              dashBoardVC.isStatusBarVisible = !dashBoardVC.isStatusBarVisible;
              dashBoardVC.update();
            },
          ),
          MenuEntry(
            label: 'Tool Bar',
            onPressed: () {
              if (marketViewObj.isBuyOpen != -1) {
                return;
              }
              var dashBoardVC = Get.find<MainContainerController>();
              dashBoardVC.isCreateUserClick = false;
              dashBoardVC.isNotificationSettingClick = false;
              dashBoardVC.update();
              dashBoardVC.isToolBarVisible = !dashBoardVC.isToolBarVisible;
              dashBoardVC.update();
            },
          ),
          MenuEntry(
            label: 'Market Timings',
            onPressed: () {
              if (marketViewObj.isBuyOpen != -1) {
                return;
              }
              showMarketTimingPopup();
            },
          ),
          MenuEntry(
            label: 'Messages',
            shortcut: const SingleActivator(LogicalKeyboardKey.f10, control: false),
            onPressed: () {
              if (marketViewObj.isBuyOpen != -1) {
                return;
              }
              var dashBoardVC = Get.find<MainContainerController>();
              dashBoardVC.isCreateUserClick = false;
              dashBoardVC.isNotificationSettingClick = false;
              dashBoardVC.update();

              if (!dashBoardVC.arrAvailableTabs.contains("Messages")) {
                dashBoardVC.arrAvailableTabs.insert(0, "Messages");
                var marketVC = Get.put(MessagesController());
                dashBoardVC.arrAvailableController.insert(0, marketVC);
                dashBoardVC.widgetOptions.insert(0, MessagesScreen());
                dashBoardVC.selectedCurrentTabIndex = dashBoardVC.widgetOptions.indexWhere(
                  (element) => element is MessagesScreen,
                );
                dashBoardVC.selectedCurrentTab = "Messages";
                dashBoardVC.updateSelectedView();
                dashBoardVC.updateUnSelectedView();
                dashBoardVC.update();
              } else {
                dashBoardVC.selectedCurrentTabIndex = dashBoardVC.widgetOptions.indexWhere(
                  (element) => element is MessagesScreen,
                );
                dashBoardVC.selectedCurrentTab = "Messages";
                dashBoardVC.updateSelectedView();
                dashBoardVC.updateUnSelectedView();
                dashBoardVC.update();
              }
            },
          ),
        ],
      ),
    ];

    _shortcutsEntry?.dispose();
    _shortcutsEntry = ShortcutRegistry.of(context).addAll(MenuEntry.shortcuts(result));
    return result;
  }
}

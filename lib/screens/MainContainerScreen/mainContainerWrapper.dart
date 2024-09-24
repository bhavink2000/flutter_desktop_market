import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:marketdesktop/main.dart';
import 'package:marketdesktop/screens/MainContainerScreen/mainContainerController.dart';
import 'package:marketdesktop/screens/MainTabs/SettingsTab/notificationSettingWrapper.dart';

import 'package:marketdesktop/screens/MainTabs/UserTab/CreateUserScreen/createUserWrapper.dart';

import 'package:marketdesktop/screens/MainContainerScreen/headerMenu.dart';
import 'package:marketdesktop/screens/MainTabs/UserTab/UserListScreen/userListController.dart';
import 'package:marketdesktop/screens/MainTabs/UserTab/UserListScreen/userListWrapper.dart';
import 'package:marketdesktop/screens/MainTabs/ViewTab/PositionScreen/positionScreenController.dart';
import 'package:marketdesktop/screens/MainTabs/ViewTab/PositionScreen/positionScreenWrapper.dart';
import 'package:marketdesktop/screens/MainTabs/ViewTab/TradeScreen/successTradeListController.dart';
import 'package:marketdesktop/screens/MainTabs/ViewTab/TradeScreen/successTradeListWrapper.dart';
import 'package:marketdesktop/screens/MainTabs/ViewTab/TradeScreen/tradeListController.dart';
import 'package:marketdesktop/screens/MainTabs/ViewTab/TradeScreen/tradeListWrapper.dart';
import 'package:marquee/marquee.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../../constant/color.dart';

import '../../constant/assets.dart';
import '../../constant/font_family.dart';
import '../BaseController/baseController.dart';
import '../MainTabs/ViewTab/MarketWatchScreen/marketWatchController.dart';
import '../MainTabs/ViewTab/MarketWatchScreen/marketWatchWrapper.dart';

class MainContainerScreen extends BaseView<MainContainerController> {
  const MainContainerScreen({Key? key}) : super(key: key);

  @override
  Widget vBuilder(BuildContext context) {
    return PopScope(
        canPop: false,
        onPopInvoked: (ispop) async {
          Get.back();
          return Future.value(false);
        },
        child: Scaffold(
          backgroundColor: AppColors().headerBgColor,
          body: Column(
            children: [
              Container(
                width: 100.w,
                height: 40,
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        // width: 90.w,
                        height: 50,
                        child: MyMenuBar(),
                      ),
                    ),
                    // Spacer(),
                    Image.asset(
                      AppImages.appLogo,
                      width: 22,
                      height: 22,
                    ),
                    SizedBox(
                      width: 20,
                    )
                  ],
                ),
              ),
              Offstage(
                offstage: !controller.isToolBarVisible,
                child: Container(
                  width: 100.w,
                  height: 40,
                  child: ListView.builder(
                      physics: const ClampingScrollPhysics(),
                      clipBehavior: Clip.hardEdge,
                      itemCount: controller.arrAdditionMenu.length,
                      controller: controller.listcontroller,
                      scrollDirection: Axis.horizontal,
                      // shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return menuOptionlistContent(context, index);
                      }),
                ),
              ),
              Expanded(
                  child: Row(
                children: [
                  SizedBox(
                    width: 1.w,
                  ),
                  if (controller.isCreateUserClick)
                    Container(
                      width: 97.9.w,
                      alignment: Alignment.center,
                      // color: AppColors().slideGrayBG,
                      child: controller.isCreateUserClick ? CreateUserScreen() : SizedBox(),
                    ),
                  if (controller.isNotificationSettingClick)
                    Container(
                      width: controller.isNotificationSettingClick ? 350 : 0,
                      color: AppColors().slideGrayBG,
                      child: controller.isNotificationSettingClick ? NotificationSettingsScreen() : SizedBox(),
                    ),
                  SizedBox(
                    width: 1,
                  ),
                  Expanded(
                    flex: 7,
                    child: Column(
                      children: [
                        if (controller.arrAvailableTabs.length > 0)
                          Container(
                            // margin: EdgeInsets.symmetric(horizontal: 20),
                            child: Column(
                              children: [
                                Container(
                                  width: 100.w,
                                  height: 30,
                                  child: BouncingScrollWrapper.builder(
                                      context,
                                      ListView.builder(
                                          physics: const ClampingScrollPhysics(),
                                          clipBehavior: Clip.hardEdge,
                                          itemCount: controller.arrAvailableTabs.length,
                                          controller: controller.listcontroller,
                                          scrollDirection: Axis.horizontal,
                                          shrinkWrap: true,
                                          itemBuilder: (context, index) {
                                            return availableTablistContent(context, index);
                                          }),
                                      dragWithMouse: true),
                                ),
                                Container(
                                  width: 100.w,
                                  height: 2,
                                  color: AppColors().blueColor,
                                )
                              ],
                            ),
                          ),
                        if (controller.selectedCurrentTabIndex != -1)
                          Expanded(
                              child: IndexedStack(
                            index: controller.selectedCurrentTabIndex,
                            children: controller.widgetOptions,
                          )),
                        if (controller.selectedCurrentTabIndex == -1) Spacer(),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 1.w,
                  ),
                ],
              )),
              Offstage(
                offstage: !controller.isStatusBarVisible,
                child: advertiseContent(context),
              )
            ],
          ),
        ));
  }

  Widget advertiseContent(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 100.w,
          height: 30,
          color: AppColors().whiteColor,
          child: Row(
            children: [
              SizedBox(
                width: 12,
              ),
              Text("Username : ${userData?.userName ?? ""}, Roll : ${userData?.roleName ?? ""}", style: TextStyle(fontSize: 12, fontFamily: CustomFonts.family1SemiBold, color: AppColors().darkText)),
              Spacer(),
              Text("v1.0.0", style: TextStyle(fontSize: 12, fontFamily: CustomFonts.family1SemiBold, color: AppColors().darkText)),
              Spacer(),
              Text(controller.setupbottomData(), style: TextStyle(fontSize: 12, fontFamily: CustomFonts.family1SemiBold, color: AppColors().darkText)),
              SizedBox(
                width: 5,
              ),
              Image.asset(
                AppImages.infoGreenIcon,
                width: 20,
                height: 20,
                fit: BoxFit.cover,
              ),
              SizedBox(
                width: 12,
              ),
            ],
          ),
        ),
        Container(
          width: 100.w,
          height: 1,
          color: AppColors().lightOnlyText,
        ),
        Container(
          width: 100.w,
          height: 40,
          color: AppColors().whiteColor,
          child: Center(
            child: Marquee(text: (constantValues!.settingData?.banMessage ?? "") + "     ", style: TextStyle(fontSize: 12, fontFamily: CustomFonts.family1Medium, color: AppColors().redColor)
                // child: Text(constantValues!.settingData?.banMessage ?? "",
                //     textAlign: TextAlign.center,
                //     style: TextStyle(fontSize: 12, fontFamily: CustomFonts.family1Medium, color: AppColors().redColor)),
                ),
          ),
        ),
      ],
    );
  }

  Widget menuOptionlistContent(BuildContext context, int index) {
    return GestureDetector(
      onTap: () {
        // controller.selectedTab = index;
        // controller.update();
        controller.isCreateUserClick = false;
        controller.isNotificationSettingClick = false;
        controller.update();
        if (index != 4) {
          if (!controller.arrAvailableTabs.contains(controller.arrTotalTabs[index])) {
            controller.arrAvailableTabs.insert(0, controller.arrTotalTabs[index]);
            switch (index) {
              case 0:
                {
                  var marketVC = Get.put(MarketWatchController());
                  controller.arrAvailableController.insert(0, marketVC);
                  controller.widgetOptions.insert(0, MarketWatchScreen());
                  controller.selectedCurrentTabIndex = controller.widgetOptions.indexWhere(
                    (element) => element is MarketWatchScreen,
                  );
                  controller.update();
                  break;
                }
              case 1:
                {
                  var marketVC = Get.put(TradeListController());
                  controller.arrAvailableController.insert(0, marketVC);
                  controller.widgetOptions.insert(0, TradeListScreen());
                  controller.selectedCurrentTabIndex = controller.widgetOptions.indexWhere(
                    (element) => element is TradeListScreen,
                  );
                  controller.update();
                  break;
                }
              case 2:
                {
                  var marketVC = Get.put(SuccessTradeListController());
                  controller.arrAvailableController.insert(0, marketVC);
                  controller.widgetOptions.insert(0, SuccessTradeListScreen());
                  controller.selectedCurrentTabIndex = controller.widgetOptions.indexWhere(
                    (element) => element is SuccessTradeListScreen,
                  );
                  controller.update();
                  break;
                }
              case 3:
                {
                  var marketVC = Get.put(PositionController());
                  controller.arrAvailableController.insert(0, marketVC);
                  controller.widgetOptions.insert(0, PositionScreen());
                  controller.selectedCurrentTabIndex = controller.widgetOptions.indexWhere(
                    (element) => element is PositionScreen,
                  );
                  controller.update();
                  break;
                }
              case 5:
                {
                  var marketVC = Get.put(UserListController());
                  controller.arrAvailableController.insert(0, marketVC);
                  controller.widgetOptions.insert(0, UserListScreen());
                  controller.selectedCurrentTabIndex = controller.widgetOptions.indexWhere(
                    (element) => element is UserListScreen,
                  );
                  controller.update();
                  break;
                }

              default:
                {
                  break;
                }
            }
            controller.selectedCurrentTab = controller.arrTotalTabs[index];
            controller.update();
          }
        } else if (index == 4) {
          controller.isCreateUserClick = true;
          controller.isNotificationSettingClick = false;
          controller.widgetOptions.clear();
          controller.arrAvailableController.clear();
          controller.arrAvailableTabs.clear();

          controller.update();
        }
      },
      child: Padding(
        padding: index == 0
            ? const EdgeInsets.only(right: 0, left: 10)
            : index == controller.arrAdditionMenu.length - 1
                ? const EdgeInsets.only(left: 0)
                : const EdgeInsets.symmetric(horizontal: 0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 45,
              height: 40,
              child: Center(
                  child: Image.asset(
                controller.arrAdditionMenu[index],
                width: 20,
                height: 20,
              )),
            ),
            // Spacer(),
            Container(
              height: 15,
              width: 1,
              color: AppColors().lightOnlyText,
            )
          ],
        ),
      ),
    );
  }

  Widget availableTablistContent(BuildContext context, int index) {
    return GestureDetector(
      onTap: () {
        controller.selectedCurrentTab = controller.arrAvailableTabs[index];
        controller.selectedCurrentTabIndex = index;
        controller.update();
        controller.updateSelectedView();
        controller.updateUnSelectedView();
      },
      child: Container(
        width: controller.arrAvailableTabs[index] == "User Script Position Tracking"
            ? 240
            : controller.arrAvailableTabs[index] == "Userwise P&L Summary"
                ? 220
                : controller.arrAvailableTabs[index] == "Symbol Wise Position Report"
                    ? 240
                    : 170,
        color: controller.selectedCurrentTab == controller.arrAvailableTabs[index] ? AppColors().blueColor : Colors.transparent,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          mainAxisAlignment: controller.selectedCurrentTab == controller.arrAvailableTabs[index] ? MainAxisAlignment.center : MainAxisAlignment.start,
          children: [
            Container(
              height: 30,
              // padding:
              //     EdgeInsets.only(right: 20, left: controller.selectedCurrentTab == controller.arrAvailableTabs[index] ? 5 : 20),
              child: Center(
                child: Text(controller.arrAvailableTabs[index],
                    style: TextStyle(
                      fontSize: 12,
                      fontFamily: CustomFonts.family1Medium,
                      color: controller.selectedCurrentTab == controller.arrAvailableTabs[index] ? AppColors().whiteColor : AppColors().fontColor,
                    )),
              ),
            ),
            if (controller.selectedCurrentTab == controller.arrAvailableTabs[index]) Spacer(),
            if (controller.selectedCurrentTab == controller.arrAvailableTabs[index])
              // if (controller.arrAvailableTabs[index] != "Market Watch")
              GestureDetector(
                onTap: () async {
                  controller.onKeyHite();
                },
                child: Container(
                  width: 30,
                  height: 30,
                  padding: EdgeInsets.all(10),
                  child: Image.asset(
                    AppImages.closeIcon,
                    width: 10,
                    height: 10,
                    color: AppColors().whiteColor,
                  ),
                ),
              )
          ],
        ),
      ),
    );
  }
}

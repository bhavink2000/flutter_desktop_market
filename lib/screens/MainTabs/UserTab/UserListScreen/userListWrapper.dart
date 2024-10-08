import 'package:floating_dialog/floating_dialog.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:marketdesktop/constant/utilities.dart';
import 'package:marketdesktop/customWidgets/appButton.dart';
import 'package:marketdesktop/main.dart';
import 'package:marketdesktop/modelClass/allSymbolListModelClass.dart';
import 'package:marketdesktop/modelClass/constantModelClass.dart';
import 'package:marketdesktop/modelClass/userRoleListModelClass.dart';
import 'package:marketdesktop/screens/MainTabs/UserTab/CreateUserScreen/createUserController.dart';
import 'package:marketdesktop/screens/MainTabs/UserTab/UserListScreen/userListController.dart';
import 'package:paginable/paginable.dart';

import 'package:responsive_framework/responsive_framework.dart';
import 'package:shimmer/shimmer.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../constant/index.dart';
import '../../../MainContainerScreen/mainContainerController.dart';

class UserListScreen extends BaseView<UserListController> {
  const UserListScreen({Key? key}) : super(key: key);

  @override
  Widget vBuilder(BuildContext context) {
    return FocusTraversalGroup(
      policy: WidgetOrderTraversalPolicy(),
      child: Visibility(
        visible: Get.find<MainContainerController>().selectedCurrentTab == "User List",
        child: GestureDetector(
          onTap: () {},
          child: Row(
            children: [
              filterPanel(context, isRecordDisplay: true, totalRecord: controller.totalRecord, onCLickFilter: () {
                controller.isFilterOpen = !controller.isFilterOpen;
                controller.update();
              }),
              filterContent(context),
              Expanded(
                flex: 8,
                child: BouncingScrollWrapper.builder(context, mainContent(context), dragWithMouse: true),
                // child: BouncingScrollWrapper.builder(context, mainContent(context), dragWithMouse: true),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget filterContent(BuildContext context) {
    return FocusTraversalGroup(
      policy: WidgetOrderTraversalPolicy(),
      child: Visibility(
        visible: controller.isFilterOpen,
        child: AnimatedContainer(
          margin: EdgeInsets.only(bottom: 2.h),
          decoration: BoxDecoration(
              border: Border(
            bottom: BorderSide(color: AppColors().whiteColor, width: 1),
          )),
          width: controller.isFilterOpen ? 330 : 0,
          duration: Duration(milliseconds: 100),
          child: Offstage(
            offstage: !controller.isFilterOpen,
            child: Column(
              children: [
                SizedBox(
                  width: 35,
                ),
                Container(
                  height: 35,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Spacer(),
                      Container(
                        child: Text("Filter",
                            style: TextStyle(
                              fontSize: 14,
                              fontFamily: CustomFonts.family1SemiBold,
                              color: AppColors().darkText,
                            )),
                      ),
                      Spacer(),
                      GestureDetector(
                        onTap: () {
                          controller.isFilterOpen = false;
                          controller.update();
                        },
                        child: Container(
                          padding: EdgeInsets.all(9),
                          width: 30,
                          height: 30,
                          color: Colors.transparent,
                          child: Image.asset(
                            AppImages.closeIcon,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      )
                    ],
                  ),
                ),
                Expanded(
                    child: Container(
                  color: AppColors().slideGrayBG,
                  child: Column(
                    children: [
                      // SizedBox(
                      //   height: 10,
                      // ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        height: 35,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Spacer(),
                            Container(
                              child: Text("Filter Type:",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontFamily: CustomFonts.family1Regular,
                                    color: AppColors().fontColor,
                                  )),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            filterTypeDropDown(controller.selectedFilterType, width: 200),
                            SizedBox(
                              width: 30,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        height: 35,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Spacer(),
                            Container(
                              child: Text("User Type:",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontFamily: CustomFonts.family1Regular,
                                    color: AppColors().fontColor,
                                  )),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            userTypeDropDown(controller.selectedUserType, height: 35, width: 200),
                            SizedBox(
                              width: 30,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        height: 35,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Spacer(),
                            Container(
                              child: Text("User Status:",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontFamily: CustomFonts.family1Regular,
                                    color: AppColors().fontColor,
                                  )),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            statusListDropDown(controller.selectUserStatusdropdownValue, height: 35, width: 200),
                            SizedBox(
                              width: 30,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        height: 35,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Spacer(),
                            Container(
                              child: Text("Search:",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontFamily: CustomFonts.family1Regular,
                                    color: AppColors().fontColor,
                                  )),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Container(
                              width: 200,
                              decoration: BoxDecoration(color: AppColors().whiteColor, border: Border.all(color: AppColors().lightOnlyText, width: 1)),
                              child: TextFormField(
                                textInputAction: TextInputAction.search,
                                style: TextStyle(
                                  fontSize: 14,
                                  fontFamily: CustomFonts.family1Medium,
                                  color: AppColors().darkText,
                                ),
                                controller: controller.textController,
                                onFieldSubmitted: (String value) {},
                                validator: (String? value) {
                                  // if (!foodTags.contains(value)) {
                                  //   return 'Nothing selected.';
                                  // }
                                  return null;
                                },
                                decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.all(8),
                                  // labelText: 'Food Type',
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(width: 0, color: Colors.transparent),
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(width: 0, color: Colors.transparent),
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 30,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 70,
                          ),
                          SizedBox(
                            width: 80,
                            height: 35,
                            child: CustomButton(
                              isEnabled: true,
                              shimmerColor: AppColors().whiteColor,
                              title: "View",
                              textSize: 14,
                              onPress: () {
                                controller.arrUserListData.clear();
                                controller.currentPage = 1;
                                controller.getUserList(isFromButtons: true);
                              },
                              focusKey: controller.viewFocus,
                              borderColor: Colors.transparent,
                              focusShadowColor: AppColors().blueColor,
                              bgColor: AppColors().blueColor,
                              isFilled: true,
                              textColor: AppColors().whiteColor,
                              isTextCenter: true,
                              isLoading: controller.isLoadingData,
                            ),
                          ),
                          SizedBox(
                            width: 1.w,
                          ),
                          SizedBox(
                            width: 80,
                            height: 35,
                            child: CustomButton(
                              isEnabled: true,
                              shimmerColor: AppColors().blueColor,
                              title: "Clear",
                              textSize: 14,
                              prefixWidth: 0,
                              onPress: () {
                                controller.selectedUserType.value = userRoleListData();
                                controller.selectedScriptFromFilter.value = GlobalSymbolData();
                                controller.textController.clear();
                                controller.selectedFilterType.value = AddMaster();
                                controller.selectUserStatusdropdownValue.value = AddMaster();
                                controller.fromDate.value = "";
                                controller.endDate.value = "";
                                controller.arrUserListData.clear();
                                controller.currentPage = 1;
                                controller.update();
                                controller.getUserList(isFromClear: true, isFromButtons: true);
                              },
                              bgColor: AppColors().whiteColor,
                              isFilled: true,
                              focusKey: controller.clearFocus,
                              borderColor: Colors.transparent,
                              focusShadowColor: AppColors().blueColor,
                              textColor: AppColors().blueColor,
                              isTextCenter: true,
                              isLoading: controller.isResetData,
                            ),
                          ),
                          // SizedBox(width: 5.w,),
                        ],
                      )
                    ],
                  ),
                ))
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget mainContent(BuildContext context) {
    return SingleChildScrollView(
      physics: controller.isLoadingData == false && controller.arrUserListData.isEmpty ? NeverScrollableScrollPhysics() : ClampingScrollPhysics(),
      scrollDirection: Axis.horizontal,
      child: AnimatedContainer(
        duration: Duration(milliseconds: 100),
        width: 3375,
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 3.h,
              color: AppColors().whiteColor,
              child: Row(
                children: [
                  // Container(
                  //   width: 30,
                  // ),
                  listTitleContent(),
                ],
              ),
            ),
            Expanded(
              child: (controller.isLoadingData == false && controller.isResetData == false) && controller.arrUserListData.isEmpty
                  ? Container(
                      width: 100.w,
                      child: Center(
                        child: Text("Users not found", style: TextStyle(fontSize: 20, fontFamily: CustomFonts.family1Medium, color: AppColors().lightOnlyText)),
                      ))
                  : PaginableListView.builder(
                      loadMore: () async {
                        if (controller.totalPage >= controller.currentPage) {
                          //print(controller.currentPage);
                          controller.getUserList();
                        }
                      },
                      errorIndicatorWidget: (exception, tryAgain) => dataNotFoundView("Data not found"),
                      progressIndicatorWidget: displayIndicator(),
                      physics: const ClampingScrollPhysics(),
                      clipBehavior: Clip.hardEdge,
                      itemCount: controller.isLoadingData || controller.isResetData ? 50 : controller.arrUserListData.length,
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return orderContent(context, index);
                      }),
            ),
            Container(
              height: 30,
              decoration: BoxDecoration(color: AppColors().whiteColor, border: Border(top: BorderSide(color: AppColors().lightOnlyText, width: 1))),
              child: Center(
                  child: Row(
                children: [
                  totalContent(value: "Total", textColor: AppColors().darkText, width: 1200),
                  totalContent(value: controller.totalPL.toStringAsFixed(2), textColor: controller.totalPL < 0 ? AppColors().redColor : AppColors().blueColor, width: 110),
                  totalContent(value: controller.totalPLPercentage.toStringAsFixed(2), textColor: controller.totalPLPercentage < 0 ? AppColors().redColor : AppColors().blueColor, width: 110),
                ],
              )),
            ),
            Container(
              height: 2.h,
              color: AppColors().headerBgColor,
            ),
          ],
        ),
      ),
    );
  }

  Widget totalContent({String? value, Color? textColor, double? width}) {
    return Container(
      width: width ?? 6.w,
      padding: EdgeInsets.only(left: 5),
      decoration: BoxDecoration(color: AppColors().whiteColor, border: Border(top: BorderSide(color: AppColors().lightOnlyText, width: 1), bottom: BorderSide(color: AppColors().lightOnlyText, width: 1), right: BorderSide(color: AppColors().lightOnlyText, width: 1))),
      child: Text(value ?? "",
          style: TextStyle(
            fontSize: 12,
            fontFamily: CustomFonts.family1Medium,
            color: textColor ?? AppColors().redColor,
          )),
    );
  }

  Widget orderContent(BuildContext context, int index) {
    // var scriptValue = controller.arrUserListData[index];
    if (controller.isLoadingData || controller.isResetData) {
      return Container(
        margin: EdgeInsets.only(bottom: 3.h),
        child: Shimmer.fromColors(
            child: Container(
              height: 3.h,
              color: Colors.white,
            ),
            baseColor: AppColors().whiteColor,
            highlightColor: AppColors().grayBg),
      );
    } else {
      return GestureDetector(
        onTap: () {
          controller.selectedUserIndex = index;
          controller.update();
        },
        child: Container(
          decoration: BoxDecoration(color: Colors.transparent, border: Border.all(width: 1, color: controller.selectedUserIndex == index ? AppColors().darkText : Colors.transparent)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              valueBox("", 0, index % 2 == 0 ? Colors.transparent : AppColors().grayBg, Colors.transparent, index, isImage: true, strImage: AppImages.editUserImage, isSmall: true, onClickImage: () {
                var dashbaordScreen = Get.find<MainContainerController>();
                dashbaordScreen.isCreateUserClick = true;
                dashbaordScreen.isNotificationSettingClick = false;
                dashbaordScreen.widgetOptions.clear();
                dashbaordScreen.arrAvailableController.clear();
                dashbaordScreen.arrAvailableTabs.clear();
                var createUserVC = Get.find<CreateUserController>();
                createUserVC.selectedUserForEdit = controller.arrUserListData[index];
                createUserVC.fillUserDataForEdit();
                dashbaordScreen.update();
              }),
              // valueBox("", 0, index % 2 == 0 ? Colors.transparent : AppColors().grayBg, Colors.transparent, index,
              //     isImage: true, isBig: true, strImage: AppImages.shareDetailsImage, onClickImage: () {
              //   controller.selectedUserIndex = index;
              //   showSharingPopup();
              // }),
              PopupMenuButton<String>(
                tooltip: "",
                onSelected: (String value) {
                  // Handle menu item selection here
                  print('Selected: $value');
                  if (value == "1") {
                    showChangePasswordPopUp(selectedUserId: controller.arrUserListData[index].userId!);
                  }
                },
                itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                  PopupMenuItem<String>(
                    value: '1',
                    child: Text('Change password'),
                  ),
                  PopupMenuItem<String>(
                    value: '2',
                    child: Text(controller.arrUserListData[index].role == UserRollList.user ? '% MARGIN SQUER' : "Account limit"),
                  ),
                ],
                child: IgnorePointer(
                  ignoring: true,
                  child: valueBox(
                    "",
                    0,
                    index % 2 == 0 ? Colors.transparent : AppColors().grayBg,
                    Colors.transparent,
                    index,
                    isImage: true,
                    isSmall: true,
                    strImage: AppImages.cpImage,
                  ),
                ),
              ),

              valueBox(controller.arrUserListData[index].userName ?? "", 33, index % 2 == 0 ? Colors.transparent : AppColors().grayBg, AppColors().darkText, index, isBig: true, isUnderlined: true, onClickValue: () {
                showUserDetailsPopUp(userId: controller.arrUserListData[index].userId!, userName: controller.arrUserListData[index].userName!, roll: controller.arrUserListData[index].role!);
              }),
              valueBox(controller.arrUserListData[index].parentUser ?? "--", 45, index % 2 == 0 ? Colors.transparent : AppColors().grayBg, AppColors().darkText, index),
              valueBox(controller.arrUserListData[index].roleName ?? "", 45, index % 2 == 0 ? Colors.transparent : AppColors().grayBg, AppColors().darkText, index),
              valueBox(controller.arrUserListData[index].name ?? "", 45, index % 2 == 0 ? Colors.transparent : AppColors().grayBg, AppColors().darkText, index, isBig: true),
              valueBox("${controller.arrUserListData[index].profitAndLossSharing}%", 45, index % 2 == 0 ? Colors.transparent : AppColors().grayBg, AppColors().blueColor, index),
              valueBox("${controller.arrUserListData[index].brkSharing}%", 45, index % 2 == 0 ? Colors.transparent : AppColors().grayBg, AppColors().blueColor, index),
              valueBox(controller.arrUserListData[index].leverage!.toString(), 45, index % 2 == 0 ? Colors.transparent : AppColors().grayBg, AppColors().blueColor, index),

              valueBox(controller.arrUserListData[index].credit.toString(), 45, index % 2 == 0 ? Colors.transparent : AppColors().grayBg, AppColors().darkText, index),
              valueBox("", 45, index % 2 == 0 ? Colors.transparent : AppColors().grayBg, AppColors().blueColor, index),
              valueBox(controller.arrUserListData[index].profitLoss!.toStringAsFixed(2), 45, index % 2 == 0 ? Colors.transparent : AppColors().grayBg, AppColors().blueColor, index),
              valueBox("${(controller.arrUserListData[index].profitLoss! / 100).toStringAsFixed(2)}%", 45, index % 2 == 0 ? Colors.transparent : AppColors().grayBg, AppColors().blueColor, index),
              valueBox(controller.arrUserListData[index].tradeMarginBalance!.toStringAsFixed(2), 45, index % 2 == 0 ? Colors.transparent : AppColors().grayBg, AppColors().blueColor, index, isBig: true),
              valueBox(controller.arrUserListData[index].role == UserRollList.user ? (controller.arrUserListData[index].marginBalance! - controller.arrUserListData[index].tradeMarginBalance!).toStringAsFixed(2) : "0", 45, index % 2 == 0 ? Colors.transparent : AppColors().grayBg,
                  AppColors().blueColor, index,
                  isBig: true),

              valueBox(controller.arrUserListData[index].tradeBalance!.toStringAsFixed(2), 45, index % 2 == 0 ? Colors.transparent : AppColors().grayBg, AppColors().blueColor, index),

              valueBox("", 0, index % 2 == 0 ? Colors.transparent : AppColors().grayBg, Colors.transparent, index, isSwitch: true, switchValue: controller.arrUserListData[index].bet!.obs),
              valueBox("", 0, index % 2 == 0 ? Colors.transparent : AppColors().grayBg, Colors.transparent, index, isSwitch: controller.arrUserListData[index].role == UserRollList.master ? false : true, switchValue: controller.arrUserListData[index].closeOnly!.obs),

              valueBox("", 0, index % 2 == 0 ? Colors.transparent : AppColors().grayBg, Colors.transparent, index, isSwitch: true, switchValue: controller.arrUserListData[index].marginSquareOff!.obs, isBig: true),
              valueBox("", 0, index % 2 == 0 ? Colors.transparent : AppColors().grayBg, Colors.transparent, index, isSwitch: true, switchValue: controller.arrUserListData[index].modifyOrder == 0 ? false.obs : true.obs),
              valueBox("", 0, index % 2 == 0 ? Colors.transparent : AppColors().grayBg, Colors.transparent, index, isSwitch: true, switchValue: controller.arrUserListData[index].status == 1 ? true.obs : false.obs),

              valueBox(shortFullDateTime(controller.arrUserListData[index].createdAt!), 60, index % 2 == 0 ? Colors.transparent : AppColors().grayBg, AppColors().darkText, index, isForDate: true),
              valueBox(shortFullDateTime(controller.arrUserListData[index].createdAt!), 60, index % 2 == 0 ? Colors.transparent : AppColors().grayBg, AppColors().darkText, index, isLarge: true),
              valueBox(controller.arrUserListData[index].deviceType ?? "--", 45, index % 2 == 0 ? Colors.transparent : AppColors().grayBg, AppColors().darkText, index),
              valueBox(controller.arrUserListData[index].deviceId ?? "--", 45, index % 2 == 0 ? Colors.transparent : AppColors().grayBg, AppColors().darkText, index, isBig: true),
              valueBox(controller.arrUserListData[index].ipAddress ?? "--", 45, index % 2 == 0 ? Colors.transparent : AppColors().grayBg, AppColors().darkText, index),

              // valueBox("", 0, index % 2 == 0 ? Colors.transparent : AppColors().grayBg, Colors.transparent, index,
              //     isImage: true, isBig: true, strImage: AppImages.shareDetailsImage, onClickImage: () {
              //   controller.selectedUserIndex = index;
              //   showSharingPopup();
              // }),
            ],
          ),
        ),
      );
    }
  }

  Widget contextMenuButton() {
    return PopupMenuButton<String>(
      onSelected: (String value) {
        // Handle menu item selection here
        print('Selected: $value');
      },
      itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
        PopupMenuItem<String>(
          value: 'Option 1',
          child: Text('Option 1'),
        ),
        PopupMenuItem<String>(
          value: 'Option 2',
          child: Text('Option 2'),
        ),
        PopupMenuItem<String>(
          value: 'Option 3',
          child: Text('Option 3'),
        ),
      ],
    );
  }

  Widget listTitleContent() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        titleBox("EDIT", isSmall: true),
        // titleBox("Share Details", isBig: true),
        titleBox("...", isSmall: true),
        titleBox("Username", isBig: true),
        titleBox("PARENT USER"),
        titleBox("Type"),
        titleBox("Name", isBig: true),
        titleBox("our %"),
        titleBox("Brk Sharing"),
        titleBox("Leverage"),

        titleBox("Credit"),
        titleBox("equity"),
        titleBox("P/L"),
        titleBox("P/L % WISE"),
        titleBox("Total Margin", isBig: true),
        titleBox("Used Margin", isBig: true),
        titleBox("free margin"),

        titleBox("bet"),
        titleBox("Close only"),

        // titleBox("Modify Order", isBig: true),

        titleBox("AUTO SQROFF", isBig: true),
        titleBox("View only"),
        titleBox("Status"),

        titleBox("CREATED DATE", isForDate: true),
        titleBox("last login date/time", isLarge: true),
        titleBox("Device"),
        titleBox("Device Id", isBig: true),
        titleBox("IP ADRESS"),
      ],
    );
  }

  showSharingPopup() {
    isUserDetailPopUpOpen = true;

    showDialog<String>(
        context: Get.context!,
        // barrierColor: Colors.transparent,
        barrierDismissible: true,
        builder: (BuildContext context) => FloatingDialog(
              // titlePadding: EdgeInsets.zero,
              // backgroundColor: AppColors().bgColor,
              // surfaceTintColor: AppColors().bgColor,

              // contentPadding: EdgeInsets.zero,
              // insetPadding: EdgeInsets.symmetric(
              //   horizontal: 20.w,
              //   vertical: 32.h,
              // ),
              enableDragAnimation: false,
              child: Container(
                // width: 30.w,
                // height: 28.h,
                width: 30.w,
                height: 30.h,
                decoration: BoxDecoration(border: Border.all(color: AppColors().lightOnlyText, width: 1)),
                child: Column(
                  children: [
                    headerViewContent(Get.context!),
                    contentView(),
                    SizedBox(
                      height: 20,
                    ),
                    buttonsView(),
                    SizedBox(
                      height: 5,
                    )
                  ],
                ),
              ),
            ));
  }

  Widget buttonsView() {
    var userValue = controller.arrUserListData[controller.selectedUserIndex];
    var tempString = "";

    tempString = "Username : ${userValue.userName}\n Password : Please enter your password\n Servername  : ${serverName} \n iOS Link : https://www.apple.com \n Android Link : https://www.google.com \n Mac Link : https://www.appleMac.com \n Window Link : https://www.microsoft.com";
    return Expanded(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          SizedBox(
            width: 70,
          ),
          SizedBox(
            width: 6.w,
            height: 3.h,
            child: CustomButton(
              isEnabled: true,
              shimmerColor: AppColors().whiteColor,
              title: "Copy",
              textSize: 14,
              onPress: () async {
                await Clipboard.setData(ClipboardData(text: tempString));
                showSuccessToast("Details copied successfully.");
              },
              bgColor: AppColors().blueColor,
              isFilled: true,
              textColor: AppColors().whiteColor,
              isTextCenter: true,
              isLoading: false,
            ),
          ),
          SizedBox(
            width: 1.w,
          ),
          SizedBox(
            width: 6.w,
            height: 3.h,
            child: CustomButton(
              isEnabled: true,
              shimmerColor: AppColors().blueColor,
              title: "Send",
              textSize: 14,
              prefixWidth: 0,
              onPress: () async {
                var tempEmail = "";

                final Uri _url = Uri.parse("mailto:${tempEmail}?subject=${userValue.name!} Details&body=${tempString}");
                if (!await launchUrl(_url)) {
                  throw Exception('Could not launch $_url');
                }
              },
              bgColor: AppColors().whiteColor,
              isFilled: true,
              borderColor: AppColors().blueColor,
              textColor: AppColors().blueColor,
              isTextCenter: true,
              isLoading: false,
            ),
          ),
          SizedBox(
            width: 10,
          ),
        ],
      ),
    );
  }

  Widget contentView() {
    var userValue = controller.arrUserListData[controller.selectedUserIndex];
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        children: [
          Row(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 120,
                child: Text("Username : ",
                    style: TextStyle(
                      fontSize: 16,
                      fontFamily: CustomFonts.family1Medium,
                      color: AppColors().darkText,
                    )),
              ),
              SizedBox(
                width: 10,
              ),
              Text(userValue.userName ?? "",
                  style: TextStyle(
                    fontSize: 16,
                    fontFamily: CustomFonts.family1Medium,
                    color: AppColors().darkText,
                  )),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 120,
                child: Text("Password : ",
                    style: TextStyle(
                      fontSize: 16,
                      fontFamily: CustomFonts.family1Medium,
                      color: AppColors().darkText,
                    )),
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                child: Text("Please enter your password",
                    style: TextStyle(
                      fontSize: 16,
                      fontFamily: CustomFonts.family1Medium,
                      color: AppColors().darkText,
                    )),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 120,
                child: Text("Server Name : ",
                    style: TextStyle(
                      fontSize: 16,
                      fontFamily: CustomFonts.family1Medium,
                      color: AppColors().darkText,
                    )),
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                child: Text("bazaar",
                    style: TextStyle(
                      fontSize: 16,
                      fontFamily: CustomFonts.family1Medium,
                      color: AppColors().darkText,
                    )),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 120,
                child: Text("iOS Link : ",
                    style: TextStyle(
                      fontSize: 16,
                      fontFamily: CustomFonts.family1Medium,
                      color: AppColors().darkText,
                    )),
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                child: Text("https://www.apple.com",
                    style: TextStyle(
                      fontSize: 16,
                      fontFamily: CustomFonts.family1Medium,
                      color: AppColors().darkText,
                    )),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 120,
                child: Text("Android Link : ",
                    style: TextStyle(
                      fontSize: 16,
                      fontFamily: CustomFonts.family1Medium,
                      color: AppColors().darkText,
                    )),
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                child: Text("https://www.google.com",
                    style: TextStyle(
                      fontSize: 16,
                      fontFamily: CustomFonts.family1Medium,
                      color: AppColors().darkText,
                    )),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 120,
                child: Text("Mac Link : ",
                    style: TextStyle(
                      fontSize: 16,
                      fontFamily: CustomFonts.family1Medium,
                      color: AppColors().darkText,
                    )),
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                child: Text("https://www.appleMac.com",
                    style: TextStyle(
                      fontSize: 16,
                      fontFamily: CustomFonts.family1Medium,
                      color: AppColors().darkText,
                    )),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 120,
                child: Text("Window Link : ",
                    style: TextStyle(
                      fontSize: 16,
                      fontFamily: CustomFonts.family1Medium,
                      color: AppColors().darkText,
                    )),
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                child: Text("https://www.microsoft.com",
                    style: TextStyle(
                      fontSize: 16,
                      fontFamily: CustomFonts.family1Medium,
                      color: AppColors().darkText,
                    )),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget headerViewContent(BuildContext context) {
    var userValue = controller.arrUserListData[controller.selectedUserIndex];
    return Container(
        width: 100.w,
        height: 35,
        decoration: BoxDecoration(
            color: AppColors().whiteColor,
            border: Border(
              bottom: BorderSide(color: AppColors().lightOnlyText, width: 1),
            )),
        child: Row(
          children: [
            const SizedBox(
              width: 10,
            ),
            Image.asset(
              AppImages.appLogo,
              width: 3.h,
              height: 3.h,
            ),
            const SizedBox(
              width: 10,
            ),
            Text("User Details [${userValue.userName}]",
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: CustomFonts.family1Medium,
                  color: AppColors().blueColor,
                )),
            const Spacer(),
            GestureDetector(
              onTap: () {
                Get.back();
              },
              child: Container(
                width: 3.h,
                height: 3.h,
                padding: EdgeInsets.all(0.5.h),
                child: Image.asset(
                  AppImages.closeIcon,
                  color: AppColors().redColor,
                ),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
          ],
        ));
  }
}

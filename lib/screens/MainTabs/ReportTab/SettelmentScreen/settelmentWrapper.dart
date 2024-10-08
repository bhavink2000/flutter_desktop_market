import 'package:get/get.dart';
import 'package:marketdesktop/modelClass/myUserListModelClass.dart';
import 'package:marketdesktop/modelClass/settelementListModelClass.dart';
import 'package:marketdesktop/screens/MainTabs/ReportTab/SettelmentScreen/settelmentController.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../constant/index.dart';

import 'package:responsive_framework/responsive_framework.dart';
import '../../../../constant/utilities.dart';
import '../../../../customWidgets/appButton.dart';
import '../../../../customWidgets/appTextField.dart';
import '../../../MainContainerScreen/mainContainerController.dart';

class SettlementScreen extends BaseView<SettlementController> {
  const SettlementScreen({Key? key}) : super(key: key);

  @override
  Widget vBuilder(BuildContext context) {
    return FocusTraversalGroup(
      policy: WidgetOrderTraversalPolicy(),
      child: Visibility(
        visible: Get.find<MainContainerController>().selectedCurrentTab == "Settlement",
        child: GestureDetector(
          onTap: () {
            // controller.focusNode.requestFocus();
          },
          child: Row(
            children: [
              filterPanel(context, bottomMargin: 0, isRecordDisplay: false, onCLickFilter: () {
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
          // margin: EdgeInsets.only(bottom: 2.h),
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
                  color: AppColors().headerBgColor,
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
                              child: Text("Username:",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontFamily: CustomFonts.family1Regular,
                                    color: AppColors().fontColor,
                                  )),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            userListDropDown(controller.selectedUser, width: 200),
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
                              child: CustomTextField(
                                type: 'Search',
                                keyBoardType: TextInputType.text,
                                isEnabled: true,
                                isOptional: false,
                                inValidMsg: "",
                                placeHolderMsg: "Search",
                                emptyFieldMsg: "",
                                controller: controller.searchController,
                                focus: controller.searchFocus,
                                isSecure: false,
                                borderColor: AppColors().grayLightLine,
                                keyboardButtonType: TextInputAction.search,
                                maxLength: 64,
                                isShowSufix: false,
                                isShowPrefix: false,
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
                                controller.getSettelementList(isFrom: 1);
                              },
                              focusKey: controller.viewFocus,
                              borderColor: Colors.transparent,
                              focusShadowColor: AppColors().blueColor,
                              bgColor: AppColors().blueColor,
                              isFilled: true,
                              textColor: AppColors().whiteColor,
                              isTextCenter: true,
                              isLoading: controller.isApiCallFromSearch,
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
                                controller.selectedUser.value = UserData();
                                controller.searchController.clear();
                                controller.getSettelementList(isFrom: 2);
                              },
                              bgColor: AppColors().whiteColor,
                              isFilled: true,
                              focusKey: controller.clearFocus,
                              borderColor: Colors.transparent,
                              focusShadowColor: AppColors().blueColor,
                              textColor: AppColors().blueColor,
                              isTextCenter: true,
                              isLoading: controller.isApiCallFromReset,
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
      physics: ClampingScrollPhysics(),
      scrollDirection: Axis.horizontal,
      child: AnimatedContainer(
        duration: Duration(milliseconds: 100),
        width: 96.w,
        // margin: EdgeInsets.only(right: 1.w),
        color: Colors.white,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: controller.isFilterOpen ? 40.w : 47.8.w,
              padding: EdgeInsets.all(1),
              decoration: BoxDecoration(border: Border.all(color: AppColors().lightOnlyText, width: 1)),
              child: Column(
                children: [
                  Container(
                    height: 3.h,
                    decoration: BoxDecoration(color: AppColors().whiteColor, border: Border(bottom: BorderSide(color: AppColors().lightOnlyText, width: 1))),
                    child: Center(
                      child: Text("Profit",
                          style: TextStyle(
                            fontSize: 14,
                            fontFamily: CustomFonts.family1Medium,
                            color: AppColors().greenColor,
                          )),
                    ),
                  ),
                  Container(
                    height: 3.h,
                    color: AppColors().whiteColor,
                    child: listTitleContent(),
                  ),
                  Expanded(
                    child: controller.isApiCallFirstTime == false && controller.isApiCallFromReset == false && controller.isApiCallFromSearch == false && controller.arrProfitList.isEmpty
                        ? dataNotFoundView("Profit history not found")
                        : ListView.builder(
                            physics: const ClampingScrollPhysics(),
                            clipBehavior: Clip.hardEdge,
                            itemCount: controller.isApiCallFirstTime || controller.isApiCallFromReset || controller.isApiCallFromSearch ? 50 : controller.arrProfitList.length,
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return profitLossContent(context, index, controller.isApiCallFirstTime || controller.isApiCallFromReset || controller.isApiCallFromSearch ? Profit() : controller.arrProfitList[index]);
                            }),
                  ),
                  if (controller.isApiCallFirstTime == false)
                    Container(
                      height: 3.h,
                      decoration: BoxDecoration(color: AppColors().whiteColor, border: Border(top: BorderSide(color: AppColors().lightOnlyText, width: 1))),
                      child: Center(
                          child: Row(
                        children: [
                          totalContent(value: "Net Profit", textColor: AppColors().darkText, width: 110),
                          totalContent(value: controller.totalValues!.plProfitGrandTotal.toStringAsFixed(2), textColor: AppColors().darkText, width: 110),
                          totalContent(value: controller.totalValues!.brkProfitGrandTotal.toStringAsFixed(2), textColor: AppColors().darkText, width: 110),
                          totalContent(value: controller.totalValues!.profitGrandTotal.toStringAsFixed(2), textColor: AppColors().darkText, width: 110),
                        ],
                      )),
                    ),
                ],
              ),
            ),
            SizedBox(
              width: 3,
            ),
            Container(
              width: controller.isFilterOpen ? 40.w : 47.9.w,
              padding: EdgeInsets.all(1),
              decoration: BoxDecoration(border: Border.all(color: AppColors().lightOnlyText, width: 1)),
              child: Column(
                children: [
                  Container(
                    height: 3.h,
                    decoration: BoxDecoration(color: AppColors().whiteColor, border: Border(bottom: BorderSide(color: AppColors().lightOnlyText, width: 1))),
                    child: Center(
                      child: Text("Loss",
                          style: TextStyle(
                            fontSize: 14,
                            fontFamily: CustomFonts.family1Medium,
                            color: AppColors().redColor,
                          )),
                    ),
                  ),
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
                    child: controller.isApiCallFirstTime == false && controller.isApiCallFromReset == false && controller.isApiCallFromSearch == false && controller.arrLossList.isEmpty
                        ? dataNotFoundView("Loss history not found")
                        : ListView.builder(
                            physics: const ClampingScrollPhysics(),
                            clipBehavior: Clip.hardEdge,
                            itemCount: controller.isApiCallFirstTime || controller.isApiCallFromReset || controller.isApiCallFromSearch ? 50 : controller.arrLossList.length,
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return profitLossContent(context, index, controller.isApiCallFirstTime || controller.isApiCallFromReset || controller.isApiCallFromSearch ? Profit() : controller.arrLossList[index]);
                            }),
                  ),
                  if (controller.isApiCallFirstTime == false)
                    Container(
                      height: 3.h,
                      decoration: BoxDecoration(color: AppColors().whiteColor, border: Border(top: BorderSide(color: AppColors().lightOnlyText, width: 1))),
                      child: Center(
                          child: Row(
                        children: [
                          totalContent(value: "Net Loss", textColor: AppColors().darkText, width: 110),
                          totalContent(value: controller.totalValues!.plLossGrandTotal.toStringAsFixed(2), textColor: AppColors().darkText, width: 110),
                          totalContent(value: controller.totalValues!.brkLossGrandTotal.toStringAsFixed(2), textColor: AppColors().darkText, width: 110),
                          totalContent(value: controller.totalValues!.LossGrandTotal.toStringAsFixed(2), textColor: AppColors().darkText, width: 110),
                        ],
                      )),
                    ),
                ],
              ),
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

  Widget profitLossContent(BuildContext context, int index, Profit value) {
    // var scriptValue = controller.arrUserOderList[index];
    if (controller.isApiCallFirstTime || controller.isApiCallFromReset || controller.isApiCallFromSearch) {
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
          // controller.selectedScriptIndex = index;
          controller.update();
        },
        child: Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              valueBox(value.userName! + " [ ${value.name!} - ${controller.getRoll(value.role!)} - ${value.profitAndLossSharing!.toString()} ]", 45, index % 2 == 0 ? Colors.transparent : AppColors().grayBg, AppColors().darkText, index, isUnderlined: true, onClickValue: () {
                showUserDetailsPopUp(userId: value.userId!, userName: value.userName!);
              }, isLarge: true),
              valueBox(value.profitLoss!.toStringAsFixed(2), 45, index % 2 == 0 ? Colors.transparent : AppColors().grayBg, AppColors().darkText, index),
              valueBox(value.brokerageTotal!.toStringAsFixed(2), 45, index % 2 == 0 ? Colors.transparent : AppColors().grayBg, AppColors().darkText, index),
              valueBox((value.profitLoss! - value.brokerageTotal!).toStringAsFixed(2), 45, index % 2 == 0 ? Colors.transparent : AppColors().grayBg, AppColors().darkText, index),
            ],
          ),
        ),
      );
    }
  }

  Widget listTitleContent() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        // titleBox("", 0),

        titleBox("Username", isLarge: true),
        titleBox("P/L"),
        titleBox("Brk"),
        titleBox("Total"),
      ],
    );
  }
}

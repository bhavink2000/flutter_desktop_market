import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:floating_dialog/floating_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:marketdesktop/constant/utilities.dart';
import 'package:marketdesktop/customWidgets/appTextField.dart';
import 'package:marketdesktop/main.dart';

import 'package:marketdesktop/modelClass/allSymbolListModelClass.dart';
import 'package:marketdesktop/modelClass/brokerListModelClass.dart';
import 'package:marketdesktop/modelClass/constantModelClass.dart';
import 'package:marketdesktop/modelClass/exchangeListModelClass.dart';
import 'package:marketdesktop/modelClass/myUserListModelClass.dart';
import 'package:marketdesktop/modelClass/userRoleListModelClass.dart';
import 'package:marketdesktop/service/network/allApiCallService.dart';
import '../constant/index.dart';

List<UserData> arrUserList = [];
List<String> arrSortType = ["Top", "Last"];
List<AddMaster> arrFilterType = [];

List<String> arrSortCount = ["5", "10", "15", "20"];
List<String> arrPeriodList = ["Month", "Year", "Week"];
List<String> arrLogType = ["All"];
List<Type> arrTradeStatus = [];
List<String> arrTradeAttribute = ["Fully", "Close"];
List<userRoleListData> arrUserTypeList = [];
List<ExchangeData> arrExchange = [];
List<GlobalSymbolData> arrAllScript = [];

List<BrokerListModelData> arrBrokerList = [];
AllApiCallService service = AllApiCallService();
List<AddMaster> arrLeverageList = [];
List<AddMaster> arrStatuslist = [];
GlobalKey? dropdownUserTypeKey;
TextEditingController scriptEditingController = TextEditingController();
FocusNode scriptEditingFocus = FocusNode();
TextEditingController exchangeEditingController = TextEditingController();
FocusNode exchangeEditingFocus = FocusNode();
TextEditingController userEditingController = TextEditingController();
FocusNode userEditingFocus = FocusNode();
bool isSuperAdminPopUpOpen = false;
final List<Map<String, dynamic>> _roles = arrLeverageList.map((e) => e.toJson()).toList();

Widget sortTypeDropDown(RxString selectedType, {double? width}) {
  return Obx(() {
    return Container(
        width: width ?? 250,
        // margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(border: Border.all(color: AppColors().lightOnlyText, width: 1), color: AppColors().whiteColor),
        child: Center(
          child: DropdownButtonHideUnderline(
            child: DropdownButton2<String>(
              isExpanded: true,
              iconStyleData: IconStyleData(
                icon: Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: Image.asset(
                    AppImages.arrowDown,
                    height: 20,
                    width: 20,
                    color: AppColors().fontColor,
                  ),
                ),
              ),
              dropdownStyleData: const DropdownStyleData(maxHeight: 150),
              hint: Text(
                '',
                style: TextStyle(
                  fontSize: 14,
                  fontFamily: CustomFonts.family1Medium,
                  color: AppColors().darkText,
                ),
              ),
              items: arrSortType
                  .map((String item) => DropdownMenuItem<String>(
                        value: item,
                        child: Text(item, style: TextStyle(fontSize: 14, fontFamily: CustomFonts.family1Medium, color: AppColors().grayColor)),
                      ))
                  .toList(),
              selectedItemBuilder: (context) {
                return arrSortType
                    .map((String item) => DropdownMenuItem<String>(
                          value: item,
                          child: Text(
                            item,
                            style: TextStyle(
                              fontSize: 14,
                              fontFamily: CustomFonts.family1Medium,
                              color: AppColors().darkText,
                            ),
                          ),
                        ))
                    .toList();
              },
              value: selectedType.value.isEmpty ? null : selectedType.value,
              onChanged: (String? value) {
                selectedType.value = value!;
              },
              buttonStyleData: const ButtonStyleData(
                padding: EdgeInsets.symmetric(horizontal: 0),
                height: 40,
                // width: 140,
              ),
              menuItemStyleData: const MenuItemStyleData(
                height: 40,
              ),
            ),
          ),
        ));
  });
}

Widget filterTypeDropDown(Rx<AddMaster> selectedFilterType, {double? width}) {
  return Obx(() {
    return Container(
        width: width ?? 250,
        // margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(border: Border.all(color: AppColors().lightOnlyText, width: 1), color: AppColors().whiteColor),
        child: Center(
          child: DropdownButtonHideUnderline(
            child: DropdownButton2<AddMaster>(
              isExpanded: true,
              iconStyleData: IconStyleData(
                icon: Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: Image.asset(
                    AppImages.arrowDown,
                    height: 20,
                    width: 20,
                    color: AppColors().fontColor,
                  ),
                ),
              ),
              dropdownStyleData: const DropdownStyleData(maxHeight: 150),
              hint: Text(
                '',
                style: TextStyle(
                  fontSize: 14,
                  fontFamily: CustomFonts.family1Medium,
                  color: AppColors().darkText,
                ),
              ),
              items: arrFilterType
                  .map((AddMaster item) => DropdownMenuItem<AddMaster>(
                        value: item,
                        child: Text(item.name ?? "", style: TextStyle(fontSize: 14, fontFamily: CustomFonts.family1Regular, color: AppColors().grayColor)),
                      ))
                  .toList(),
              selectedItemBuilder: (context) {
                return arrFilterType
                    .map((AddMaster item) => DropdownMenuItem<AddMaster>(
                          value: item,
                          child: Text(
                            item.name ?? "",
                            style: TextStyle(
                              fontSize: 14,
                              fontFamily: CustomFonts.family1Regular,
                              color: AppColors().darkText,
                            ),
                          ),
                        ))
                    .toList();
              },
              value: selectedFilterType.value.id != null ? selectedFilterType.value : null,
              onChanged: (AddMaster? value) {
                selectedFilterType.value = value!;
              },
              buttonStyleData: const ButtonStyleData(
                padding: EdgeInsets.symmetric(horizontal: 0),
                height: 40,
                // width: 140,
              ),
              menuItemStyleData: const MenuItemStyleData(
                height: 40,
              ),
            ),
          ),
        ));
  });
}

Widget sortCountDropDown(RxString selectedCount, {double? width}) {
  return Obx(() {
    return Container(
        width: width ?? 250,
        // margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(border: Border.all(color: AppColors().lightOnlyText, width: 1), color: AppColors().whiteColor),
        child: Center(
          child: DropdownButtonHideUnderline(
            child: DropdownButton2<String>(
              isExpanded: true,
              iconStyleData: IconStyleData(
                icon: Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: Image.asset(
                    AppImages.arrowDown,
                    height: 20,
                    width: 20,
                    color: AppColors().fontColor,
                  ),
                ),
              ),
              dropdownStyleData: const DropdownStyleData(maxHeight: 150),
              hint: Text(
                '',
                style: TextStyle(
                  fontSize: 14,
                  fontFamily: CustomFonts.family1Medium,
                  color: AppColors().darkText,
                ),
              ),
              items: arrSortCount
                  .map((String item) => DropdownMenuItem<String>(
                        value: item,
                        child: Text(item, style: TextStyle(fontSize: 14, fontFamily: CustomFonts.family1Medium, color: AppColors().grayColor)),
                      ))
                  .toList(),
              selectedItemBuilder: (context) {
                return arrSortCount
                    .map((String item) => DropdownMenuItem<String>(
                          value: item,
                          child: Text(
                            item,
                            style: TextStyle(
                              fontSize: 14,
                              fontFamily: CustomFonts.family1Medium,
                              color: AppColors().darkText,
                            ),
                          ),
                        ))
                    .toList();
              },
              value: selectedCount.value.isEmpty ? null : selectedCount.value,
              onChanged: (String? value) {
                selectedCount.value = value!;
              },
              buttonStyleData: const ButtonStyleData(
                padding: EdgeInsets.symmetric(horizontal: 0),
                height: 40,
                // width: 140,
              ),
              menuItemStyleData: const MenuItemStyleData(
                height: 40,
              ),
            ),
          ),
        ));
  });
}

Widget userListDropDown(Rx<UserData> selectedUser, {double? width}) {
  return Obx(() {
    return Container(
        width: width ?? 250,
        // margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(border: Border.all(color: AppColors().lightOnlyText, width: 1), color: AppColors().whiteColor),
        child: Center(
          child: DropdownButtonHideUnderline(
            child: DropdownButton2<UserData>(
              isExpanded: true,
              iconStyleData: IconStyleData(
                icon: Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: Image.asset(
                    AppImages.arrowDown,
                    height: 20,
                    width: 20,
                    color: AppColors().fontColor,
                  ),
                ),
              ),
              dropdownSearchData: DropdownSearchData(
                searchController: userEditingController,
                searchInnerWidgetHeight: 50,
                searchInnerWidget: Container(
                  height: 40,
                  // padding: EdgeInsets.only(top: 2.w, right: 2.w, left: 2.w),
                  child: CustomTextField(
                    type: '',
                    keyBoardType: TextInputType.text,
                    isEnabled: true,
                    isOptional: false,
                    inValidMsg: "",
                    placeHolderMsg: "Search User",
                    emptyFieldMsg: "",
                    controller: userEditingController,
                    focus: userEditingFocus,
                    isSecure: false,
                    borderColor: AppColors().grayLightLine,
                    keyboardButtonType: TextInputAction.done,
                    maxLength: 64,
                    prefixIcon: Image.asset(
                      AppImages.searchIcon,
                      height: 20,
                      width: 20,
                    ),
                    suffixIcon: Container(
                      child: GestureDetector(
                        onTap: () {
                          userEditingController.clear();
                        },
                        child: Image.asset(
                          AppImages.crossIcon,
                          height: 20,
                          width: 20,
                        ),
                      ),
                    ),
                  ),
                ),
                searchMatchFn: (item, searchValue) {
                  return item.value!.name.toString().toLowerCase().startsWith(searchValue.toLowerCase());
                },
              ),
              hint: Text(
                'Select User',
                style: TextStyle(
                  fontSize: 14,
                  fontFamily: CustomFonts.family1Medium,
                  color: AppColors().darkText,
                ),
              ),
              items: arrUserList
                  .map((UserData item) => DropdownMenuItem<UserData>(
                        value: item,
                        child: Text(item.userName ?? "", style: TextStyle(fontSize: 14, fontFamily: CustomFonts.family1Medium, color: AppColors().grayColor)),
                      ))
                  .toList(),
              selectedItemBuilder: (context) {
                return arrUserList
                    .map((UserData item) => DropdownMenuItem<UserData>(
                          value: item,
                          child: Text(
                            item.userName ?? "",
                            style: TextStyle(fontSize: 14, fontFamily: CustomFonts.family1Medium, color: AppColors().darkText, overflow: TextOverflow.ellipsis),
                          ),
                        ))
                    .toList();
              },
              value: selectedUser.value.userId == null ? null : selectedUser.value,
              onChanged: (UserData? value) {
                selectedUser.value = value!;
              },
              buttonStyleData: const ButtonStyleData(
                padding: EdgeInsets.symmetric(horizontal: 0),
                height: 40,
                // width: 140,
              ),
              dropdownStyleData: const DropdownStyleData(maxHeight: 250),
              menuItemStyleData: const MenuItemStyleData(
                height: 40,
              ),
            ),
          ),
        ));
  });
}

Widget timePeriodDropDown(RxString selectedPeriod) {
  return Obx(() {
    return Container(
        width: 250,
        // margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(border: Border.all(color: AppColors().lightOnlyText, width: 1), color: AppColors().whiteColor),
        child: Center(
          child: DropdownButtonHideUnderline(
            child: DropdownButton2<String>(
              isExpanded: true,
              iconStyleData: IconStyleData(
                icon: Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: Image.asset(
                    AppImages.arrowDown,
                    height: 20,
                    width: 20,
                    color: AppColors().fontColor,
                  ),
                ),
              ),
              dropdownStyleData: const DropdownStyleData(maxHeight: 150),
              hint: Text(
                '',
                style: TextStyle(
                  fontSize: 14,
                  fontFamily: CustomFonts.family1Medium,
                  color: AppColors().darkText,
                ),
              ),
              items: arrPeriodList
                  .map((String item) => DropdownMenuItem<String>(
                        value: item,
                        child: Text(item, style: TextStyle(fontSize: 14, fontFamily: CustomFonts.family1Medium, color: AppColors().grayColor)),
                      ))
                  .toList(),
              selectedItemBuilder: (context) {
                return arrPeriodList
                    .map((String item) => DropdownMenuItem<String>(
                          value: item,
                          child: Text(
                            item,
                            style: TextStyle(
                              fontSize: 14,
                              fontFamily: CustomFonts.family1Medium,
                              color: AppColors().darkText,
                            ),
                          ),
                        ))
                    .toList();
              },
              value: selectedPeriod.value.isEmpty ? null : selectedPeriod.value,
              onChanged: (String? value) {
                selectedPeriod.value = value!;
              },
              buttonStyleData: const ButtonStyleData(
                padding: EdgeInsets.symmetric(horizontal: 0),
                height: 40,
                // width: 140,
              ),
              menuItemStyleData: const MenuItemStyleData(
                height: 40,
              ),
            ),
          ),
        ));
  });
}

Widget allScriptListDropDown(Rx<GlobalSymbolData> selectedScriptFromFilter, {List<GlobalSymbolData>? arrSymbol, double? width}) {
  return Obx(() {
    if (arrSymbol != null && arrSymbol.isNotEmpty) {
      return Container(
          width: width ?? 250,
          decoration: BoxDecoration(color: AppColors().whiteColor, border: Border.all(color: AppColors().lightOnlyText, width: 1)),
          child: Center(
            child: DropdownButtonHideUnderline(
              child: DropdownButton2<GlobalSymbolData>(
                isExpanded: true,
                iconStyleData: IconStyleData(
                  icon: Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: Image.asset(
                      AppImages.arrowDown,
                      height: 20,
                      width: 20,
                      color: AppColors().fontColor,
                    ),
                  ),
                ),
                dropdownSearchData: DropdownSearchData(
                  searchController: scriptEditingController,
                  searchInnerWidgetHeight: 50,
                  searchInnerWidget: Container(
                    height: 40,
                    // padding: EdgeInsets.only(top: 2.w, right: 2.w, left: 2.w),
                    child: CustomTextField(
                      type: '',
                      keyBoardType: TextInputType.text,
                      isEnabled: true,
                      isOptional: false,
                      inValidMsg: "",
                      placeHolderMsg: "Search Script",
                      emptyFieldMsg: "",
                      controller: scriptEditingController,
                      focus: scriptEditingFocus,
                      isSecure: false,
                      borderColor: AppColors().grayLightLine,
                      keyboardButtonType: TextInputAction.done,
                      maxLength: 64,
                      prefixIcon: Image.asset(
                        AppImages.searchIcon,
                        height: 20,
                        width: 20,
                      ),
                      suffixIcon: Container(
                        child: GestureDetector(
                          onTap: () {
                            scriptEditingController.clear();
                          },
                          child: Image.asset(
                            AppImages.crossIcon,
                            height: 20,
                            width: 20,
                          ),
                        ),
                      ),
                    ),
                  ),
                  searchMatchFn: (item, searchValue) {
                    return item.value!.symbolTitle.toString().toLowerCase().startsWith(searchValue.toLowerCase());
                  },
                ),
                dropdownStyleData: const DropdownStyleData(maxHeight: 250),
                hint: Text(
                  '',
                  style: TextStyle(fontSize: 14, fontFamily: CustomFonts.family1Medium, color: AppColors().darkText, overflow: TextOverflow.ellipsis),
                ),
                items: arrSymbol
                    .map((GlobalSymbolData item) => DropdownMenuItem<GlobalSymbolData>(
                          value: item,
                          child: Text(item.symbolTitle ?? "", style: TextStyle(fontSize: 14, fontFamily: CustomFonts.family1Medium, color: AppColors().darkText, overflow: TextOverflow.ellipsis)),
                        ))
                    .toList(),
                selectedItemBuilder: (context) {
                  return arrSymbol
                      .map((GlobalSymbolData item) => DropdownMenuItem<String>(
                            value: item.symbolTitle,
                            child: Text(
                              item.symbolTitle ?? "",
                              style: TextStyle(fontSize: 14, fontFamily: CustomFonts.family1Medium, color: AppColors().darkText, overflow: TextOverflow.ellipsis),
                            ),
                          ))
                      .toList();
                },
                value: selectedScriptFromFilter.value.exchangeId != null ? selectedScriptFromFilter.value : null,
                onChanged: (GlobalSymbolData? value) {
                  // // setState(() {
                  // controller.selectedScriptFromAll = value;
                  // controller.update();
                  // // });

                  selectedScriptFromFilter.value = value!;
                },
                buttonStyleData: const ButtonStyleData(
                  padding: EdgeInsets.symmetric(horizontal: 0),
                  height: 40,
                  // width: 140,
                ),
                menuItemStyleData: const MenuItemStyleData(
                  height: 40,
                ),
              ),
            ),
          ));
    } else {
      return Container(
          width: width ?? 250,
          decoration: BoxDecoration(color: AppColors().whiteColor, border: Border.all(color: AppColors().lightOnlyText, width: 1)),
          child: Center(
            child: DropdownButtonHideUnderline(
              child: DropdownButton2<GlobalSymbolData>(
                isExpanded: true,
                iconStyleData: IconStyleData(
                  icon: Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: Image.asset(
                      AppImages.arrowDown,
                      height: 20,
                      width: 20,
                      color: AppColors().fontColor,
                    ),
                  ),
                ),
                dropdownSearchData: DropdownSearchData(
                  searchController: scriptEditingController,
                  searchInnerWidgetHeight: 50,
                  searchInnerWidget: Container(
                    height: 40,
                    // padding: EdgeInsets.only(top: 2.w, right: 2.w, left: 2.w),
                    child: CustomTextField(
                      type: '',
                      keyBoardType: TextInputType.text,
                      isEnabled: true,
                      isOptional: false,
                      inValidMsg: "",
                      placeHolderMsg: "Search Script",
                      emptyFieldMsg: "",
                      controller: scriptEditingController,
                      focus: scriptEditingFocus,
                      isSecure: false,
                      borderColor: AppColors().grayLightLine,
                      keyboardButtonType: TextInputAction.done,
                      maxLength: 64,
                      prefixIcon: Image.asset(
                        AppImages.searchIcon,
                        height: 20,
                        width: 20,
                      ),
                      suffixIcon: Container(
                        child: GestureDetector(
                          onTap: () {
                            scriptEditingController.clear();
                          },
                          child: Image.asset(
                            AppImages.crossIcon,
                            height: 20,
                            width: 20,
                          ),
                        ),
                      ),
                    ),
                  ),
                  searchMatchFn: (item, searchValue) {
                    return item.value!.symbolTitle.toString().toLowerCase().startsWith(searchValue.toLowerCase());
                  },
                ),
                dropdownStyleData: const DropdownStyleData(maxHeight: 250),
                hint: Text(
                  '',
                  style: TextStyle(
                    fontSize: 14,
                    fontFamily: CustomFonts.family1Medium,
                    color: AppColors().darkText,
                  ),
                ),
                items: arrAllScript
                    .map((GlobalSymbolData item) => DropdownMenuItem<GlobalSymbolData>(
                          value: item,
                          child: Text(item.symbolTitle ?? "", style: TextStyle(fontSize: 14, fontFamily: CustomFonts.family1Medium, color: AppColors().darkText)),
                        ))
                    .toList(),
                selectedItemBuilder: (context) {
                  return arrAllScript
                      .map((GlobalSymbolData item) => DropdownMenuItem<String>(
                            value: item.symbolTitle,
                            child: Text(
                              item.symbolTitle ?? "",
                              style: TextStyle(
                                fontSize: 14,
                                fontFamily: CustomFonts.family1Medium,
                                color: AppColors().darkText,
                              ),
                            ),
                          ))
                      .toList();
                },
                value: selectedScriptFromFilter.value.exchangeId != null ? selectedScriptFromFilter.value : null,
                onChanged: (GlobalSymbolData? value) {
                  // // setState(() {
                  // controller.selectedScriptFromAll = value;
                  // controller.update();
                  // // });

                  selectedScriptFromFilter.value = value!;
                },
                buttonStyleData: const ButtonStyleData(
                  padding: EdgeInsets.symmetric(horizontal: 0),
                  height: 40,
                  // width: 140,
                ),
                menuItemStyleData: const MenuItemStyleData(
                  height: 40,
                ),
              ),
            ),
          ));
    }
  });
}

Widget exchangeTypeDropDown(Rx<ExchangeData> selectedExchange, {Function? onChange, double width = 210}) {
  return Container(
    width: width,
    decoration: BoxDecoration(border: Border.all(color: AppColors().lightOnlyText, width: 1), color: AppColors().whiteColor),
    child: Obx(() {
      return Center(
        child: DropdownButtonHideUnderline(
          child: DropdownButton2<ExchangeData>(
            isExpanded: true,
            iconStyleData: IconStyleData(
              icon: Padding(
                padding: const EdgeInsets.only(right: 10),
                child: Image.asset(
                  AppImages.arrowDown,
                  height: 20,
                  width: 20,
                  color: AppColors().fontColor,
                ),
              ),
            ),
            dropdownSearchData: DropdownSearchData(
              searchController: exchangeEditingController,
              searchInnerWidgetHeight: 50,
              searchInnerWidget: Container(
                height: 40,
                // padding: EdgeInsets.only(top: 2.w, right: 2.w, left: 2.w),
                child: CustomTextField(
                  type: '',
                  keyBoardType: TextInputType.text,
                  isEnabled: true,
                  isOptional: false,
                  inValidMsg: "",
                  placeHolderMsg: "Search Exchange",
                  emptyFieldMsg: "",
                  controller: exchangeEditingController,
                  focus: exchangeEditingFocus,
                  isSecure: false,
                  borderColor: AppColors().grayLightLine,
                  keyboardButtonType: TextInputAction.done,
                  maxLength: 64,
                  prefixIcon: Image.asset(
                    AppImages.searchIcon,
                    height: 20,
                    width: 20,
                  ),
                  suffixIcon: Container(
                    child: GestureDetector(
                      onTap: () {
                        exchangeEditingController.clear();
                      },
                      child: Image.asset(
                        AppImages.crossIcon,
                        height: 20,
                        width: 20,
                      ),
                    ),
                  ),
                ),
              ),
              searchMatchFn: (item, searchValue) {
                return item.value!.name.toString().toLowerCase().startsWith(searchValue.toLowerCase());
              },
            ),
            dropdownStyleData: const DropdownStyleData(maxHeight: 250),
            hint: Text(
              '',
              style: TextStyle(
                fontSize: 14,
                fontFamily: CustomFonts.family1Medium,
                color: AppColors().darkText,
              ),
            ),
            items: arrExchange
                .map((ExchangeData item) => DropdownMenuItem<ExchangeData>(
                      value: item,
                      child: Text(
                        item.name ?? "",
                        style: TextStyle(
                          fontSize: 14,
                          fontFamily: CustomFonts.family1Medium,
                          color: AppColors().darkText,
                        ),
                      ),
                    ))
                .toList(),
            selectedItemBuilder: (context) {
              return arrExchange
                  .map((ExchangeData item) => DropdownMenuItem<String>(
                        value: item.name,
                        child: Text(
                          item.name ?? "",
                          style: TextStyle(
                            fontSize: 14,
                            fontFamily: CustomFonts.family1Medium,
                            color: AppColors().darkText,
                          ),
                        ),
                      ))
                  .toList();
            },
            value: selectedExchange.value.name != null ? selectedExchange.value : null,
            onChanged: (ExchangeData? newSelectedValue) {
              // setState(() {
              selectedExchange.value = newSelectedValue!;

              if (onChange != null) {
                onChange();
              }

              // });
            },
            buttonStyleData: const ButtonStyleData(
              padding: EdgeInsets.symmetric(horizontal: 0),
              height: 40,
              // width: 140,
            ),
            menuItemStyleData: const MenuItemStyleData(
              height: 40,
            ),
          ),
        ),
      );
    }),
  );
}

Widget productTypeForAccountDropDown(Rx<Type?> selectedProductType, {double? width}) {
  return Obx(() {
    return Container(
        width: width ?? 250,
        // margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(border: Border.all(color: AppColors().lightOnlyText, width: 1), color: AppColors().whiteColor),
        child: Center(
          child: DropdownButtonHideUnderline(
            child: DropdownButton2<Type>(
              isExpanded: true,
              iconStyleData: IconStyleData(
                icon: Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: Image.asset(
                    AppImages.arrowDown,
                    height: 20,
                    width: 20,
                    color: AppColors().fontColor,
                  ),
                ),
              ),
              dropdownStyleData: const DropdownStyleData(maxHeight: 150),
              hint: Text(
                '',
                style: TextStyle(
                  fontSize: 14,
                  fontFamily: CustomFonts.family1Medium,
                  color: AppColors().darkText,
                ),
              ),
              items: constantValues!.productTypeForAccount!
                  .map((Type item) => DropdownMenuItem<Type>(
                        value: item,
                        child: Text(item.name ?? "", style: TextStyle(fontSize: 14, fontFamily: CustomFonts.family1Medium, color: AppColors().grayColor)),
                      ))
                  .toList(),
              selectedItemBuilder: (context) {
                return constantValues!.productTypeForAccount!
                    .map((Type item) => DropdownMenuItem<Type>(
                          value: item,
                          child: Text(
                            item.name ?? "",
                            style: TextStyle(
                              fontSize: 14,
                              fontFamily: CustomFonts.family1Medium,
                              color: AppColors().darkText,
                            ),
                          ),
                        ))
                    .toList();
              },
              value: selectedProductType.value?.name == null ? null : selectedProductType.value,
              onChanged: (Type? value) {
                selectedProductType.value = value!;
              },
              buttonStyleData: const ButtonStyleData(
                padding: EdgeInsets.symmetric(horizontal: 0),
                height: 40,
                // width: 140,
              ),
              menuItemStyleData: const MenuItemStyleData(
                height: 40,
              ),
            ),
          ),
        ));
  });
}

Widget tradeStatusListDropDown(Rx<Type?> selectedTradeStatus, {double? width}) {
  return Obx(() {
    return Container(
        width: width ?? 250,
        // margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(border: Border.all(color: AppColors().lightOnlyText, width: 1), color: AppColors().whiteColor),
        child: Center(
          child: DropdownButtonHideUnderline(
            child: DropdownButton2<Type>(
              isExpanded: true,
              iconStyleData: IconStyleData(
                icon: Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: Image.asset(
                    AppImages.arrowDown,
                    height: 20,
                    width: 20,
                    color: AppColors().fontColor,
                  ),
                ),
              ),
              dropdownStyleData: const DropdownStyleData(maxHeight: 150),
              hint: Text(
                '',
                style: TextStyle(
                  fontSize: 14,
                  fontFamily: CustomFonts.family1Medium,
                  color: AppColors().darkText,
                ),
              ),
              items: arrTradeStatus
                  .map((Type item) => DropdownMenuItem<Type>(
                        value: item,
                        child: Text(item.name ?? "", style: TextStyle(fontSize: 14, fontFamily: CustomFonts.family1Medium, color: AppColors().grayColor)),
                      ))
                  .toList(),
              selectedItemBuilder: (context) {
                return arrTradeStatus
                    .map((Type item) => DropdownMenuItem<Type>(
                          value: item,
                          child: Text(
                            item.name ?? "",
                            style: TextStyle(
                              fontSize: 14,
                              fontFamily: CustomFonts.family1Medium,
                              color: AppColors().darkText,
                            ),
                          ),
                        ))
                    .toList();
              },
              value: selectedTradeStatus.value?.name == null ? null : selectedTradeStatus.value,
              onChanged: (Type? value) {
                selectedTradeStatus.value = value!;
              },
              buttonStyleData: const ButtonStyleData(
                padding: EdgeInsets.symmetric(horizontal: 0),
                height: 40,
                // width: 140,
              ),
              menuItemStyleData: const MenuItemStyleData(
                height: 40,
              ),
            ),
          ),
        ));
  });
}

Widget tradeAttributeDropDown(RxString selectedTradeStatus, {double? width}) {
  return Obx(() {
    return Container(
        width: width ?? 250,
        // margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(border: Border.all(color: AppColors().lightOnlyText, width: 1), color: AppColors().whiteColor),
        child: Center(
          child: DropdownButtonHideUnderline(
            child: DropdownButton2<String>(
              isExpanded: true,
              iconStyleData: IconStyleData(
                icon: Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: Image.asset(
                    AppImages.arrowDown,
                    height: 20,
                    width: 20,
                    color: AppColors().fontColor,
                  ),
                ),
              ),
              dropdownStyleData: const DropdownStyleData(maxHeight: 150),
              hint: Text(
                '',
                style: TextStyle(
                  fontSize: 14,
                  fontFamily: CustomFonts.family1Medium,
                  color: AppColors().darkText,
                ),
              ),
              items: arrTradeAttribute
                  .map((String item) => DropdownMenuItem<String>(
                        value: item,
                        child: Text(item, style: TextStyle(fontSize: 14, fontFamily: CustomFonts.family1Medium, color: AppColors().grayColor)),
                      ))
                  .toList(),
              selectedItemBuilder: (context) {
                return arrTradeAttribute
                    .map((String item) => DropdownMenuItem<String>(
                          value: item,
                          child: Text(
                            item,
                            style: TextStyle(
                              fontSize: 14,
                              fontFamily: CustomFonts.family1Medium,
                              color: AppColors().darkText,
                            ),
                          ),
                        ))
                    .toList();
              },
              value: selectedTradeStatus.value.isEmpty ? null : selectedTradeStatus.value,
              onChanged: (String? value) {
                selectedTradeStatus.value = value!;
              },
              buttonStyleData: const ButtonStyleData(
                padding: EdgeInsets.symmetric(horizontal: 0),
                height: 40,
                // width: 140,
              ),
              menuItemStyleData: const MenuItemStyleData(
                height: 40,
              ),
            ),
          ),
        ));
  });
}

Widget logTypeListDropDown(RxString selectedLogType, {double? width}) {
  return Obx(() {
    return Container(
        width: width ?? 250,
        // margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(border: Border.all(color: AppColors().lightOnlyText, width: 1), color: AppColors().whiteColor),
        child: Center(
          child: DropdownButtonHideUnderline(
            child: DropdownButton2<String>(
              isExpanded: true,
              iconStyleData: IconStyleData(
                icon: Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: Image.asset(
                    AppImages.arrowDown,
                    height: 20,
                    width: 20,
                    color: AppColors().fontColor,
                  ),
                ),
              ),
              dropdownStyleData: const DropdownStyleData(maxHeight: 150),
              hint: Text(
                '',
                style: TextStyle(
                  fontSize: 14,
                  fontFamily: CustomFonts.family1Medium,
                  color: AppColors().darkText,
                ),
              ),
              items: arrLogType
                  .map((String item) => DropdownMenuItem<String>(
                        value: item,
                        child: Text(item, style: TextStyle(fontSize: 14, fontFamily: CustomFonts.family1Medium, color: AppColors().grayColor)),
                      ))
                  .toList(),
              selectedItemBuilder: (context) {
                return arrLogType
                    .map((String item) => DropdownMenuItem<String>(
                          value: item,
                          child: Text(
                            item,
                            style: TextStyle(
                              fontSize: 14,
                              fontFamily: CustomFonts.family1Medium,
                              color: AppColors().darkText,
                            ),
                          ),
                        ))
                    .toList();
              },
              value: selectedLogType.value.isEmpty ? null : selectedLogType.value,
              onChanged: (String? value) {
                selectedLogType.value = value!;
              },
              buttonStyleData: const ButtonStyleData(
                padding: EdgeInsets.symmetric(horizontal: 0),
                height: 40,
                // width: 140,
              ),
              menuItemStyleData: const MenuItemStyleData(
                height: 40,
              ),
            ),
          ),
        ));
  });
}

Widget userTypeDropDown(Rx<userRoleListData> selectUserdropdownValue, {double? width, double? height, Function? onChange, FocusNode? focus}) {
  dropdownUserTypeKey = GlobalKey();
//  return Obx(() {
//       return Container(
//           width: width ?? 250,
//           height: height ?? 30,
//           padding: EdgeInsets.symmetric(horizontal: 15),
//           decoration: BoxDecoration(
//               border: Border.all(color: focus!.hasFocus ? AppColors().blueColor : AppColors().lightOnlyText, width: 1),
//               color: AppColors().whiteColor),
//           child: DropdownButton<userRoleListData>(
//             focusNode: focus,
//             key: dropdownUserTypeKey,
//             value: selectUserdropdownValue.value,
//             icon: const Icon(Icons.arrow_drop_down),
//             elevation: 16,
//             style: TextStyle(color: AppColors().darkText),
//             underline: Container(
//               height: 2,
//               color: Colors.transparent,
//             ),
//             onChanged: (userRoleListData? value) {
//               // This is called when the user selects an item.
//               selectUserdropdownValue.value = value!;
//             },
//             isExpanded: true,
//             items: arrUserTypeList.map<DropdownMenuItem<userRoleListData>>((userRoleListData value) {
//               return DropdownMenuItem<userRoleListData>(
//                 value: value,
//                 child: Text(value.name!),
//               );
//             }).toList(),
//           )
//           );
//     });

  return Obx(() {
    return Container(
        width: width ?? 250,
        height: height ?? 30,
        decoration: BoxDecoration(border: Border.all(color: AppColors().lightOnlyText, width: 1), color: AppColors().whiteColor),
        child: Center(
          child: DropdownButtonHideUnderline(
            child: DropdownButton2<userRoleListData>(
              isExpanded: true,
              iconStyleData: IconStyleData(
                icon: Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: Image.asset(
                    AppImages.arrowDown,
                    height: 20,
                    width: 20,
                    color: AppColors().fontColor,
                  ),
                ),
              ),
              dropdownStyleData: const DropdownStyleData(maxHeight: 150),
              hint: Text(
                '',
                style: TextStyle(
                  fontSize: 14,
                  fontFamily: CustomFonts.family1Medium,
                  color: AppColors().darkText,
                ),
              ),
              items: arrUserTypeList
                  .map((userRoleListData item) => DropdownMenuItem<userRoleListData>(
                        value: item,
                        child: Text(item.name ?? "", style: TextStyle(fontSize: 14, fontFamily: CustomFonts.family1Regular, color: AppColors().darkText)),
                      ))
                  .toList(),
              selectedItemBuilder: (context) {
                return arrUserTypeList
                    .map((userRoleListData item) => DropdownMenuItem<userRoleListData>(
                          value: item,
                          child: Text(
                            item.name ?? "",
                            style: TextStyle(
                              fontSize: 14,
                              fontFamily: CustomFonts.family1Regular,
                              color: AppColors().darkText,
                            ),
                          ),
                        ))
                    .toList();
              },
              value: selectUserdropdownValue.value.roleId != null ? selectUserdropdownValue.value : null,
              onChanged: (userRoleListData? value) {
                selectUserdropdownValue.value = value!;
                if (onChange != null) {
                  onChange();
                }
              },
              buttonStyleData: const ButtonStyleData(
                padding: EdgeInsets.symmetric(horizontal: 0),
                height: 40,
              ),
              menuItemStyleData: const MenuItemStyleData(
                height: 40,
              ),
            ),
          ),
        ));
  });
}

Widget brokerListDropDown(Rx<BrokerListModelData> selectedBrokerType, {double? width, double? height, Function? onChange}) {
  return Obx(() {
    return Container(
        width: width ?? 250,
        height: height ?? 30,
        decoration: BoxDecoration(border: Border.all(color: AppColors().lightOnlyText, width: 1), color: AppColors().whiteColor),
        child: Center(
          child: DropdownButtonHideUnderline(
            child: DropdownButtonFormField<BrokerListModelData>(
              focusNode: FocusNode(),
              padding: EdgeInsets.zero,
              key: new GlobalKey(),
              menuMaxHeight: 250,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.only(left: 5),
                focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: AppColors().blueColor, width: 1)),
                enabledBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.transparent, width: 0)),
              ),
              value: selectedBrokerType.value,
              icon: const Icon(Icons.arrow_drop_down),
              elevation: 16,
              style: TextStyle(color: AppColors().darkText),
              onChanged: (BrokerListModelData? value) {
                // This is called when the user selects an item.
                selectedBrokerType.value = value!;
                onChange!();
              },
              selectedItemBuilder: (context) {
                return arrBrokerList.map<DropdownMenuItem<BrokerListModelData>>((BrokerListModelData item) {
                  return DropdownMenuItem<BrokerListModelData>(
                    value: item,
                    child: Text(item.name ?? ""),
                  );
                }).toList();
              },
              isExpanded: true,
              items: arrBrokerList.map<DropdownMenuItem<BrokerListModelData>>((BrokerListModelData item) {
                return DropdownMenuItem<BrokerListModelData>(
                  value: item,
                  child: Text(item.name ?? ""),
                );
              }).toList(),
            ),
            // child: DropdownButton2<BrokerListModelData>(
            //   isExpanded: true,
            //   iconStyleData: IconStyleData(
            //     icon: Padding(
            //       padding: const EdgeInsets.only(right: 10),
            //       child: Image.asset(
            //         AppImages.arrowDown,
            //         height: 20,
            //         width: 20,
            //         color: AppColors().fontColor,
            //       ),
            //     ),
            //   ),
            //   dropdownStyleData: DropdownStyleData(maxHeight: 150),
            //   hint: Text(
            //     '',
            //     style: TextStyle(
            //       fontSize: 14,
            //       fontFamily: CustomFonts.family1Medium,
            //       color: AppColors().darkText,
            //     ),
            //   ),
            //   items: arrBrokerList
            //       .map((BrokerListModelData item) => DropdownMenuItem<BrokerListModelData>(
            //             value: item,
            //             child: Text(item.name ?? "",
            //                 style: TextStyle(fontSize: 14, fontFamily: CustomFonts.family1Regular, color: AppColors().darkText)),
            //           ))
            //       .toList(),
            //   selectedItemBuilder: (context) {
            //     return arrBrokerList
            //         .map((BrokerListModelData item) => DropdownMenuItem<BrokerListModelData>(
            //               value: item,
            //               child: Text(
            //                 item.name ?? "",
            //                 style: TextStyle(
            //                   fontSize: 14,
            //                   fontFamily: CustomFonts.family1Regular,
            //                   color: AppColors().darkText,
            //                 ),
            //               ),
            //             ))
            //         .toList();
            //   },
            //   value: selectedBrokerType.value.userId != null ? selectedBrokerType.value : null,
            //   onChanged: (BrokerListModelData? value) {
            //     selectedBrokerType.value = value!;
            //     if (onChange != null) {
            //       onChange();
            //     }
            //   },
            //   buttonStyleData: const ButtonStyleData(
            //     padding: EdgeInsets.symmetric(horizontal: 0),
            //     height: 40,
            //     // width: 140,
            //   ),
            //   menuItemStyleData: const MenuItemStyleData(
            //     height: 40,
            //   ),
            // ),
          ),
        ));
  });
}

// List<AddMaster> selectStatuslist = [];
Widget statusListDropDown(Rx<AddMaster> selectedStatus, {double? width, double? height, Function? onChange}) {
  return Obx(() {
    return Container(
        width: width ?? 250,
        height: height ?? 30,
        decoration: BoxDecoration(border: Border.all(color: AppColors().lightOnlyText, width: 1), color: AppColors().whiteColor),
        child: Center(
          child: DropdownButtonHideUnderline(
            child: DropdownButton2<AddMaster>(
              isExpanded: true,
              iconStyleData: IconStyleData(
                icon: Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: Image.asset(
                    AppImages.arrowDown,
                    height: 20,
                    width: 20,
                    color: AppColors().fontColor,
                  ),
                ),
              ),
              dropdownStyleData: const DropdownStyleData(maxHeight: 150),
              hint: Text(
                '',
                style: TextStyle(
                  fontSize: 14,
                  fontFamily: CustomFonts.family1Medium,
                  color: AppColors().darkText,
                ),
              ),
              items: arrStatuslist
                  .map((AddMaster item) => DropdownMenuItem<AddMaster>(
                        value: item,
                        child: Text(item.name ?? "", style: TextStyle(fontSize: 14, fontFamily: CustomFonts.family1Regular, color: AppColors().darkText)),
                      ))
                  .toList(),
              selectedItemBuilder: (context) {
                return arrStatuslist
                    .map((AddMaster item) => DropdownMenuItem<AddMaster>(
                          value: item,
                          child: Text(
                            item.name ?? "",
                            style: TextStyle(
                              fontSize: 14,
                              fontFamily: CustomFonts.family1Regular,
                              color: AppColors().darkText,
                            ),
                          ),
                        ))
                    .toList();
              },
              value: selectedStatus.value.id != null ? selectedStatus.value : null,
              onChanged: (AddMaster? value) {
                selectedStatus.value = value!;
                if (onChange != null) {
                  onChange();
                }
              },
              buttonStyleData: const ButtonStyleData(
                padding: EdgeInsets.symmetric(horizontal: 0),
                height: 40,
                // width: 140,
              ),
              menuItemStyleData: const MenuItemStyleData(
                height: 40,
              ),
            ),
          ),
        ));
  });
}

Widget orderTypeDropDown(Rx<Type> selectedOrderType, {double? width, double? height, Function? onChange}) {
  return Obx(() {
    return Container(
        width: width ?? 250,
        height: height ?? 30,
        decoration: BoxDecoration(border: Border.all(color: AppColors().lightOnlyText, width: 1), color: AppColors().whiteColor),
        child: Center(
          child: DropdownButtonHideUnderline(
            child: DropdownButton2<Type>(
              isExpanded: true,
              iconStyleData: IconStyleData(
                icon: Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: Image.asset(
                    AppImages.arrowDown,
                    height: 20,
                    width: 20,
                    color: AppColors().fontColor,
                  ),
                ),
              ),
              dropdownStyleData: const DropdownStyleData(maxHeight: 150),
              hint: Text(
                '',
                style: TextStyle(
                  fontSize: 14,
                  fontFamily: CustomFonts.family1Medium,
                  color: AppColors().darkText,
                ),
              ),
              items: constantValues!.orderTypeFilter!
                  .map((Type item) => DropdownMenuItem<Type>(
                        value: item,
                        child: Text(item.name ?? "", style: TextStyle(fontSize: 14, fontFamily: CustomFonts.family1Regular, color: AppColors().darkText)),
                      ))
                  .toList(),
              selectedItemBuilder: (context) {
                return constantValues!.orderTypeFilter!
                    .map((Type item) => DropdownMenuItem<Type>(
                          value: item,
                          child: Text(
                            item.name ?? "",
                            style: TextStyle(
                              fontSize: 14,
                              fontFamily: CustomFonts.family1Regular,
                              color: AppColors().darkText,
                            ),
                          ),
                        ))
                    .toList();
              },
              value: selectedOrderType.value.id != null ? selectedOrderType.value : null,
              onChanged: (Type? value) {
                selectedOrderType.value = value!;
                if (onChange != null) {
                  onChange();
                }
              },
              buttonStyleData: const ButtonStyleData(
                padding: EdgeInsets.symmetric(horizontal: 0),
                height: 40,
                // width: 140,
              ),
              menuItemStyleData: const MenuItemStyleData(
                height: 40,
              ),
            ),
          ),
        ));
  });
}

showCalenderPopUp(DateTime fromDate, Function onDateSelection) {
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
              width: 450,
              height: 450,
              decoration: BoxDecoration(border: Border.all(color: AppColors().lightOnlyText, width: 1)),
              child: CalendarCarousel<Event>(
                onDayPressed: (DateTime date, List<Event> events) {
                  onDateSelection(date);
                  Get.back();
                },
                weekendTextStyle: TextStyle(
                  color: Colors.red,
                ),
                thisMonthDayBorderColor: Colors.transparent,
                weekFormat: false,

                height: 420.0,
                selectedDateTime: fromDate,
                daysHaveCircularBorder: false,

                /// null for not rendering any border, true for circular border, false for rectangular border
              ),
            ),
          ));
}

Future<void> selectFromDate(RxString fromDate) async {
  final DateTime? picked = await showDatePicker(
    context: Get.context!,
    initialDate: DateTime.now(),
    firstDate: DateTime(2020),
    lastDate: DateTime.now(),
    helpText: 'Select From Date',
    cancelText: 'Cancel',
    confirmText: 'Done',

    // locale: Locale('en', 'US'),
  );

  if (picked != null) {
    // Format the DateTime to display only the date portion
    String formattedDate = DateFormat('yyyy-MM-dd').format(picked);
    //print(formattedDate);

    fromDate.value = formattedDate;

    // _selectToDate(context);
  }
}

Future<void> selectToDate(RxString endDate) async {
  final DateTime? picked = await showDatePicker(
    context: Get.context!,
    initialDate: DateTime.now(),
    firstDate: DateTime(2020),
    lastDate: DateTime.now(),
    helpText: 'Select To Date',
    cancelText: 'Cancel',
    confirmText: 'Done',
    // locale: Locale('en', 'US'),
  );

  if (picked != null) {
    // Format the DateTime to display only the date portion
    String formattedDate = DateFormat('yyyy-MM-dd').format(picked);
    //print(formattedDate);
    endDate.value = formattedDate;

    // _selectToDate(context);
  }
}

getExchangeList() async {
  var response = await service.getExchangeListCall();
  if (response != null) {
    if (response.statusCode == 200) {
      arrExchange = response.exchangeData ?? [];
    }
  }
}

getScriptList({String exchangeId = "", List<GlobalSymbolData>? arrSymbol}) async {
  var response = await service.allSymbolListCall(1, "", exchangeId);
  if (arrSymbol != null) {
    arrSymbol.clear();

    arrSymbol.addAll(response!.data ?? []);
  } else {
    arrAllScript = response!.data ?? [];
  }
}

getUserList() async {
  var response = await service.getMyUserListCall();
  arrUserList = response!.data ?? [];
}

callForBrokerList() async {
  var response = await service.brokerListCall();
  if (response != null) {
    if (response.statusCode == 200) {
      arrBrokerList = response.data!;
      arrBrokerList.insert(0, BrokerListModelData(name: "Select Broker"));
      //print("Brocker List");
    } else {
      showErrorToast(response.meta!.message ?? "");
    }
  } else {
    showErrorToast(AppString.generalError);
  }
}

callForRoleList() async {
  var response = await service.userRoleListCall();
  if (response != null) {
    if (response.statusCode == 200) {
      arrUserTypeList = response.data!;
    }
  }
}

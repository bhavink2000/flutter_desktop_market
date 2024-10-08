class AppString {
  static const String emptyUserType = "Please Select User Type.";
  static const String emptyServer = "Please Enter Server Name.";
  static const String invalidServer = "Please enter valid server name.";
  static const String emptyUserName = "Please Enter User Name.";
  static const String notSelectedUserName = "Please select User Name.";
  static const String emptyAmount = "Please Enter Amount";
  static const String emptyComment = "Please Enter Comment.";
  static const String rangeUserName = "User Name Should Be Min 4 Characters.";
  static const String emptyPassword = "Please Enter Your password.";
  static const String emptyCurrentPassword = "Please Enter Your current password.";
  static const String wrongPassword = "Password Should be Atleast 6 Characters.";
  static const String wrongRetypePassword = "Retype Password Should be Atleast 6 Characters.";
  static const String mobileNumberLength = "Mobile Number Should Not be Less than 10 Characters.";
  static const String cutOffValid = "Cut Off Should be Between 60% to 100%.";
  static const String emptyConfirmPassword = "Please Confirm Your Password.";
  static const String passwordNotMatch = "Your Password And Retype Password Doesn't Match.";
  static const String emptyMobileNumber = "Enter Mobile Number.";
  static const String emptyQty = "Please Enter Quantity.";
  static const String inValidQty = "Please Enter valid Quantity.";
  static const String inValidLot = "Please select lot.";
  static const String emptyCutOff = "Please Cut Off.";
  static const String emptyTradeDisplayFor = "Please select trade display for";
  static const String emptyCredit = "Please Credit.";
  static const String emptyPrice = "Please Enter Price.";
  static const String generalError = "Something Went Wrong.";
  static const String emptyName = "Please Enter Name.";
  static const String emptyRemark = "Please Enter Remark.";
  static const String emptyProfitLossSharing = "Please Enter Profit and Loss Sharing .";
  static const String rangeProfitLossSharing = "Profit and Loss Should Be Between 0 to 100 %.";
  static const String emptyBrokerageSharing = "Please Enter Brokerage Sharing.";
  static const String rangeBrokerageSharing = "Brokerage Should be Between 0 to 100 %.";
  static const String emptyLotMax = "Please enter max lot";
  static const String emptyqtyMax = "Please enter quantity max";
  static const String emptybrkQty = "Please enter breakup quantity";
  static const String emptybrkLot = "Please enter breakup lot";
  static const String emptyScriptSelection = "Please select script";
  static const String emptyExchangeGroup = "Please select atleast one exchange group";
  static const String emptyExchange = "Please select exchange.";
  static const String emptyScript = "Please select script.";
}

class ListCellWidth {
  double small = 63;
  double normal = 110;
  double big = 150;
  double bigForDate = 170;
  double large = 280;
  double extraLarge = 500;
}

class ListCellWidthForMarket {
  double small = 60;
  double normal = 112;
  double big = 152;
  double bigForDate = 162;
  double large = 190;
  double extraLarge = 500;
}

class LocalStorageKeys {
  static const String userToken = "userToken";
  static const String userId = "userId";
  static const String userData = "userData";
  static const String userType = "userType";
  static const String isDetailSciptOn = "isDetailSciptOn";
  static const String isDarkMode = "isDarkMode";
  static const String isStatusBarVisible = "isStatusBarVisible";
  static const String isToolBarVisible = "isToolBarVisible";
}

class TradeMarginClass {
  static const String isFromTradeMarginClass = "";
}

class CommonCustomDateSelection {
  List<String> arrCustomDate = <String>['This Week \n24-07-2023 to 30-07-2023', 'Previous Week \n17-07-2023 to 23-07-2023', 'Custom Period'];
}

class UserRollList {
  static const String superAdmin = "64b63755c71461c502ea4713";
  static const String admin = "64b63755c71461c502ea4714";
  static const String master = "64b63755c71461c502ea4715";
  static const String broker = "64b63755c71461c502ea4716";
  static const String user = "64b63755c71461c502ea4717";
}

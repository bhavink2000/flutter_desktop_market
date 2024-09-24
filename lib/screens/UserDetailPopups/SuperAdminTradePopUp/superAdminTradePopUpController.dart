import 'package:get/get.dart';

import '../../../constant/utilities.dart';
import '../../../modelClass/allSymbolListModelClass.dart';
import '../../../modelClass/exchangeListModelClass.dart';
import '../../../constant/index.dart';
import '../../../modelClass/superAdminTradePopUpModelClass.dart';
import '../../MainContainerScreen/mainContainerController.dart';
import '../../MainTabs/ViewTab/MarketWatchScreen/marketWatchController.dart';
import '../../MainTabs/ViewTab/TradeScreen/successTradeListController.dart';
import '../../MainTabs/ViewTab/TradeScreen/successTradeListWrapper.dart';

enum AllowedTrade { NotApplication, Yes, No }

class SuperAdminTradePopUpController extends BaseController {
  //*********************************************************************** */
  // Variable Declaration
  //*********************************************************************** */
  bool isFilterOpen = true;
  RxString fromDate = "Start Date".obs;
  RxString endDate = "End Date".obs;

  RxString selectedUser = "".obs;
  RxString selectedTradeStatus = "".obs;
  Rx<ExchangeData> selectedExchange = ExchangeData().obs;
  Rx<GlobalSymbolData> selectedScriptFromFilter = GlobalSymbolData().obs;
  SuperAdminPopUpModel? values;

  AllowedTrade? selectedAllowedTrade = AllowedTrade.NotApplication;

  redirectTradeScreen() async {
    var marketViewObj = Get.find<MarketWatchController>();
    if (marketViewObj.isBuyOpen != -1) {
      return;
    }

    var dashBoardVC = Get.find<MainContainerController>();
    dashBoardVC.isCreateUserClick = false;
    dashBoardVC.isNotificationSettingClick = false;
    dashBoardVC.update();
    if (!dashBoardVC.arrAvailableTabs.contains("Trades")) {
      var tradeVC = Get.put(SuccessTradeListController());

      tradeVC.selectedExchange.value = arrExchange.firstWhereOrNull((element) => element.exchangeId == values!.exchangeId!) ?? ExchangeData();
      await getScriptList(exchangeId: tradeVC.selectedExchange.value.exchangeId!, arrSymbol: tradeVC.arrExchangeWiseScript);
      tradeVC.selectedScriptFromFilter.value = tradeVC.arrExchangeWiseScript.firstWhereOrNull((element) => element.symbolId == values!.symbolId!) ?? GlobalSymbolData();
      tradeVC.fromDate.value = serverFormatDateTime(values!.startDate!);
      tradeVC.endDate.value = serverFormatDateTime(values!.endDate!);

      dashBoardVC.arrAvailableTabs.insert(0, "Trades");
      Get.back();

      // tradeVC.getTradeList(isFromClear: true);
      dashBoardVC.arrAvailableController.insert(0, tradeVC);
      dashBoardVC.widgetOptions.insert(0, SuccessTradeListScreen());
      dashBoardVC.selectedCurrentTabIndex = dashBoardVC.widgetOptions.indexWhere(
        (element) => element is SuccessTradeListScreen,
      );
      dashBoardVC.selectedCurrentTab = "Trades";
      dashBoardVC.updateSelectedView();
      dashBoardVC.updateUnSelectedView();
      dashBoardVC.update();

      Get.delete<SuperAdminTradePopUpController>();
    } else {
      var tradeVC = Get.find<SuccessTradeListController>();

      tradeVC.selectedExchange.value = arrExchange.firstWhereOrNull((element) => element.exchangeId == values!.exchangeId!) ?? ExchangeData();
      await getScriptList(exchangeId: tradeVC.selectedExchange.value.exchangeId!, arrSymbol: tradeVC.arrExchangeWiseScript);
      tradeVC.selectedScriptFromFilter.value = tradeVC.arrExchangeWiseScript.firstWhereOrNull((element) => element.symbolId == values!.symbolId!) ?? GlobalSymbolData();
      tradeVC.fromDate.value = serverFormatDateTime(values!.startDate!);
      tradeVC.endDate.value = serverFormatDateTime(values!.endDate!);
      tradeVC.update();

      Get.back();
      dashBoardVC.selectedCurrentTabIndex = dashBoardVC.widgetOptions.indexWhere(
        (element) => element is SuccessTradeListScreen,
      );
      tradeVC.getTradeList();
      dashBoardVC.selectedCurrentTab = "Trades";
      dashBoardVC.updateSelectedView();
      dashBoardVC.updateUnSelectedView();
      dashBoardVC.update();
    }
  }
}

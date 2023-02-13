import 'package:get/get.dart';

import '../../constants/dummy_data.dart';
import '../../models/event_model.dart';

class OngoingBookingsController extends GetxController {
  List<EventModel> eventList = [];
  getData() async {
    eventList.clear();
    for (var i in DummyData.eventsData) {
      eventList.add(
        EventModel.fromJson(i),
      );
    }
    return eventList;
  }

  @override
  void onInit() {
    super.onInit();
    getData();
  }
}

import 'package:agents_app/models/position/position_model.dart';
// import 'package:agents_app/models/presence/presence_model.dart';
import 'package:agents_app/models/schedule/schedule_days_model.dart';
import 'package:agents_app/services/toast_service.dart';
import 'package:agents_app/views/agent/service/my_presence_service.dart';
import 'package:agents_app/views/positions/services/position_services.dart';
import 'package:geolocator/geolocator.dart';

import 'package:get/get.dart';

class AgentPresenceController extends GetxController {
  MyPresenceService presenceService = MyPresenceService();

  // final RxList<Presence> presences = <Presence>[].obs;
  final RxBool isLoading = true.obs;

  PositionServices positionServices = PositionServices();
  final RxList<PositionModel> positions = <PositionModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    // fetchPresences();
  }

  fetchMyPositions(String? employeeId) async {
    try {
      isLoading.value = true;
      final response = await positionServices.getAllPositionsByAgentId(employeeId!);
      if (response.isNotEmpty) {
        positions.value = response;
      } else {
        ToastService.warning(
            title: "Posiciones", subTitle: "No se encontraron posiciones.");
      }
    } catch (e) {
      ToastService.error(
        title: "Posiciones",
        subTitle: "Ocurrió un error al cargar las posiciones: $e",
      );
    } finally {
      isLoading.value = false;
    }
  }

  String? findDayOfTurn(PositionModel position) {
    final schedule = position.turn?.schedule.firstWhere(
      (schedule) {
        final scheduleDayId = int.tryParse(schedule.day?.id ?? '');
        return scheduleDayId == DateTime.now().weekday ;
      },
      orElse: () =>
          DailySchedule(initTime: "", endTime: "", daysId: 0, day: null),
    );
    return schedule?.day?.id;
  }

  Future<bool> markPresenceAsStarted(String positionId, String employeeId) async {
    try {
      // final dayId = findDayOfTurn(position);

      // final presence =
      //     position.presence?.firstWhere((presence) => presence.dayId == null, orElse: () => PresenceModel(id: null, dayId: null, startTime: null, endTime: null));
      final currentPosition = await determinePosition();

      isLoading.value = true;
      final response = await presenceService.initPresenceEmployee({
        "employeeId": employeeId,
        "positionId": positionId,
        "latitude": currentPosition.latitude,
        "longitude": currentPosition.longitude,
      });
      if (response) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      ToastService.error(
          title: "Error",
          subTitle: "Ocurrió un error al iniciar la asistencia: $e");
    } finally {
      isLoading.value = false;
    }

    return false;
  }

  Future<bool?> markPresenceAsEnded(String positionId, String employeeId) async {
    try {
      // position.presence?.sort((a, b) => a.id!.compareTo(b.id!));
      // final List<PresenceModel>? presence = position.presence ?? [];

      isLoading.value = true;
      final currentPosition = await determinePosition();
      final response = await presenceService.markPresenceAsEnded({
        "endLatitud": currentPosition.latitude.toString(),
        "endLongitud": currentPosition.longitude.toString(),
        "positionId": positionId,
        "presenceId": employeeId
      });

      if (response) {
        return true;
      }
    } catch (e) {
      ToastService.error(
          title: "Error",
          subTitle: "Ocurrió un error al finalizar la asistencia: $e");
    } finally {
      isLoading.value = false;
    }

    return null;
  }

  Future<Position> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition();
  }
}

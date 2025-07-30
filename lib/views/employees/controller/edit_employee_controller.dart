import 'package:agents_app/models/common/dropdown_option_model.dart';
import 'package:agents_app/services/toast_service.dart';
import 'package:agents_app/views/employees/controller/manage_employee_controller.dart';

class EditEmployeeController {
  // final ManageEmployeeController controller;

//   setEmployeeValues(String? employeeId) async{
//     print("Setting employee values for ID: $employeeId");
//     if (employeeId == null || employeeId.isEmpty) {
//      ToastService.error(title: "Empleado", subTitle: "El ID del empleado no puede estar vacío");
//       return;
//     }
//     final employeeData = await employeeService.getById(employeeId);
//     performanceMunicipalities.value = await genericListController.fetchMunicipalitiesOnly(employeeData.performanceDepartment?.id ?? "0");
//     departmentsHome.value = await genericListController.fetchMunicipalitiesOnly(employeeData.performanceDepartment?.id ?? "0");
//     print("performanceMunicipalities: ${performanceMunicipalities.length}");


//     // agencyController.value = DropDownOption(id: employeeData.agency?.id ?? "" , label: employeeData.agency?.name ?? "");
//     employeeTypeController.value = DropDownOption(id: employeeData.employeeType?.id ?? "", label: employeeData.employeeType?.name ?? "");
//     maritalStatusController.value = DropDownOption(id: employeeData.maritalStatus?.id ?? "", label: employeeData.maritalStatus?.name ?? "");
//     bankController.value = DropDownOption(id: employeeData.bank?.id ?? "", label: employeeData.bank?.name ?? "");
//     // NIVEL DE CLASIFICACIÓN classificationLevelController
//     hrProfileController.value = DropDownOption(id: employeeData.hrProfile?.id ?? "", label: employeeData.hrProfile?.name ?? "");
//     // CLASIFICACIÓN DEL PUESTO
//     classificationController.value = DropDownOption(id: employeeData.employeeClassification?.id ?? "", label: employeeData.employeeClassification?.name ?? "");
//     performanceMunicipalityController.value = DropDownOption(id: employeeData.performanceMunicipality?.id ?? "", label: employeeData.performanceMunicipality?.name?? "");
//     print("performanceMunicipalityController: ${performanceMunicipalityController.value.label}");

//     countryOfBirthController.value = DropDownOption(id: employeeData.birthCountry?.id ?? "", label: employeeData.birthCountry?.name?? "");
//     municipalityHomeController.value = DropDownOption(id: employeeData.municipalityHome?.id ?? "", label: employeeData.municipalityHome?.name?? "");
//     municipalityOfBirthController.value = DropDownOption(id: employeeData.birthMunicipality?.id ?? "", label: employeeData.birthMunicipality?.name?? "");


//     performanceDepartmentController.value = DropDownOption(id: employeeData.performanceDepartment?.id ?? "", label: employeeData.performanceDepartment?.name?? "");
//     identificationTypeController.value = DropDownOption(id: employeeData.identificationType?.id ?? "", label: employeeData.identificationType?.name?? "");
//     licenseTypeController.value = DropDownOption(id: employeeData.licenseType?.id ?? "", label: employeeData.licenseType?.name?? "");
//     educationLevelController.value = DropDownOption(id: employeeData.educationLevel?.id ?? "", label: employeeData.educationLevel?.name?? "");
//     professionController.value = DropDownOption(id: employeeData.profession?.id ?? "", label: employeeData.profession?.name?? "");
//     supervisorController.value = DropDownOption(id: employeeData.supervisorWorker?.id ?? "", label: employeeData.supervisorWorker?.name?? "");
//     departmentHomeController.value = DropDownOption(id: employeeData.departmentHome?.id ?? "", label: employeeData.departmentHome?.name?? "");
//     residenceMunicipalityController.value = DropDownOption(id: employeeData.residenceMunicipality?.id ?? "", label: employeeData.residenceMunicipality?.name?? "");
//     residenceDepartmentController.value = DropDownOption(id: employeeData.residenceDepartment?.id ?? "", label: employeeData.residenceDepartment?.name?? "");


//     isLoadingPerformanceMunicipalities.value = false;

//     print("Setting employee values for ID: END");
//   }

}
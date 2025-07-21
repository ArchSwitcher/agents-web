import 'package:agents_app/models/common/dropdown_option_model.dart';

List<String> bloodListMock = [
  "A+",
  "A-",
  "B+",
  "B-",
  "AB+",
  "AB-",
  "O+",
  "O-",
];

List<String> civilStatusMock = ["Casado", "Soltero"];

List<String> genderMock = ["Masculino", "Femenino", "Otro"];

List<String> ethnicityMock = [
  "Mestizo",
  "Indígena",
  "Afrodescendiente",
  "Blanco",
  "Otro"
];

List<String> languageMock = ["Español", "Inglés"];

List<String> relationshipsMock = [
  'Padre',
  'Madre',
  'Hijo',
  'Hija',
  'Hermano',
  'Hermana',
  'Abuelo',
  'Abuela',
  'Nieto',
  'Nieta',
  'Tío',
  'Tía',
  'Sobrino',
  'Sobrina',
  'Primo',
  'Prima',
  'Padrastro',
  'Madrastra',
  'Hijastro',
  'Hijastra',
  'Cuñado',
  'Cuñada',
  'Suegro',
  'Suegra',
  'Yerno',
  'Nuera',
  'Esposo',
  'Esposa',
  'Pareja',
  'Tutor',
  'Ahijado',
  'Ahijada',
  'Hermano político',
  'Hermana política',
  'Otro'
];

List<String> operationalProfileMock = [
  "A-Oficial",
  "B-Coordinador de grupo",
  "C-Supervisor",
  "D-Patrullero",
  "E-Oficial para bancos"
];

List<String> jobTypeMock = [
  "Tiempo completo",
  "Medio tiempo",
  "Contrato",
  "Temporal",
  "Prácticas"
];

List<String> paymentTypeMock = ["Efectivo", "Transferencia", "Cheque"];

List<DropDownOption> banksMock = [
  DropDownOption(id: "1", label: "Banco Industrial"),
  DropDownOption(id: "2", label: "Banco G&T Continental"),
  DropDownOption(id: "3", label: "Banco de Desarrollo Rural (BANRURAL)"),
  DropDownOption(id: "4", label: "Banco Agromercantil (BAM)"),
  DropDownOption(id: "5", label: "Banco Internacional"),
  DropDownOption(id: "6", label: "Banco Promerica"),
  DropDownOption(id: "7", label: "Banco Ficohsa Guatemala"),
  DropDownOption(id: "8", label: "Banco Azteca"),
  DropDownOption(id: "9", label: "Banco Inmobiliario"),
  DropDownOption(id: "10", label: "Banco de los Trabajadores (BANTRAB)"),
  DropDownOption(id: "11", label: "Banco CHN (Crédito Hipotecario Nacional)"),
];

List<DropDownOption> agenciesMock = [
  DropDownOption(id: "1", label: "Agencia Central"),
  DropDownOption(id: "2", label: "Agencia Norte"),
  DropDownOption(id: "3", label: "Agencia Sur"),
  DropDownOption(id: "4", label: "Agencia Este"),
  DropDownOption(id: "5", label: "Agencia Oeste"),
];

List<DropDownOption> positionMock = [
  DropDownOption(id: "1", label: "Asesor"),
  DropDownOption(id: "5", label: "Agente"),
  DropDownOption(id: "2", label: "Jefe de territorio"),
  DropDownOption(id: "3", label: "Jefe de cuentas clave"),
  DropDownOption(id: "4", label: "Cobrador")
];

List<DropDownOption> statusTypePositionMock = [
  DropDownOption(id: "1", label: "Activo"),
  DropDownOption(id: "2", label: "Rechazado"),
  DropDownOption(id: "3", label: "En proceso"),
];


List<DropDownOption> currencyMock = [
  DropDownOption(id: "QTZ", label: "Quetzal"),
  DropDownOption(id: "USD", label: "Dolar"),
];
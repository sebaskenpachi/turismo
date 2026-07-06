import 'package:flutter_test/flutter_test.dart';
import 'package:rutas_panama_mvp/main.dart';

void main() {
  testWidgets('renders the route list home screen', (tester) async {
    await tester.pumpWidget(const RutasPanamaApp());

    expect(find.text('Rutas Panamá'), findsWidgets);
    expect(find.text('Ruta Cerro Ancón'), findsOneWidget);
    expect(find.text('Ruta Cinta Costera'), findsOneWidget);
    expect(find.text('Ruta Casco Antiguo'), findsOneWidget);
  });
}

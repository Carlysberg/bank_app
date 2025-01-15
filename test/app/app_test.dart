import "package:bank/main.dart";
import "package:bank/pickImage_and_cropImage/repository/image_repository.dart";
import "package:flutter_test/flutter_test.dart";

void main() {
  final imageRepository = DefaultImageRepository();
  group("App", () {
    testWidgets("renders Bank App", (tester) async {
      await tester.pumpWidget(
        Bank(
          imageRepository: imageRepository,
        ),
      );
      expect(find.byType(Bank), findsOneWidget);
    });
  });
}

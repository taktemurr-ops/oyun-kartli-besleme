import 'package:flutter_test/flutter_test.dart';
import 'package:oyun_kartli_besleme/oyun_kartli_besleme.dart';
import 'package:studio_core/core/level_plan.dart';

void main() {
  test('33 dilde ad ve anlatım', () {
    expect(kartliBeslemeConfig.title.length, 33);
    expect(kartliBeslemeConfig.tagline.length, 33);
    for (final s in kartliBeslemeConfig.tutorial) {
      expect(s.text.length, 33);
    }
    expect(kartliBeslemeConfig.gameId, kartliBeslemeId);
    expect(kartliBeslemeRules.gameId, kartliBeslemeId);
    expect(kartliBeslemeRules.levelCount, 100000);
  });

  test('bölümler üretilir ve doğrulanır', () {
    expect(kartliBeslemeRules.localPlayers, 2);
    final planner = LevelPlanner(gameId: kartliBeslemeId, optionalMechanics: const []);
    for (final lv in [1, 77, 1500, 33333, 99999]) {
      final gl = kartliBeslemeRules.build(planner.spec(lv));
      expect(gl.validation.ok, isTrue, reason: 'bölüm $lv');
      final back = gl.puzzle.rules.parse(gl.puzzle.start.serialize());
      expect(back.serialize(), gl.puzzle.start.serialize());
    }
  }, timeout: const Timeout(Duration(minutes: 8)));
}

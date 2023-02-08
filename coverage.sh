function coverage() {
  flutter test --coverage
  lcov --remove coverage/lcov.info 'lib/**.g.dart' 'lib/core/*' 'lib/themes/*' -o coverage/new_lcov.info
  genhtml coverage/new_lcov.info --output=coverage/lcov
}
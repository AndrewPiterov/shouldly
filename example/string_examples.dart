import 'package:shouldly/shouldly_string.dart';

void main() {
  const str = 'Flutter is awesome';

  // Type checking
  str.should.beOfType<String>();
  str.should.not.beOfType<num>();

  // Equlaity
  str.should.beEqual('Flutter is awesome');
  str.should.not.beEqual('Flutter is awesome'.toUpperCase());

  str.should.not.beNullOrEmpty.and.match('.* awesome').and.match('Flutter .*');

  ''.should.beNullOrEmpty;

  '   '.should.beBlank;
  'my string'.should.not.beBlank;

  'Flutter'.should.endWith('er');
  'Flutter'.should.not.endWith('R');

  print('Done with Strings');
}

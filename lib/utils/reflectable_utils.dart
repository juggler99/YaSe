import 'package:reflectable/reflectable.dart';
import 'dart:developer';

class Reflector extends Reflectable {
  const Reflector()
      : super(typeCapability, const InstanceInvokeCapability('foo'));
}

const reflector = Reflector();

class ReflectTest {
  void invokingCapabilityTest() {
    debugger();
    A x = new A(10);
    // Reflect upon [x] using the const instance of the reflector:
    InstanceMirror instanceMirror = reflector.reflect(x);
    debugger();
    int weekday = new DateTime.now().weekday;
    // On Fridays we test if 3 is greater than 10, on other days if it is less
    // than or equal.
    String methodName = weekday == DateTime.friday ? "greater" : "lessEqual";
    // Reflectable invocation:
    print(instanceMirror.invoke(methodName, [3]));
  }
}

@reflector // This annotation enables reflection on A.
class A {
  final int a;
  A(this.a);
  greater(int x) => x > a;
  lessEqual(int x) => x <= a;
}

void main() => ReflectTest().invokingCapabilityTest();

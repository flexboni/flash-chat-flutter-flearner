import 'package:flash_chat/screens/login_screen.dart';
import 'package:flash_chat/screens/registration_screen.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatefulWidget {
  static const String id = 'welcome';

  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

// 2. mixin 으로 선언된 SingleTickerProviderStatMixin class 를 재사용할 수 있게 선언
// 참고 : https://paulaner80.tistory.com/entry/Dart-mixin-%EC%9D%B4%EB%9E%80-1
class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  // 1. AnimationController 선언
  late AnimationController controller;
  // 10. Animation 선언
  late Animation animation;

  @override
  void initState() {
    super.initState();

    // 3. controller 초기화
    controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this, // 어떤 놈이 controller 에서 ticker 을 제공할 것 인지 나타냄
      // 7. 0 to 100 으로 값 설정 -> 11. 삭제
      // upperBound: 100.0,
    );

    // 12. CurvedAnimation 설정
    animation = CurvedAnimation(
      parent: controller,
      curve: Curves.decelerate,
    );

    // 14. 애니메이션 반복하기 => 16. 삭제
    // animation.addStatusListener((AnimationStatus status) {
    //   if (status == AnimationStatus.completed) {
    //     controller.reverse(from: 1.0);
    //   } else if (status == AnimationStatus.dismissed) {
    //     controller.forward();
    //   }
    // });

    // 17. ColorTween 애니메이션 사용하기
    animation = ColorTween(
      begin: Colors.amber,
      end: Colors.cyan,
    ).animate(controller);

    // 4. controller 시작
    controller.forward();
    // 5. controller call back listener 생성
    controller.addListener(() {
      setState(() {}); // 요거 없으면 값이 변해도 화면에 아무런 변화 주지 않음.
      print(controller.value);
    });
  }

  @override
  void dispose() {
    // 15. 화면에서 나갈 때 controller 해제 해주기. 안 그럼 메모리 누수 생김
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /**  6. controller value 로 투명도 변경
      * ! 여기까지 구현하고 Restart
      */
      // backgroundColor: Colors.white,
      // 19. backgroundColor 에 animation 표현
      backgroundColor: animation.value,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              children: <Widget>[
                Hero(
                  tag: 'logo',
                  child: SizedBox(
                    child: Image.asset('images/logo.png'),
                    // 9. height 변경하기
                    // height: controller.value,

                    // 13. height 에 animation 적용
                    // height: controller.value * 100, // 100을 곱해 유의미한 변화 줌.

                    // 18. height 고정
                    height: 60.0,
                  ),
                ),
                const Text(
                  'Flash Chat',
                  /**
                   * 8. 0 to 100 값 변화 확인
                   * ! Restart 실행 후 원복
                   */
                  // '${controller.value.toInt()}%',
                  style: TextStyle(
                    fontSize: 45.0,
                    fontWeight: FontWeight.w900,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 48.0),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Material(
                elevation: 5.0,
                color: Colors.lightBlueAccent,
                borderRadius: BorderRadius.circular(30.0),
                child: MaterialButton(
                  onPressed: () {
                    Navigator.pushNamed(context, LoginScreen.id);
                  },
                  minWidth: 200.0,
                  height: 42.0,
                  child: const Text(
                    'Log In',
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Material(
                color: Colors.blueAccent,
                borderRadius: BorderRadius.circular(30.0),
                elevation: 5.0,
                child: MaterialButton(
                  onPressed: () {
                    Navigator.pushNamed(context, RegistrationScreen.id);
                  },
                  minWidth: 200.0,
                  height: 42.0,
                  child: const Text(
                    'Register',
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

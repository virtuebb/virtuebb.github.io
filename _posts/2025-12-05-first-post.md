---
title: "logback, log4j, slf4j 에 대하여"
date: 2025-12-05 09:00:00 +0900
categories: [Java, Logging]
---

## 개요

이 글에서는 Java 생태계에서 널리 쓰이는 로깅 관련 라이브러리인 **SLF4J**, **Logback**, **Log4j(및 Log4j2)**의 역할과 차이점을 정리합니다. 또한 실무에서 어떤 조합으로 사용하는 것이 일반적인지, 설정 및 마이그레이션 시 주의할 점을 예제와 함께 다룹니다.

---

## 1) 핵심 개념 요약

- SLF4J: 로깅을 위한 추상화(Facade). 애플리케이션에서 SLF4J API(인터페이스)를 호출하면, 실제 구현체(Logback, Log4j 등)를 런타임에 바인딩해서 사용합니다.
- Logback: SLF4J를 만든 개발자가 만든 구현체(기본적으로 SLF4J와 궁합이 좋음). 성능과 유연성이 좋습니다.
- Log4j / Log4j2: 오랜 역사와 넓은 사용처를 가진 로깅 프레임워크. Log4j2는 성능과 설계 면에서 Log4j 1.x보다 개선됨.

## 2) 왜 SLF4J를 쓰는가?

1. 구현체 교체 유연성: 코드에서는 SLF4J 인터페이스만 사용하고 실제 구현체는 의존성을 통해 교체할 수 있습니다.
2. 라이브러리 충돌 완화: 여러 서드파티 라이브러리가 서로 다른 로깅 구현체를 직접 참조하는 상황에서 중간에 SLF4J를 두면 충돌을 줄일 수 있습니다.

## 3) Maven/Gradle 예시 (의존성)

### Maven - SLF4J + Logback

```xml
<!-- SLF4J API -->
<dependency>
	<groupId>org.slf4j</groupId>
	<artifactId>slf4j-api</artifactId>
	<version>1.7.36</version>
</dependency>

<!-- Logback (implementation) -->
<dependency>
	<groupId>ch.qos.logback</groupId>
	<artifactId>logback-classic</artifactId>
	<version>1.2.11</version>
</dependency>
```

### Log4j2 사용 시 (SLF4J 브리지)

```xml
<!-- SLF4J API -->
<dependency>
	<groupId>org.slf4j</groupId>
	<artifactId>slf4j-api</artifactId>
	<version>1.7.36</version>
</dependency>

<!-- Log4j2 implementation + SLF4J binding -->
<dependency>
	<groupId>org.apache.logging.log4j</groupId>
	<artifactId>log4j-slf4j-impl</artifactId>
	<version>2.20.0</version>
</dependency>
```

## 4) 코드 예제 (사용 방법)

### SLF4J 표준 사용 (Lombok 없이)

```java
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class MyService {
	private static final Logger logger = LoggerFactory.getLogger(MyService.class);

	public void doWork() {
		logger.info("작업 시작");
		try {
			// ...
		} catch (Exception e) {
			logger.error("오류 발생", e);
		}
	}
}
```

### Lombok `@Slf4j` 사용

```java
import lombok.extern.slf4j.Slf4j;

@Slf4j
public class MyService {
	public void doWork() {
		log.info("작업 시작");
	}
}
```

### Spring Boot 테스트 예제

아래 예제는 Spring Boot 환경에서의 간단한 테스트 케이스이며, 로그를 실제로 출력하여 `logback-spring.xml` 설정에 따른 동작을 확인할 수 있습니다.

```java
@SpringBootTest
class BackendProjectApplicationTests {

	@Test
	void contextLoads() {

		// 2. Logger 객체에서 제공하는 로깅 수행 시 필요한 구문들 호출 (log.메소드명())
		log.debug("난 debug야");
		log.info("난 info야");
		log.warn("난 warn이야");
		log.error("난 error야");

		// > 일단 콘솔에 이 메세지의 종류와, 어디서, 언제 찍힌메세지인지,
		//   메세지 내용까지 해서 sysout 구문인것 마냥 출력되고 있음!!
		// > 또한, debug 출력문은 출력되지 않았음!!

		// > logback 프레임워크 관련 환경설정 파일을 작성 후
		//   어떻게 작성하냐에 따라 로깅이 어떻게 이루어지는지를 확인하자!!

		// * logback 의 환경설정 파일
		// - 반드시 파일명은 logback-spring.xml 로 지을 것
		// - 이 프로젝트의 외부 프레임워크 또는 라이브러리 연동 파일을 작성하는 폴더 내부에 생성
		//   (src/main/resources 폴더 내부)

	}

}
```

## 5) 실무 팁 및 주의사항

- 의존성 중복(예: SLF4J API와 로깅 구현체가 충돌하는 경우) 확인: `mvn dependency:tree` 또는 Gradle의 `dependencies`로 트리를 확인하세요.
- 로그 포맷과 롤링 정책: Logback의 `logback.xml` 또는 Log4j2의 `log4j2.xml`에서 설정을 관리합니다. 성능을 고려해 비동기 로깅(appender) 사용을 검토하세요.
- 보안 취약성: Log4j 2의 과거 취약점(CVE-2021-44228 등)을 기억하고, 라이브러리 버전 업데이트를 주기적으로 수행하세요.

## 6) 정리

- 애플리케이션 코드에는 SLF4J API를 사용하고, 런타임에 Logback 또는 Log4j2 같은 구현체를 바인딩하는 방식이 가장 유연합니다.
- 새로운 프로젝트에서는 보통 Logback + SLF4J 조합을 많이 사용하지만, 기존 시스템이나 조직 정책에 따라 Log4j2를 선택할 수도 있습니다.

## 참고자료

- SLF4J 공식: http://www.slf4j.org/
- Logback 공식: http://logback.qos.ch/
- Log4j2 공식: https://logging.apache.org/log4j/2.x/

---
title: "포스트 제목을 여기에 입력하세요"
date: 2025-12-05 09:00:00 +0900
layout: single
categories: [Blog]
tags: [템플릿]
author_profile: true
excerpt: "한 줄 요약을 입력하세요."
---

## 요약

여기에 글의 한 줄 요약을 적으세요.

## 배경 / 필요성

왜 이 주제를 다루는지, 어떤 배경 지식이 필요한지 짧게 설명합니다.

## 핵심 내용

- 주요 개념 1
- 주요 개념 2

### 예제 코드

```java
// 간단한 예제 코드
public class Example {
  public static void main(String[] args) {
    System.out.println("Hello world");
  }
}
```

아래는 Spring Boot 환경에서의 간단한 테스트 예시입니다. 코드 블록의 언어를 `java`로 지정하면 하이라이팅이 적용됩니다.

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

### 팁 / 주의사항

- 실제로 적용할 때 주의할 점

## 참고자료

- 링크 1
- 링크 2

## 태그

`#태그1` `#태그2`

---

이 템플릿을 복사해서 새 파일을 만들고, 파일명을 `_posts/YYYY-MM-DD-제목.md` 형식으로 저장하세요.

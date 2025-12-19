# 📄 PRD – Flutter 기반 QR 디지털 메뉴판 시스템



## 1. 제품 개요 (Overview)

### 1.1 제품명

Flutter 기반 QR 디지털 메뉴판 시스템

### 1.2 제품 목적

본 제품은 **Flutter를 활용하여 Android와 iOS에서 동일하게 동작하는 모바일 디지털 메뉴판**을 제공한다.

QR 코드를 통해 고객은 앱 또는 웹 링크로 메뉴를 확인하고, 식당 운영자는 관리자 페이지를 통해 **메뉴를 실시간으로 관리**할 수 있다.

---

## 2. 문제 정의 (Problem Statement)

* 종이 메뉴판은 가격/메뉴/품절 변경 시 즉각 반영이 불가능

* 고객은 메뉴 정보(사진, 설명, 알레르기)에 대한 접근이 제한적

* 직원의 반복적인 메뉴 설명으로 운영 효율 저하

* 메뉴 데이터가 누적되지 않아 분석 및 개선이 어려움

👉 본 시스템은 **실시간 메뉴 관리 + 모바일 최적화 UX**로 위 문제를 해결한다.

---

## 3. 목표 및 성공 지표 (Goals & KPIs)

### 3.1 목표

* 메뉴 변경 반영 시간 1분 이내

* 모바일 환경에서 직관적인 메뉴 탐색 제공

* QR 메뉴판 사용으로 직원 응대 부담 감소

### 3.2 KPI

* 메뉴 수정 후 반영 시간 ≤ 60초

* 평균 메뉴 로딩 시간 ≤ 2.5초

* 품절 메뉴 주문 발생률 0%

---

## 4. 타겟 사용자 (Target Users)

### 4.1 1차 타겟 – 식당 방문 고객

* Android / iOS 스마트폰 사용자

* QR 코드 스캔에 익숙한 고객

**Needs**

* 보기 쉬운 메뉴 UI

* 빠른 로딩과 직관적인 조작

---

### 4.2 2차 타겟 – 식당 운영자 / 관리자

* 메뉴 변경이 잦은 소형·중형 식당

* 모바일 또는 PC에서 관리 필요

**Needs**

* 간단한 메뉴 관리

* 실시간 반영

---

## 5. 사용자 시나리오 (User Journey)

1. 고객이 테이블의 QR 코드를 스캔한다

2. Flutter 앱 또는 Flutter Web 메뉴판이 실행된다

3. 메뉴 목록을 스크롤하며 확인한다

4. 메뉴 상세 정보를 확인한다

5. 품절 메뉴는 자동 제외된다

---

## 6. 기능 요구사항 (Functional Requirements – Gherkin)

### 6.1 고객용 모바일 메뉴판 (Flutter)

```gherkin

Scenario: 고객이 QR 코드로 메뉴를 조회한다

  Given 고객이 QR 코드를 스캔했을 때

  When 메뉴 화면이 로드되면

  Then 판매 중인 메뉴 목록이 표시되어야 한다

```

```gherkin

Scenario: 고객이 메뉴 상세 정보를 확인한다

  Given 고객이 메뉴 목록을 보고 있을 때

  When 특정 메뉴를 선택하면

  Then 메뉴 이미지, 가격, 설명, 알레르기 정보가 표시되어야 한다

```

```gherkin

Scenario: 품절 메뉴는 노출되지 않는다

  Given 메뉴가 품절 상태일 때

  When 고객이 메뉴판을 조회하면

  Then 해당 메뉴는 비활성화되거나 숨김 처리되어야 한다

```

---

### 6.2 관리자 기능

```gherkin

Scenario: 관리자가 메뉴를 등록 또는 수정한다

  Given 관리자가 관리자 페이지에 접근했을 때

  When 메뉴 정보를 저장하면

  Then 변경 사항은 즉시 모바일 메뉴판에 반영되어야 한다

```

```gherkin

Scenario: 관리자가 메뉴를 품절 처리한다

  Given 관리자가 메뉴 관리 화면에 있을 때

  When 품절 상태로 변경하면

  Then 고객 메뉴판에 즉시 반영되어야 한다

```

---

## 7. 비기능 요구사항 (Non-Functional Requirements)

### 7.1 성능

```gherkin

Scenario: 메뉴판은 빠르게 반응해야 한다

  Then 화면 전환은 300ms 이내여야 한다

```

### 7.2 사용성

```gherkin

Scenario: 고객은 앱 사용법을 설명 없이 이해할 수 있다

  Then 한 손 조작이 가능해야 한다

```

### 7.3 보안

```gherkin

Scenario: 관리자 기능은 인증이 필요하다

  Then 인증되지 않은 사용자는 접근할 수 없어야 한다

```

### 7.4 호환성

```gherkin

Scenario: 다양한 모바일 기기에서 동일하게 동작한다

  Then Android와 iOS에서 동일한 UX를 제공해야 한다

```

---

## 8. MVP 범위 (Scope)

### 포함 (In Scope)

* Flutter 모바일 메뉴판

* QR 기반 메뉴 접근

* 메뉴 목록 / 상세 화면

* 품절 처리 반영

### 제외 (Out of Scope)

* 결제 기능

* 회원 로그인 (고객)

* 고급 통계 분석

---

## 9. 기술 스택 (Tech Stack)

### Mobile App

* Flutter (Android / iOS)

* State Management: Riverpod 또는 Provider

### Backend

* FastAPI

* REST API

* JWT (관리자 인증)

### Database

* PostgreSQL

---

## 10. 시스템 아키텍처

```

[ Flutter App ]

      │

      │ REST API

      ▼

[ FastAPI ] ── PostgreSQL

```

---

## 11. 향후 확장 (Future Enhancements)

* Flutter Web 지원

* 다국어 메뉴

* 메뉴 추천 및 세트 구성

* 직원용 주문 앱

---

## 12. 개발 가이드 (Flutter 기준)

* 모바일 퍼스트 UI 설계

* ListView 기반 스크롤 UX

* 이미지 Lazy Loading

* 상태 관리 단순화

---

✅ 본 PRD는 **Flutter 기반 모바일 QR 메뉴판 MVP 및 확장 개발**을 위한 기준 문서이다.


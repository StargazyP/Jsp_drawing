### Jsp_drawing 프로젝트 README.md

## 개요

Jsp_drawing 프로젝트는 JSP(JavaServer Pages)를 사용하여 간단한 게시판과 채팅 기능을 제공하는 웹 애플리케이션입니다. 사용자 관리, 게시판 글 작성 및 삭제, 실시간 채팅 등의 기능을 구현했습니다.

## 기능

- **사용자 관리**
  - 사용자 등록 및 로그인
  - 사용자 정보 수정 및 삭제

- **게시판 기능**
  - 게시물 작성, 조회, 수정 및 삭제
  - 게시물 리스트 및 상세보기

- **실시간 채팅**
  - 다중 사용자 채팅 지원
  - WebSocket을 사용한 실시간 메시지 전송

## 아키텍처

프로젝트의 아키텍처는 MVC(Model-View-Controller) 패턴을 따릅니다.

### 모델(Model)

- **User.java**: 사용자 정보를 저장하는 클래스
- **Bbs.java**: 게시물 정보를 저장하는 클래스

### 뷰(View)

- **JSP 파일들**: 사용자 인터페이스를 제공하는 JSP 파일들 (`bbs.jsp`, `chat.jsp`, `client.jsp` 등)

### 컨트롤러(Controller)

- **UserDAO.java**: 사용자 관련 데이터베이스 작업을 수행하는 클래스
- **BbsDAO.java**: 게시물 관련 데이터베이스 작업을 수행하는 클래스
- **WsServer.java**: WebSocket 서버로서 실시간 채팅 기능을 담당

### 데이터베이스

- MySQL 등의 관계형 데이터베이스를 사용하여 사용자 정보와 게시물 정보를 저장

### WebSocket

- **WsServer.java**: WebSocket을 통해 실시간 채팅 기능을 제공
- 
## 주요 파일 설명

- `src/main/java/bbs/`
  - `Bbs.java`: 게시물 클래스
  - `BbsDAO.java`: 게시물 데이터 접근 객체

- `src/main/java/user/`
  - `User.java`: 사용자 클래스
  - `UserDAO.java`: 사용자 데이터 접근 객체

- `src/main/java/ws/`
  - `WsServer.java`: WebSocket 서버 클래스

- `src/main/webapp/`
  - `bbs.jsp`: 게시판 페이지
  - `chat.jsp`: 채팅 페이지
  - `client.jsp`: 클라이언트 페이지
  - `css/`: 스타일 시트 파일들
  - `js/`: 자바스크립트 파일들
  - `WEB-INF/`: 웹 애플리케이션 설정 파일들



# Gaianet Node Executor Setup - README

본 문서는 [`gaianet.sh`](./gaianet.sh) 스크립트를 통해 Gaianet 노드를 설치하고, screen 세션에서 실행/관리하는 과정을 안내한다.

---

## 1. 소개

**Gaianet**은 다양한 서브 프로세스를 스폰(Spawn)하여 AI 관련 기능과 노드 서비스를 제공한다.  
본 스크립트는 다음 작업을 자동으로 처리해 준다:

1. 시스템 패키지 업데이트 & 필수 유틸 설치  
2. Gaianet 설치 (GitHub `install.sh` 다운로드 & 실행)  
3. `gaianet init`으로 환경 초기화  
4. `screen` 세션에서 `gaianet start` 실행 후 자동 접속  

이 과정을 거치면 별도 수작업 없이 노드가 백그라운드에서 구동되며, 사용자는 실시간 로그를 확인 가능하다.

---

## 2. 요구 사항

- Ubuntu/Debian 기반 리눅스 환경 (다른 리눅스 계열도 `apt-get` 대신 알맞은 패키지 관리 명령으로 대체 가능)  
- `curl`, `wget` 등 기초 유틸리티 설치 권장  
- sudo 권한 (시스템 패키지 업데이트 및 설치에 필요)  

---

## 3. 사용 방법

## [Linux]
1. **스크립트 다운로드 및 실행**  
   `wget https://raw.githubusercontent.com/kooroot/Node_Executor-Gaianet/refs/heads/main/gaianet.sh`
   `chmod +x gaianet.sh`
   `./gaianet.sh`
   
## [MacOS]
1. **스크립트 다운로드 및 실행**  
   `wget https://raw.githubusercontent.com/kooroot/Node_Executor-Gaianet/refs/heads/main/gaianet_mac.sh`
   `chmod +x gaianet_mac.sh`
   `./gaianet_mac.sh`
   
---

## 4.웹 사이트와 연동

1. [Gaianet 웹사이트(레퍼럴 포함)](https://www.gaianet.ai/gaia-domain-name?referralCode=RnpSn8) or [Gaianet 웹사이트(레퍼럴 미포함)](https://www.gaianet.ai/gaia-domain-name)에 접속한 후 Node 탭으로 이동
   ![image](https://github.com/user-attachments/assets/a8828611-58a5-4214-abd4-6ba66a875bd8)
2. Connect New Node를 클릭해 Node에 표시된 Node ID와 Device ID를 입력한다.
   ![image](https://github.com/user-attachments/assets/7d98f993-c217-4cdf-9997-4b5edd639e08)
3. 설정완료
   ![image](https://github.com/user-attachments/assets/fd91116a-4b5c-47f4-8adb-e70443a9a3f8)


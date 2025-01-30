#!/usr/bin/env bash
set -e

##############################################
# 1. 시스템 패키지 업데이트 & 필수 패키지 설치
##############################################
echo "=== [1] 시스템 패키지 업데이트 & 필수 패키지 설치 ==="
sudo apt-get update -y
sudo apt-get upgrade -y
# 필요하다면 curl, wget 등 추가
sudo apt-get install -y curl wget screen

##############################################
# 2. Gaianet 설치 여부 확인 & 설치
##############################################
if ! command -v gaianet &> /dev/null; then
  echo "=== Gaianet이 설치되어 있지 않습니다. 설치를 진행합니다... ==="

  # GitHub에서 install.sh 다운로드 & 실행
  curl -sSfL 'https://github.com/GaiaNet-AI/gaianet-node/releases/latest/download/install.sh' | bash

  # 어떤 셸인지 확인 (bash or zsh)
  CURRENT_SHELL="$(basename "$SHELL")"
  echo "[INFO] 현재 사용 중인 셸: $CURRENT_SHELL"

  # ~/.bashrc 또는 ~/.zshrc를 source
  if [ "$CURRENT_SHELL" = "zsh" ] && [ -f "$HOME/.zshrc" ]; then
    echo "[INFO] Sourcing ~/.zshrc ..."
    source "$HOME/.zshrc"
  elif [ "$CURRENT_SHELL" = "bash" ] && [ -f "$HOME/.bashrc" ]; then
    echo "[INFO] Sourcing ~/.bashrc ..."
    source "$HOME/.bashrc"
  else
    echo "[WARN] bashrc나 zshrc 파일을 찾지 못했거나 다른 셸일 수 있습니다."
    echo "[WARN] 설치 스크립트가 PATH를 설정했는지 직접 확인하세요."
  fi

  # 해시 테이블 갱신
  hash -r

  # 최종 확인
  if ! command -v gaianet &> /dev/null; then

    echo "[ERROR] Gaianet이 PATH에 인식되지 않습니다."
    echo "[ERROR] 새 터미널을 열거나, ~/.bashrc를 다시 source 하거나, 심볼릭 링크를 만드세요."
    exit 1
  fi

  echo "=== Gaianet 설치 및 환경 변수 로드가 완료되었습니다. ==="
else
  echo "=== Gaianet이 이미 설치되어 있으므로 건너뜁니다. ==="
fi

##############################################
# 3. gaianet init
##############################################
if [ ! -d "$HOME/.gaianet" ]; then
  echo "=== gaianet init을 진행합니다... ==="
  gaianet init
else
  echo "=== 이미 $HOME/.gaianet 디렉토리가 존재하므로 init 단계를 건너뜁니다. ==="
fi

##############################################
# 4. Screen 세션에서 gaianet start 실행
##############################################
SCREEN_NAME="gaianet_node"

# 기존 동일 세션이 있다면 종료
if screen -list | grep -q "\.${SCREEN_NAME}"; then
  echo "[INFO] 기존 screen 세션($SCREEN_NAME)이 발견되어 종료합니다..."
  screen -S "$SCREEN_NAME" -X quit || true
fi

echo "=== $SCREEN_NAME 세션에서 gaianet 노드를 시작합니다. ==="
screen -dmS "$SCREEN_NAME" bash -c "
  echo '[INFO] Running gaianet start...';
  gaianet start;
  echo '[INFO] gaianet start 프로세스가 완료되었습니다.';
  echo '상단에 표시되는 URL을 접속하면 AI 상담원이 표시됩니다.'
  echo '- 노드 로그를 실시간으로 볼 수 있습니다.';
  echo '- 노드를 중단하려면: gaianet stop';
  echo '- 세션만 분리하려면: Ctrl + A, D';
  echo '- 세션을 종료하려면: exit';
  echo '-----------------------------';
  echo '아래의 Node ID와 Device ID를 이용해 반드시 지갑과 연동하세요.';
  gaianet info;
  echo '-----------------------------';
  exec bash
"

# 잠시 대기 후 세션 접속
sleep 1
echo "[INFO] screen 세션($SCREEN_NAME)에 접속합니다."
echo " - Ctrl + A, D: 화면 분리(노드는 계속 동작)"
echo ""

screen -r "$SCREEN_NAME"

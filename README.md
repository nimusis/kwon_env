kwon_env
=========

zsh 를 이용한 내 설정방법

# 필요한 패키지 설치

#### zsh 설치

```shell
sudo apt-get install zsh
```

#### 폰트 설치
unicode 특수 문자로 쓰던 부분을 파워라인 폰트로 변경

네이버의 D2Coding 폰트에서 powerline 지원

[d2Coding 폰트] (https://github.com/naver/d2codingfont)

Ubuntu

```shell
sudo apt-get install fonts-powerline
```

Centos

```shell
# clone
git clone https://github.com/powerline/fonts.git --depth=1
# install
cd fonts
./install.sh
# clean-up a bit
cd ..
rm -rf fonts
```

#### tmux & tmuxinator 설치

```shell
sudo apt-get install -y tmux tmuxinator
```

# kwon env 설치

```shell
curl -L https://raw.githubusercontent.com/nimusis/kwon_env/master/install.sh | bash
```


#### vim 설정

vim을 열고 아래 명령 실행하여 플러그인을 설치함.

`:PlugInstall`

[상세 커맨드 확인] (https://github.com/junegunn/vim-plug)


## 활용

### vim

| | command|
|-|-|
|디렉토리열기 토글|F8|
|vim 창 이동|ctrl+h , ctrl+l|
|버퍼간 이동| (tab) |
|버퍼 역순이동| \\+(tab)|
|버퍼 닫기|\\+bq|
|버퍼 번호로 이동|,(1~9)|

### tmux
prefix = ctrl+a

#### Session
| | command|
|-|-|
| Session 생성 | ts [session 이름] |
| Session 다시 접속 | ta [session 이름] |
| Session 리스트| tl |
| 특정 Session 종료 | tkss [session 이름] |
| 전체 Session 종료| tksv |

#### Windows
| | command|
|-|-|
|마우스 모드 토글|prefix + m|
|새 윈도우|prefix + c|
|윈도우 전환|prefix + number|
|윈도우 전환|prefix + (tab)|
|윈도우 이름 변경|prefix + ,|
|윈도우 목록|prefix + w|
|윈도우 종료|ctrl + d or exit|

#### Pane
| | command|
|-|-|
|수평 분할|prefix + -|
|수직 분할|prefix + _|
|판넬 이동|prefix + 화살표 or hljk|
|판넬 크기변경|prefix + HLJK|
|복사모드|prefix + 엔터|
|판넬 줌 in/out|prefix + z|
|판넬 번호보기|prefix + q|
|현재 시간보기|prefix + t|
|바인딩 된 키 목록 보기|prefix + ?|

### tmuxinator
alias 로 mux 설정 해놓음.

| | command|
|-|-|
|새로운 프로젝트 생성|mux new (project name)|
|프로젝트를 tmux로 시작|mux start (project name)|
|프로젝트 목록 보기|mux ls|

#### 기본 레이아웃
```yml
name: test
root: ~/

windows:
  - editor:
      layout: main-vertical
      panes:
        - vim
        - htop
  - server:
      layout: main-vertical
      panes:
        - pane_with_multiple_commands:
            - docker exec -it myserver bash
            - top
  - logs: tail -f /home/user/logs/info.log
```

#### 레이아웃을 커스텀하게 하는 법

`tmux list-windows` 명령어를 통해 현재 레이아웃 정보를 얻어옴

```shell
tmux list-windows
0: editor* (2 panes) [256x50] [layout 5805,256x50,0,0{136x50,0,0,0,119x50,137,0,3}] @0 (active)
1: server# (1 panes) [256x50] [layout b0de,256x50,0,0,1] @1
2: logs#- (1 panes) [256x50] [layout b0df,256x50,0,0,2] @2
```

판넬을 커스텀 레이아웃으로 변경

```yml
name: test
root: ~/

windows:
  - editor:
      layout: 5805,256x50,0,0{136x50,0,0,0,119x50,137,0,3}
      panes:
        - vim
        - htop
  - server:
      layout: main-vertical
      panes:
        - pane_with_multiple_commands:
            - docker exec -it myserver bash
            - top
  - logs: tail -f /home/user/logs/info.log
```
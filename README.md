
# kwon_env 설치

zsh 를 이용한 내 설정방법. 아래 명령어를 통해 설치 할 수 있다.

```shell
curl -L https://raw.githubusercontent.com/nimusis/kwon_env/master/install.sh | bash
```

## 포함 된 설치파일

* oh my zsh (https://ohmyz.sh/)
* vim-plug (https://github.com/junegunn/vim-plug)
* fuzzy finder (https://github.com/junegunn/fzf)
* Oh my tmux (https://github.com/gpakosz/.tmux)

# 필요한 패키지 설치

* zsh
* vim >= 7.0 (recommended >= 8.0)
* git >= 1.7 (recommended >= 1.8)
* python >= 2.6
* tmux >= 2.4
* tmuxinator

### zsh 설치

```shell
sudo apt-get install zsh
```

### Windows 폰트 설치

unicode 특수 문자로 쓰던 부분을 파워라인 폰트로 변경
네이버의 D2Coding 폰트에서 powerline 지원
[d2Coding 폰트] (https://github.com/naver/d2codingfont)

### tmux 설치

최소 요구사항 :
* tmux >= 2.4

패키지 매니저의 tmux 버전이 낮을 경우 아래 링크정보 참고 할만함.
https://github.com/nelsonenzo/tmux-appimage


**Ubuntu**

```shell
sudo apt-get install -y tmux
```

**Centos**

```shell
sudo yum install tmux
```

### tmuxinator 설치

**Ubuntu**

```shell
sudo apt-get install tmuxinator
```

**Centos**

```shell
sudo yum install tmuxinator
```

#### ruby 를 이용한 설치 방안
패키지 매니저에 tmuxinator가 없는 경우..

요구사항 :
* tmuxinator requires Ruby version >= 2.6.7

패키지 매니저의 ruby 버전이 낮을 경우, rvm 을 통해 ruby 설치

1. RVM GPG key 설치하기

```shell
curl -sSL https://rvm.io/pkuczynski.asc | gpg2 --import -
```

2. RVM 설치 스크립트 다운로드 및 실행

```shell
curl -sSL https://get.rvm.io | bash -s stable
```

스크립트 실행 후 나타나는 명령을 통해 source 로드

```shell
source ?????.rvm/scripts/rvm
rvm reload
```

3. RVM 의존성 패키지 설치

```shell
rvm requirements run
```


4. ruby 설치 및 기본버전 지정

```shell
rvm install 2.7
rvm use 2.7 --default
```

5. RubyGems 를 이용한 tmuxinator 설치

```shell
gem install tmuxinator
```


### 퍼지 파인드를 더 잘 활용하기 위한 유틸 설치

* bat : cat 대용. 미리 설정된 syntax highlighting과 git diff 연동 https://github.com/sharkdp/bat
* ripgrep : 디렉터리 안의 파일 내용을 정규식으로 찾아주는 플러그인. https://github.com/BurntSushi/ripgrep


**Ubuntu**
```shell
sudo apt install bat
ln -s /usr/bin/batcat ~/.kwon_env/bin/bat

sudo apt install ripgrep
```

**centos**
bat 설치

```shell
V=$(curl --silent "https://api.github.com/repos/sharkdp/bat/releases/latest" | grep -Eo '"tag_name": "v(.*)"' | sed -E 's/.*"([^"]+)".*/\1/') && curl -sOL "https://github.com/sharkdp/bat/releases/download/$V/bat-$V-x86_64-unknown-linux-musl.tar.gz" && tar xzvf "bat-$V-x86_64-unknown-linux-musl.tar.gz" -C . && sudo sh -c "cp ./bat-$V-x86_64-unknown-linux-musl/bat /usr/local/bin/bat" && rm bat-$V-x86_64-unknown-linux-musl.tar.gz && unset V
```

ripgrep 설치

```shell
sudo yum install -y yum-utils
sudo yum-config-manager --add-repo=https://copr.fedorainfracloud.org/coprs/carlwgeorge/ripgrep/repo/epel-7/carlwgeorge-ripgrep-epel-7.repo
sudo yum install ripgrep
```


# kwon env 활용

설치에 포함된 유틸 및 미리 적용해놓은 alias 등등에 대한 간략 설명

### vim

|                   | command         |
| ----------------- | --------------- |
| 디렉토리열기 토글 | F8              |
| vim 창 이동       | ctrl+h , ctrl+l |
| 버퍼간 이동       | (tab)           |
| 버퍼 역순이동     | \\+(tab)        |
| 버퍼 닫기         | \\+bq           |
| 버퍼 번호로 이동  | ,(1~9)          |


### tmux

prefix = ctrl+a
#### Session

|                   | command             |
| ----------------- | ------------------- |
| Session 생성      | ts [session 이름]   |
| Session 다시 접속 | ta [session 이름]   |
| Session 리스트    | tl                  |
| 특정 Session 종료 | tkss [session 이름] |
| 전체 Session 종료 | tksv                |

#### Windows

|                  | command          |
| ---------------- | ---------------- |
| 마우스 모드 토글 | prefix + m       |
| 새 윈도우        | prefix + c       |
| 윈도우 전환      | prefix + number  |
| 윈도우 전환      | prefix + (tab)   |
| 윈도우 이름 변경 | prefix + ,       |
| 윈도우 목록      | prefix + w       |
| 윈도우 종료      | ctrl + d or exit |

#### Pane

|                        | command                 |
| ---------------------- | ----------------------- |
| 수평 분할              | prefix + -              |
| 수직 분할              | prefix + _              |
| 판넬 이동              | prefix + 화살표 or hljk |
| 판넬 크기변경          | prefix + HLJK           |
| 복사모드               | prefix + 엔터           |
| 판넬 줌 in/out         | prefix + z              |
| 판넬 번호보기          | prefix + q              |
| 현재 시간보기          | prefix + t              |
| 바인딩 된 키 목록 보기 | prefix + ?              |

### tmuxinator

alias 로 mux 설정 해놓음.

|                        | command                  |
| ---------------------- | ------------------------ |
| 새로운 프로젝트 생성   | mux new (project name)   |
| 프로젝트를 tmux로 시작 | mux start (project name) |
| 프로젝트 목록 보기     | mux ls                   |

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

### fzf

|                     | command    |
| ------------------- | ---------- |
| 전체 파일 찾기      | ctrl + t   |
| 히스토리 찾기       | ctrl + r   |
| 파일 내 문자열 찾기 | fif [text] |
| 디렉토리 찾기       | sdt        |

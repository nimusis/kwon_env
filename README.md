kwon_env
=========

내가 사용하는 vim 설정

필요한 패키지 설치 (우분투 기준)
--------

* tagbar 플러그인

```
apt-get install ctags
```

* YouCompleteMe 플러그인

```
apt-get install clang (C/C++ 도 사용한다면)
sudo apt-get install build-essential cmake
sudo apt-get install python-dev python3-dev
```


설치방법
--------

`curl -L https://raw.githubusercontent.com/nimusis/kwon_env/master/install.sh | bash`

플러그인 인스톨
--------

`:PlugInstall`

[상세 커맨드 확인] (https://github.com/junegunn/vim-plug)


YouCompleteMe 플러그인 설정
-------
C/C++ 사용할 경우 `--clang-completer`
JavaScript 사용할 경우 `--tern-completer`
```
python ~/.kwon_env/vim/plugged/YouCompleteMe/install.py --clang-completer --system-libclang --tern-completer
```
전부다 지원하려면
```
python ~/.kwon_env/vim/plugged/YouCompleteMe/install.py --all
```
[참고 링크] (http://neverapple88.tistory.com/26)


파워라인 폰트
--------
unicode 특수 문자로 쓰던 부분을 파워라인 폰트로 변경

네이버의 D2Coding 폰트에서 powerline 지원

[d2Coding 폰트] (https://github.com/naver/d2codingfont)

# 원격 저장소 push시 오류

```bash
$ git push origin master
warning: redirecting to https://github.com/yschoi9930/Bigdata.git/
To http://github.com/yschoi9930/Bigdata.git
 ! [rejected]        master -> master (fetch first)
error: failed to push some refs to 'http://github.com/yschoi9930/Bigdata.git'
# 원격 저장소의 작업(커밋)이 로컬에 없음
hint: Updates were rejected because the remote contains work that you do
hint: not have locally. This is usually caused by another repository pushing
hint: to the same ref. You may want to first integrate the remote changes
# 원격 저장소의 변경사항을 먼저 통합해라
hint: (e.g., 'git pull ...') before pushing again.
hint: See the 'Note about fast-forwards' in 'git push --help' for details.
```

* 원격 저장소와 로컬 저장소의 커밋히스토리를 확인하고 아래의 명령어를 입력한다.

  ```bash
  $ git pull origin master
  warning: redirecting to https://github.com/yschoi9930/Bigdata.git/
  remote: Enumerating objects: 5, done.
  remote: Counting objects: 100% (5/5), done.
  remote: Total 3 (delta 0), reused 0 (delta 0), pack-reused 0
  Unpacking objects: 100% (3/3), 643 bytes | 40.00 KiB/s, done.
  From http://github.com/yschoi9930/Bigdata
   * branch            master     -> FETCH_HEAD
     9a57e05..9fc95ce  master     -> origin/master
  Merge made by the 'recursive' strategy.
   README.md | 1 +
  ```
  * vim 편집기 창이 popup될 것
    * esc + :wq 엔터

* log를 확인한다.

  ``` bash
  $ git log --oneline
  # vim 편집기가 뜬 이유 => 합쳐졌다는 사실을 커밋으로 남김
  d9bdbfb (HEAD -> master) Merge branch 'master' of http://github.com/yschoi9930/Bigdata
  #로컬 작업한 것
  8b985d5 Add test
  #원격 저장소에서 작업한 것
  9fc95ce (origin/master) Update README.md
  9a57e05 Bigdata
  ```

* 다시 push 한다

``` bash
$ git push origin master
warning: redirecting to https://github.com/yschoi9930/Bigdata.git/
Enumerating objects: 6, done.
Counting objects: 100% (6/6), done.
Delta compression using up to 8 threads
Compressing objects: 100% (4/4), done.
Writing objects: 100% (4/4), 540 bytes | 270.00 KiB/s, done.
Total 4 (delta 0), reused 0 (delta 0), pack-reused 0
To http://github.com/yschoi9930/Bigdata.git
   9fc95ce..d9bdbfb  master -> master
```

* origin 저장소의 master 브랜치로 push



# Pull

* 원격 저장소(origin)의 변경사항을 받아옴

```bash
$ git pull origin master
```



# Clone

* 원격저장소를 복제함

```bash
$ git clone ____
```


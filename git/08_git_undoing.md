# Git 추가 명령어

## Undoing

### 1. WD 작업내용 복구

> 고양이가 작업 내용을 지웠다면..

```
$ git status
On branch master
Changes not staged for commit:
  # WD => Staging area .. 
  (use "git add <file>..." to update what will be committed)
  # WD의 변경사항을 버리기 위해서는... 
  (use "git restore <file>..." to discard changes in working directory)
        modified:   3.txt

no changes added to commit (use "git add" and/or "git commit -a")
$ git resotre 3.txt
$ git status
On branch master
nothing to commit, working tree clean
```

[![Inkedblank2 - 복사본 (3)_LI](https://github.com/edutak/TIL/raw/master/git/md-images/Inkedblank2%20-%20%EB%B3%B5%EC%82%AC%EB%B3%B8%20(3)_LI.jpg)](https://github.com/edutak/TIL/blob/master/git/md-images/Inkedblank2 - 복사본 (3)_LI.jpg)

### 2. staging area 취소 (unstage)

```
$ touch 2.txt
$ git add .
$ git status
On branch master
Changes to be committed:
	# hint!
  (use "git restore --staged <file>..." to unstage)
        new file:   2.txt
$ git restore --staged 2.txt
$ git status
On branch master
Untracked files:
  (use "git add <file>..." to include in what will be committed)
        2.txt

nothing added to commit but untracked files present (use "git add" to track)
```

### [![Inkedblank2 - 복사본 (4)_LI](https://github.com/edutak/TIL/raw/master/git/md-images/Inkedblank2%20-%20%EB%B3%B5%EC%82%AC%EB%B3%B8%20(4)_LI.jpg)](https://github.com/edutak/TIL/blob/master/git/md-images/Inkedblank2 - 복사본 (4)_LI.jpg)3. 커밋 메시지 변경

> 주의!! 커밋 메시지를 변경하면, 해시값이 바뀌므로 공개된 저장소에 push가 된 경우 절대 변경 금지

```
$ git commit -m 'Add 3.txt'
[master 851bb18] Add 3.txt
 1 file changed, 0 insertions(+), 0 deletions(-)
 create mode 100644 2.txt
$ git commit --amend
```

- 커밋 메시지 편집할 수 있는 창이 뜸.
  - vim 편집기
  - `i` 키를 눌러서 편집모드로 전환해서 내용을 수정하고
  - `esc` + `:wq` 해서 나온다.

```
$ git commit --amend
[master e4ff93e] Add 2.txt
 Date: Wed Dec 23 17:16:11 2020 +0900
 1 file changed, 0 insertions(+), 0 deletions(-)
 create mode 100644 2.txt
```

## reset vs revert

```
$ git log --oneline
e4ff93e (HEAD -> master) Add 2.txt
739161d 개발완료
2c827ac ==
a522d2e Add 2.txt
ce72fc0 Add 1.txt
```

### revert

```
$ git revert e4ff93e
Removing 2.txt
[master 1f5a2ce] Revert "Add 2.txt"
 1 file changed, 0 insertions(+), 0 deletions(-)
 delete mode 100644 2.txt
 
$ git log --oneline
# revert 커밋 발생!!
1f5a2ce (HEAD -> master) Revert "Add 2.txt"
e4ff93e Add 2.txt
739161d 개발완료
2c827ac ==
a522d2e Add 2.txt
ce72fc0 Add 1.txt
```

### reset

```
$ git reset --hard 739161d
HEAD is now at 739161d 개발완료

$ git log --oneline
739161d (HEAD -> master) 개발완료
2c827ac ==
a522d2e Add 2.txt
ce72fc0 Add 1.txt
```

- option

  - `--mixed` : 기본 옵션. 해당 커밋 이후 변경사항을 staging area 보관

  - ```
    --hard
    ```

     

    : 해당 커밋 이후 내용 모두 삭제

    - 이 명령어를 사용 할 때는 주의 할 것! 모든 작업 내용이 사라짐

  - `--soft` : 해당 커밋 이후 변경사항 및 working directory 보관
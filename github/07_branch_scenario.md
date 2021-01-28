# Branch 시나리오

## 준비

- 빈 프로젝트에 README.md파일을 만들고, root commit을 발생시켜주세요.

## 시나리오

### 상황 1. fast-foward

> fast-foward는 feature 브랜치 생성된 이후 master 브랜치에 변경 사항이 없는 상황

1. feature/test branch 생성 및 이동

   ```
   $ git branch feature/test
   $ git branch
     feature/test
   * master
   $ git checkout feature/test
   Switched to branch 'feature/test'
   (feature/test) $
   ```

2. 작업 완료 후 commit

   ```
   $ touch test.txt
   $ git add .
   $ git commit -m 'Complete test page'
   $ git log --oneline
   ccc49f6 (HEAD -> feature/test) Complete test page
   d786ac9 (master) Init
   ```

3. master 이동

   ```
   $ git checkout master
   Switched to branch 'master'
   (master) $ 
   ```

4. master에 병합

   ```
   (master) $ git merge feature/test
   Updating d786ac9..ccc49f6
   Fast-forward
    test.txt | 0
    1 file changed, 0 insertions(+), 0 deletions(-)
    create mode 100644 test.txt
   ```

5. 결과 -> fast-foward (단순히 HEAD를 이동)

   ```
   $ git log --oneline
   ccc49f6 (HEAD -> master, feature/test) Complete test page
   d786ac9 Init
   ```

6. branch 삭제

   ```
   $ git branch -d feature/test
   Deleted branch feature/test (was ccc49f6).
   ```

------

### 상황 2. merge commit

> 서로 다른 이력(commit)을 병합(merge)하는 과정에서 다른 파일이 수정되어 있는 상황
>
> git이 auto merging을 진행하고, commit이 발생된다.

1. feature/main branch 생성 및 이동

   ```
   $ git checkout -b feature/main
   Switched to a new branch 'feature/main'
   (feature/main) $
   ```

2. 작업 완료 후 commit

   ```
   $ touch main.txt
   $ git add .
   $ git commit -m 'Complete main'
   $ git log --oneline
   054c123 (HEAD -> feature/main) Complete main
   ccc49f6 (master) Complete test page
   d786ac9 Init
   ```

3. master 이동

   ```
   $ git checkout master
   Switched to branch 'master'
   (master) $
   ```

4. *master에 추가 commit 이 발생시키기!!*

   - **다른 파일을 수정 혹은 생성하세요!**

   ```
   $ touch hotfix.txt
   $ git add .
   $ git commit -m 'Hotfix'
   $ git log --oneline
   ed25c45 (HEAD -> master) Hotfix
   ccc49f6 Complete test page
   d786ac9 Init
   ```

5. master에 병합

   ```
   $ git merge feature/main
   Merge made by the 'recursive' strategy.
    main.txt | 0
    1 file changed, 0 insertions(+), 0 deletions(-)
    create mode 100644 main.txt
   ```

6. 결과 -> 자동으로 *merge commit 발생*

   - vim 편집기 화면이 나타납니다.

   - 자동으로 작성된 커밋 메시지를 확인하고, `esc`를 누른 후 `:wq`를 입력하여 저장 및 종료를 합니다.

     - `w` : write
     - `q` : quit

   - 커밋을 확인 해봅시다.

     ```
     $ git log --oneline
     3027f6a (HEAD -> master) Merge branch 'feature/main'
     ed25c45 Hotfix
     054c123 (feature/main) Complete main
     ccc49f6 Complete test page
     d786ac9 Init
     ```

7. 그래프 확인하기

   ```
   $ git log --oneline --graph
   *   3027f6a (HEAD -> master) Merge branch 'feature/main'
   |\
   | * 054c123 (feature/main) Complete main
   * | ed25c45 Hotfix
   |/
   * ccc49f6 Complete test page
   * d786ac9 Init
   ```

8. branch 삭제

   ```
   $ git branch -d feature/main
   Deleted branch feature/main (was 054c123).
   ```

------

### 상황 3. merge commit 충돌

> 서로 다른 이력(commit)을 병합(merge)하는 과정에서 동일 파일이 수정되어 있는 상황
>
> git이 auto merging을 하지 못하고, 해당 파일의 위치에 라벨링을 해준다.
>
> 원하는 형태의 코드로 직접 수정을 하고 merge commit을 발생 시켜야 한다.

1. feature/sub branch 생성 및 이동

   ```
   (master) $ git checkout -b feature/sub
   Switched to a new branch 'feature/sub'
   (feature/sub)
   ```

2. 작업 완료 후 commit

   ```
   $ touch sub.txt
   $ git add .
   $ git commmit -m 'Complete sub'
   $ git log --oneline
   03523a8 (HEAD -> feature/sub) Complete sub
   3027f6a (master) Merge branch 'feature/main'
   ed25c45 Hotfix
   054c123 Complete main
   ccc49f6 Complete test page
   d786ac9 Init
   ```

   ```
   #=> README.md를 열어서 문구 자유롭게 추가! (서브라고 씀)
   $ git status
   On branch feature/sub
   Changes not staged for commit:
     (use "git add <file>..." to update what will be committed)
     (use "git restore <file>..." to discard changes in working directory)
           modified:   README.md
   
   no changes added to commit (use "git add" and/or "git commit -a")
   $ git add .
   $ git commit -m 'Update README'
   ```

3. master 이동

   ```
   $ git checkout master
   ```

4. *master에 추가 commit 이 발생시키기!!*

   - **동일 파일을 수정 혹은 생성하세요!**

     ```
     # README.md 파일 수정 (마스터라고 씀)
     $ git status
     On branch master
     Changes not staged for commit:
       (use "git add <file>..." to update what will be committed)
       (use "git restore <file>..." to discard changes in working directory)
             modified:   README.md
     
     no changes added to commit (use "git add" and/or "git commit -a")
     $ git add .
     $ git commit -m 'Update README@master'
     $ git log --oneline
     d9e69e3 (HEAD -> master) Update README@master
     3027f6a Merge branch 'feature/main'
     ed25c45 Hotfix
     054c123 Complete main
     ccc49f6 Complete test page
     d786ac9 Init
     ```

5. master에 병합

   ```
   $ git merge feature/sub
   # 자동 병합을 하고 있었다..
   Auto-merging README.md
   # 충돌!
   CONFLICT (content): Merge conflict in README.md
   # 자동병합실패;
   # 충돌을 고치고 결과를 커밋하세요.
   Automatic merge failed; fix conflicts and then commit the result.
   (master|MERGING)
   ```

6. 결과 -> *merge conflict발생*

   ```
   $ git status
   On branch master
   You have unmerged paths.
     (fix conflicts and run "git commit")
     (use "git merge --abort" to abort the merge)
   
   Changes to be committed:
           new file:   sub.txt
   
   Unmerged paths:
     (use "git add <file>..." to mark resolution)
     # 동시에 수정된 파일 : README
           both modified:   README.md
   ```

7. 충돌 확인 및 해결

   ```
   <<<<<<< HEAD
   # 프로젝트
   
   * 마스터 브랜치
   =======
   # 프로젝트 
   
   * sub기능 추가
   >>>>>>> feature/sub
   ```

8. merge commit 진행

   ```
   # 내가 원하는 방향으로 수정 후
   $ git add .
   ```

$ git commit

```
* vim 편집기 화면이 나타납니다.

* 자동으로 작성된 커밋 메시지를 확인하고, `esc`를 누른 후 `:wq`를 입력하여 저장 및 종료를 합니다.
   * `w` : write
   * `q` : quit
   
* 커밋이  확인 해봅시다.

9. 그래프 확인하기

 ```bash
 $ git log --oneline --graph
 *   94b7320 (HEAD -> master) Merge branch 'feature/sub'
 |\
 | * 24889cd (feature/sub) Update README
 | * 03523a8 Complete sub
 * | d9e69e3 Update README@master
 |/
 *   3027f6a Merge branch 'feature/main'
 |\
 | * 054c123 Complete main
 * | ed25c45 Hotfix
 |/
 * ccc49f6 Complete test page
 * d786ac9 Init
 ```


10. branch삭제

 
```
# .ipynb_checkpoints 삭제 방법

- **저장소 상위 디렉토리 기준 .ipynb_checkpoints 제거 (현재 디렉토리 아래의 모든 파일)**

  ```
  find . -name .ipynb_checkpoints -print0 | xargs -0 git rm -rf --ignore-unmatch 
  ```

  

  - **(추가) 앞으로 .ipynb_checkpoints를 업로드 안하고 싶다면**
    저장소 상위 디렉토리에 .gitignore 파일 생성 및 .ipynb_checkpoints 추가

    ~~~ 
     echo .ipynb_checkpoints >> .gitignore
    ~~~

- **변경 사항을 원격 저장소에 push**

  ```  
    git add --all
    git commit -m '.ipynb_checkpoints removed'
    git push origin main
  ```

  


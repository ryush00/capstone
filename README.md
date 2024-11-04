# 개발 환경 구축
본인의 컴퓨터를 통해 개발환경을 구축하기에는 복잡하기에, Github Codespace를 사용하여 만드는 것을 추천합니다.

## Codespace로 개발 환경 생성
우측 상단 `Code`를 누르고 `Create codespace on master` 클릭

![image](https://github.com/user-attachments/assets/b92121c7-f4e8-42cb-a25e-ea8019670c78)

개발 환경이 생성될 때까지 기다려 주세요.

개발 환경이 생성되면 아래 스크립트가 실행되면서 자동으로 서버가 실행됩니다. 서버가 이미 켜져 있는 경우 기존의 켜진 서버가 자동으로 종료됩니다.

만약 서버가 실행되지 않았다면 아래 명령어로 직접 실행해 주세요.

```bash
@ryush00 ➜ /workspace (main) $ .devcontainer/scripts/setup.sh
```

![image](https://github.com/user-attachments/assets/74de14ed-47b6-494f-8500-f28524b908ae)


# Ruby on Rails
## 서버 실행 방법
```bash
rails server -b 0.0.0.0
```

## 서버 콘솔 열기
```bash
rails console
```

![image](https://github.com/user-attachments/assets/f2bd8fa2-c444-4a31-9880-86f354267757)

## 이메일 미리보기
`주소/letter_opener` 경로에 들어가면 전송된 이메일 미리보기를 볼 수 있습니다.

## ERB
Ruby on Rails도 Spring처럼 MVC 프레임워크이므로, 모델, 뷰, 컨트롤러가 나뉘어져 있습니다. ERB는 뷰에서 쓰이는 문법입니다.

- Spring:  `<p>${name}님 안녕하세요!</p>`
- Django: `<p>{{ name }}님 안녕하세요!<p>`
- Ruby on Rails: `<p><%= name %>님 안녕하세요!</p>`

# Ruby
## Ruby와 Python과 차이점 몇가지
- `elif` 대신 `elsif` 사용
- `True`나 `False` 대신 `true`나 `false`를 사용
- `None` 대신 `nil` 사용

## 루비 코드 연습하기
### Try Ruby 사용
[https://try.ruby-lang.org/](https://try.ruby-lang.org/)

### Ruby IRB 사용
Python 기준으로 IDLE로 생각하시면 됩니다. `irb` 명령어를 입력하면 루비 함수를 입력할 수 있는 화면이 나타납니다. CTRL+C를 누르거나 `exit`을 입력하면 종료됩니다.

![image](https://github.com/user-attachments/assets/36abf424-aefa-4708-a687-e32d458e3983)

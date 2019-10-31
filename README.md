## 2019 스마트서울 모바일 앱 공모전



> 공모전명: 2019년 스마트서울 모바일 앱 공모전
>
> 공모과제: 서울시와 관련된 공익성을 담은 작품
>
> 공모기간: 2019. 8.1.(목) ~ 2019. 9. 30.(월)



### 기획배경
서울을 둘러싸고 있는 여러 산들을 등반하면서 등산을 조금 더 재밌게 하면서 정확한 기록을 측정 할 순 없을까? 하는 고민에서 시작되었습니다.



### 앱 기능 설명

* 각 산을 클릭하면 선택한 산의 1...3등의 유저 정보(카카오톡 프로필사진, 이름)가 보여짐 (랭킹기록은 Firebase DB에 등록 )

* `1위 탈환 시작` 버튼을 누르면 Map탭으로 이동하면서 지도의 카메라앵글이 클릭한 산의 위치로 이동

* 시작점(위도, 경도, 고도)에서 50m 안으로 들어오면 사진 촬영 버튼이 활성화

* 사진을 찍은 후 사진을 기기에 저장과 동시에 기록 시작 

* 도착지(위도, 경도, 고도)에서 50m 안으로 들어오면 사진 촬영 버튼이 활성화

* 1위와의 기록을 대조하여 랭킹 설정

* 유저의 등산 리스트를 개인기기의 DB에 저장하여 Profile에서 개인 등반 히스토리를 확인 할수 있다.

  

![1 2](https://user-images.githubusercontent.com/45986486/66750269-03226880-eec7-11e9-9d4e-df06d25cc873.png)



![2](https://user-images.githubusercontent.com/45986486/66750409-5c8a9780-eec7-11e9-853a-84af04463ffc.png)



### 기존 출시된 앱과의 차별성

사진을 찍는 순간 시간, 위치, 고도를 가져와  `출발-도착`의 정확한 등산기록을 간편하게 남길 수 있습니다.

사진을 찍는 버튼은 시작점의 일정 위치에 다다라야 활성화 되기 때문에 정확하고 공정한 기록을 측정합니다.



### 사용 기술

카카오 SDK로그인, 네이버 SDK 맵뷰, SQLite, Firebase Database, Firebase Storage, Forebase Remote Config , Lottie, snapkit, Kingfisher



### 협업툴

-  ##### JIRA

<img width="1336" alt="스크린샷 2019-10-13 오후 4 43 47" src="https://user-images.githubusercontent.com/47776915/66712509-ac3e6580-edd8-11e9-8c71-6594b83fcab1.png">

- ##### Sketch

<img width="763" alt="스크린샷 2019-09-16 오후 3 47 02 복사본" src="https://user-images.githubusercontent.com/47776915/66712556-5fa75a00-edd9-11e9-9109-c80a68a1a27f.png">



### 시현영상

[![Video Label](https://user-images.githubusercontent.com/45986486/67958275-4b1ceb80-fc3a-11e9-82da-cc05cbce43a5.png)](https://www.youtube.com/watch?v=IkA2mC--eB4=0s)
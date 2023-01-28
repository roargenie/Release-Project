
# 오늘 뭐 입지?
<img src="https://user-images.githubusercontent.com/105975078/215264532-212222e5-fa7f-43d9-9b6c-ef2e3969c71b.jpeg" width=20%><img src="https://user-images.githubusercontent.com/105975078/215264538-49073fc6-dc7d-4bd4-8362-5b65f1fed685.jpeg" width=20%><img src="https://user-images.githubusercontent.com/105975078/215264548-106da29a-b6ca-4d93-a62e-b9c89a2d910d.jpeg" width=20%><img src="https://user-images.githubusercontent.com/105975078/215264559-452c0d9f-4f62-445f-bfd8-38a591b33efb.jpeg" width=20%><img src="https://user-images.githubusercontent.com/105975078/215264567-e9b57c66-6334-4748-84f6-0f413af48e30.jpeg" width=20%>

### 앱 소개
- 개발기간 : 2022.09.09 ~ 2022.10.07(1개월)
- 출시날짜 : 2022.09.30
- 1인 개발 / 기획 / 디자인 프로젝트
- 사용자가 등록한 옷을 한눈에 볼 수 있도록 하여 손쉽게 옷장을 관리할 수 있도록 도와주는 서비스
- Figma, Notion 사용

### 주요 기능
- 보유중인 옷들을 추가 / 삭제 하여 관리
- 위치기반 서비스를 이용하여 날씨정보 제공
- 나만의 다이어리 작성
- 등록한 태그 기준으로 날씨에 따른 아이템 추천

### 기술 스택
- `MVC` `CodeBaseUI` `Alamofire` `YPImagePicker` `FSCalendar` `Realm` `Firebase Analytics` `Firebase Crashlytics` `Firebase Cloud Messaging` `Snapkit` `PanModal` `IQKeyboardManager` `CoreLocation`

### 기술 설명
- `Realm`을 사용한 데이터 베이스 구축[📌  스키마 설계 상세하게 보기](https://www.notion.so/a600206b53b14a92b1f989b0d4a89072#514e7b34cb734e0d8184873dcd80d1bc) 
  - 날씨, 카테고리, 아이템, 다이어리 4개의 테이블을 사용하여 카테고리 등 태그가 추가 되더라도 유지보수가 편리하도록 설계 
  - 각각의 테이블의 PK를 다른 연관된 테이블에서 FK로 사용하여 여러개의 테이블을 필터하여 조건에 맞는 데이터를 가져옴
- `FileManager`를 사용하여 `Realm`에 저장된 ObjectId로 파일 이름이 저장되도록 구현
- `Alamofire`로 API통신을 하여 날씨 정보를 가져오며, DB에 저장된 옷들을 현재 날씨에 맞게 추천
- `UIBezierPath`를 사용해 사용자가 현재 등록한 옷의 카테고리 비율을 쉽게 볼 수 있도록 프로그래스바 구현
- `ScrollView`를 사용하여 이미지 디테일 뷰 핀치 줌아웃 기능 구현
- `FSCalendar`를 사용하여 선택한 날짜에 작성한 다이어리를 `Realm Filter`를 통해 표현되도록 구현
  - 사용자가 보기 쉽게 선택날짜, 현재날짜 등 Calendar Custom

### 트러블 슈팅
[개발일지 보러가기](https://military-dugout-02f.notion.site/a600206b53b14a92b1f989b0d4a89072)
- 홈 화면 프로그래스바 이슈
  - UIView를 상속받은 클래스를 만들고 스택뷰에 프로그래스바 6개를 넣어주었는데, 레이아웃을 못잡는
    현상이 발생. 그려지는 시점의 문제라는 판단이 들어서 radius값을 고정값에서 비율로 바꾸고,
    셀에서 비동기 처리를 해주어서 문제 해결.
  ```swift
  func progressBarDrawing(color: UIColor, value: CGFloat) {
      let viewCenter = CGPoint(x: self.frame.width / 2, y: self.frame.height / 2)
      let radius = (self.frame.width - 10) / 2
      let backPath = UIBezierPath(arcCenter: viewCenter,
                                  radius: radius,
                                  startAngle: -(0.5 * .pi),
                                  endAngle: (1.5 * .pi),
                                  clockwise: true)

      let backLayer = CAShapeLayer()
      backLayer.path = backPath.cgPath
      backLayer.fillColor = UIColor.clear.cgColor
      backLayer.strokeColor = UIColor.systemGray6.cgColor
      backLayer.lineWidth = 8
      backLayer.lineJoin = .round
      backLayer.lineCap = .round
      self.layer.addSublayer(backLayer)

      let path = UIBezierPath(arcCenter: viewCenter,
                              radius: radius,
                              startAngle: -(0.5 * .pi),
                              endAngle: (1.5 * .pi),
                              clockwise: true)

      let layer = CAShapeLayer()
      layer.path = path.cgPath
      layer.strokeColor = color.cgColor
      layer.fillColor = UIColor.clear.cgColor
      layer.lineJoin = .round
      layer.lineCap = .round
      layer.lineWidth = 8
      self.layer.addSublayer(layer)

      let animation = CABasicAnimation(keyPath: "strokeEnd")
      animation.fromValue = 0
      animation.toValue = value
      animation.isRemovedOnCompletion = false
      animation.fillMode = .forwards
      animation.duration = 1.0
      layer.add(animation, forKey: "strokeEnd")
  }
  ```
- 아이템 추가 화면 카테고리 정렬시 역으로 여러가지 페치가 일어나는 상황에서의 이슈
  - Realm fetch를 viewWillAppear에서 해주고 있었는데, 한 가지 방식으로만 fetch 할 수 있어서
    클로저를 이용하여 문제 해결.
  ```swift
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.section == 0 {
            dataSendClosure?(repository.fetch(ClothItem.self).sorted(byKeyPath: "regDate", ascending: false))
            self.dismiss(animated: true)
        } else {
            switch indexPath.row {
            case 0:
                dataSendClosure?(repository.clothItemCategoryFilter(query: "아우터"))
            case 1:
                dataSendClosure?(repository.clothItemCategoryFilter(query: "상의"))
            case 2:
                dataSendClosure?(repository.clothItemCategoryFilter(query: "하의"))
            case 3:
                dataSendClosure?(repository.clothItemCategoryFilter(query: "신발"))
            case 4:
                dataSendClosure?(repository.clothItemCategoryFilter(query: "악세"))
            case 5:
                dataSendClosure?(repository.clothItemCategoryFilter(query: "기타"))
            default:
                break
            }
            self.dismiss(animated: true)
        }
  }
  ```
- 아이템 상세보기 스크롤뷰 핀치 줌 / 아웃 이슈
  - 스크롤뷰에 ImageView를 addSubView해두었는데, 스크롤뷰 크기를 잡지 못해서
    무한 스크롤이 되는 문제가 발생.
    ImageView의 width, height값을 설정하여 문제 해결.

  ```swift
  override func setConstraints() {
        detailImageView.snp.makeConstraints { make in
            make.center.equalTo(scrollView.snp.center)
            make.width.equalTo(self.snp.width)
            make.height.equalTo(self.snp.height)
        }
        scrollView.snp.makeConstraints { make in
            make.edges.equalTo(self.safeAreaLayoutGuide)
        }
        cancelButton.snp.makeConstraints { make in
            make.leading.top.equalTo(self.safeAreaLayoutGuide).offset(4)
            make.width.height.equalTo(60)
        }
  }
  ```

### 회고
- 잘한 점
  - 디자인 보다는 기능에 초점을 두고, 기획했던 기능들을 기한에 맞게 모두 구현했다.
  - `Realm`과의 동침을 하며 공식문서를 정말 많이 봤고, 테이블을 여러개 사용한 복잡한 데이터도 filter를 할 수 있게 되었다.
  - 시간이 걸리더라도 차트 라이브러리를 사용하지 않고 구현함으로써 `UIBezierPath`를 사용해보게 되었다.
  
- 잘못한 점
  - 네이밍의 중요성을 깨닫지 못하고 막 쓰다보니 뼈저리게 느끼게 되었다.
  - `Realm`에 너무 초점을 맞추다 보니 `API`사용을 많이 해보지 못했다. 
  - Raw한 문자열 관리, 반복코드 줄이기 등 나중에 해야지 하면서 지나치다 보니 나중에 고치기가 너무 힘들었다.


class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable,
         :trackable

  encrypts :account_number, :account_bank, :account_name

  BANK_NAMES = [
    "한국은행", "산업은행", "기업은행", "국민은행", "외환은행",
    "수협중앙회", "수출입은행", "농협은행", "지역농.축협",
    "우리은행", "SC은행", "한국씨티은행", "대구은행", "부산은행",
    "광주은행", "제주은행", "전북은행", "경남은행", "새마을금고중앙회",
    "신협중앙회", "상호저축은행", "중국은행", "모건스탠리은행", "HSBC은행",
    "도이치은행", "알비에스피엘씨은행", "제이피모간체이스은행", "미즈호은행",
    "미쓰비시도쿄UFJ은행", "BOA은행", "비엔피파리바은행", "중국공상은행",
    "산림조합중앙회", "대화은행", "교통은행", "우체국", "신용보증기금",
    "기술보증기금", "KEB하나은행", "신한은행", "케이뱅크", "카카오뱅크",
    "토스뱅크", "한국주택금융공사", "서울보증보험", "경찰청",
    "한국전자금융(주)", "금융결제원"
  ]

  # 검증 추가
  validates :account_bank, inclusion: { in: BANK_NAMES, message: "은행명이 유효하지 않습니다" }, allow_blank: true

  # 한글,영어 이름 만 허용
  validates :account_name, format: { with: /\A[가-힣ㄱ-ㅎㅏ-ㅣA-Za-z()-]+\z/, message: "입금자는 한글, 영어 이름 만 입력 가능합니다." }, allow_blank: true

  # 계좌번호(예.123-456)형식 만 허용
  validates :account_number, format: { 
    with: /\A\d+(-\d+)*\z/, 
    message: "계좌번호는 통장 번호 만 입력 가능합니다." 
  }, allow_blank: true

end

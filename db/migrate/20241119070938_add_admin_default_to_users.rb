class AddAdminDefaultToUsers < ActiveRecord::Migration[7.2]
  def change
    # admin의 기본 값을 false로 설정
    change_column_default :users, :admin, from: nil, to: false
  end
end

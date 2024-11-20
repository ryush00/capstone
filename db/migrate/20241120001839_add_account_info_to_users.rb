class AddAccountInfoToUsers < ActiveRecord::Migration[7.2]
  def change
    add_column :users, :account_number, :string, comment: "계좌번호"
    add_column :users, :account_bank, :string, comment: "은행명"
    add_column :users, :account_name, :string, comment: "예금주"
  end
end

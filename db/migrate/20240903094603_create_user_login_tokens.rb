class CreateUserLoginTokens < ActiveRecord::Migration[7.2]
  def change
    create_table :user_login_tokens do |t|
      t.timestamps
    end
  end
end

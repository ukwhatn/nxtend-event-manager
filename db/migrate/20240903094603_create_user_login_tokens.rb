class CreateUserLoginTokens < ActiveRecord::Migration[7.2]
  def change
    create_table :user_login_tokens do |t|
      t.bigint :discord_id, null: false
      t.string :token, null: false
      t.datetime :expired_at, null: false
      t.boolean :is_used, null: false, default: false
      t.timestamps
    end
  end
end

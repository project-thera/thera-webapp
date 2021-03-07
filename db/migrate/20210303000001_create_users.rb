class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :username, null: false
      t.string :fullname, null: true

      t.timestamps null: false
      
      t.datetime :discarded_at
    end
  end
end

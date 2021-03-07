class CreateGroups < ActiveRecord::Migration[6.0]
  def change
    create_table :groups do |t|
      t.string :name

      t.timestamps null: false
      
      t.datetime :discarded_at
    end
  end
end

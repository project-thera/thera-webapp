class CreateGroupsUsersJoinTable < ActiveRecord::Migration[6.0]
  def change
    create_join_table :groups, :users do |t|
      t.index :group_id
      t.index :user_id

      t.timestamps null: false
    end
  end
end

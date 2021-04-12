class CreateGameRewards < ActiveRecord::Migration[6.0]
  def change
    create_table :game_rewards do |t|
      t.integer :credits, default: 0, null: false
      t.integer :robots, default: 0, null: false

      t.text :current_robot
    end
  end
end

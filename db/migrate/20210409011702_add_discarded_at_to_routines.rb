class AddDiscardedAtToRoutines < ActiveRecord::Migration[6.0]
  def change
    add_column :routines, :discarded_at, :datetime
    add_index :routines, :discarded_at
  end
end

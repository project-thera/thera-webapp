class AddRecoverableAndConfirmableToUsers < ActiveRecord::Migration[6.0]
  def self.up
    change_table :users do |t|
      ## Confirmable
      t.string   :confirmation_token
      t.datetime :confirmed_at
      t.datetime :confirmation_sent_at
      t.string   :unconfirmed_email # Only if using reconfirmable

      ## Recoverable
      t.string   :reset_password_token
      t.datetime :reset_password_sent_at
    end

    User.update_all confirmed_at: DateTime.now

    # add_index :users, :email,                unique: true, name: 'unique_email' 
    # add_index :users, :reset_password_token, unique: true, name: 'unique_password_token'
    # add_index :users, :confirmation_token,   unique: true, name: 'unique_confirmation_token'
  end

  def self.down
    # By default, we don't want to make any assumption about how to roll back a migration when your
    # model already existed. Please edit below which fields you would like to remove in this migration.
    raise ActiveRecord::IrreversibleMigration
  end
end

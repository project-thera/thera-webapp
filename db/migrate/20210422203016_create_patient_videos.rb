class CreatePatientVideos < ActiveRecord::Migration[6.0]
  def change
    create_table :patient_videos do |t|
      t.belongs_to :patient, foreign_key: { to_table: :users }, null: false
      t.string :video, null: false

      t.timestamps null: false
    end
  end
end

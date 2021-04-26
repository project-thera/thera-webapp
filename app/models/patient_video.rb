class PatientVideo < ApplicationRecord
  belongs_to :patient,
    foreign_key: :patient_id,
    class_name: 'User',
    required: true

  mount_base64_uploader :video, VideoUploader

  validates :video, presence: true

  scope :supervised_by, -> (user) {
    joins(:patient).where(users: { supervisor_id: user.id })
  }

  scope :owned_by, -> (user) {
    where(patient: user)
  }
end

class PatientVideo < ApplicationRecord
  belongs_to :patient,
    foreign_key: :patient_id,
    class_name: 'User',
    required: true

  has_one :supervisor,
    through: :patient

  mount_base64_uploader :video, VideoUploader

  validates :video, presence: true

  scope :supervised_by, -> (user) {
    where(supervisor: user)
  }

  scope :owned_by, -> (user) {
    where(patient: user)
  }
end

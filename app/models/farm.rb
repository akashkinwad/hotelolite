class Farm < ApplicationRecord
  has_one_attached :banner
  has_many_attached :images

  belongs_to :user
  has_many :bookings
  has_many :sections, inverse_of: :farm
  accepts_nested_attributes_for :sections, reject_if: :all_blank, allow_destroy: true

  scope :with_eager_loaded_images, -> { eager_load(images_attachments: :blob) }
end

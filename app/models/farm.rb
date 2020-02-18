class Farm < ApplicationRecord
  has_one_attached :banner
  has_many_attached :images

  belongs_to :user
  has_many :bookings

  scope :with_eager_loaded_images, -> { eager_load(images_attachments: :blob) }
end

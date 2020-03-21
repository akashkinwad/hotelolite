class Farm < ApplicationRecord
  extend FriendlyId
  friendly_id :title, use: :slugged
  enum status: { inactive: 0, active: 1 }

  has_one_attached :banner
  has_many_attached :images

  belongs_to :user
  has_many :bookings
  has_many :sections, inverse_of: :farm
  has_many :rates, inverse_of: :farm
  has_and_belongs_to_many :categories, join_table: :farm_categories

  accepts_nested_attributes_for :sections, reject_if: :all_blank, allow_destroy: true
  accepts_nested_attributes_for :rates, reject_if: :all_blank, allow_destroy: true

  scope :with_eager_loaded_images, -> { eager_load(images_attachments: :blob) }
  scope :active, -> { where(status: 1) }
  scope :featured, -> { where(is_featured: true) }

  def name
    title ? title : 'Default'
  end
end

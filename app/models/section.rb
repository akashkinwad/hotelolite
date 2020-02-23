class Section < ApplicationRecord
  validates :name, presence: true
  belongs_to :farm
  has_many :sub_sections, inverse_of: :section
  accepts_nested_attributes_for :sub_sections, reject_if: :all_blank, allow_destroy: true
end

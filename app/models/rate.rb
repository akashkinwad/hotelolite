class Rate < ApplicationRecord
  validates :title,
            :amount,
            presence: true

  belongs_to :farm
end

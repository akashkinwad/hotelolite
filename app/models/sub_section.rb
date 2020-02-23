class SubSection < ApplicationRecord
  validates :title,
            :description,
            presence: true

  belongs_to :section
end

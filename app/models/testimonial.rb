class Testimonial < ApplicationRecord
  validates :name, :text, presence: true
end

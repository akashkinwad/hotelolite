class Category < ApplicationRecord
  validates :title, presence: true

  def self.select_options
    all.map{ |cat| [cat.title, cat.id] }
  end
end

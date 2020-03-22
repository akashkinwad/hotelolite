class ApiToken < ApplicationRecord
  validates :token, presence: true
end

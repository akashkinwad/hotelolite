class ApiToken < ApplicationRecord

  default_scope { order("created_at DESC") }

  belongs_to :user
  validates :name, presence: true

  before_create :set_access_token

  private

  def set_access_token
    self.token = generate_token
  end

  def generate_token
    loop do
      token = SecureRandom.hex(25)
      break token unless ApiToken.where(token: token).exists?
    end
  end

end

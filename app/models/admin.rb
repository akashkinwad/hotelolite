class Admin < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :first_name, presence: true, length: { minimum: 2 }
  validates :last_name, presence: true, length: { minimum: 2 }

  has_many :subsciptions, as: :resource, class_name: 'Admin'

  def admin_name
    first_name.present? ? first_name : email
  end

  def full_name
    "#{first_name} #{last_name}"
  end

  def name_abbrivation
    admin_name.chr.upcase
  end

end

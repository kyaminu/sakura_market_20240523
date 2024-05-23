class Administration < ApplicationRecord
  devise :database_authenticatable, :registerable, :rememberable, :validatable

  validates :email, presence: true

  scope :default_order, -> { order(:id) }
end

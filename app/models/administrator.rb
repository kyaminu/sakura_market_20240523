class Administrator < ApplicationRecord
  devise :database_authenticatable, :rememberable, :validatable

  validates :email, presence: true

  scope :default_order, -> { order(:id) }
end

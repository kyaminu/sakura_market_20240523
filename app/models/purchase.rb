class Purchase < ApplicationRecord
  extend Enumerize

  belongs_to :user, optional: true

  enumerize :delivery_time, in:
    %i[
      eight_to_twelve
      twelve_to_two
      two_to_four
      four_to_six
      six_to_eight
      eight_to_nine
    ],default: :eight_to_twelve

  validates :delivery_fee, presence: true, numericality: { greater_than_or_equal_to: 600 }
  validates :handling_fee, presence: true, numericality: { greater_than_or_equal_to: 300, less_than_or_equal_to: 900 }
  validates :delivery_on, presence: true
  validates :delivery_time, presence: true
  validates :name, presence: true
  validates :phone_number, presence: true
  validates :postal_code, presence: true
  validates :address, presence: true

  scope :default_order, -> { order(created_at: :desc) }
end

class Item < ApplicationRecord
  acts_as_list

  has_many_attached :images do |attachable|
    attachable.variant(:thumb, resize_to_fill: [120, 80])
    attachable.variant(:full, resize_to_fit: [300, 200])
  end

  validates :name, presence: true, uniqueness: true
  validates :description, presence: true
  validates :images, presence: true
  validates :price_excluding_tax, presence: true, numericality: { greater_than_or_equal_to: 1 }
  validates :position, presence: true
  validates :tax_rate, presence: true

  scope :default_order, -> { order(:position) }
  scope :published, -> { where(published: true) }
end

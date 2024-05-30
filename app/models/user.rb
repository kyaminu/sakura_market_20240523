class User < ApplicationRecord
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable

  has_many :addresses, dependent: :destroy
  has_one :cart, dependent: :destroy
  after_create :create_cart

  validates :email, presence: true

  scope :default_order, -> { order(:id) }

  def update_without_password(params, *options)
    if params.delete(:password) && params.delete(:password_confirmation).blank?
      params.delete(:password)
      params.delete(:password_confirmation)
    end

    result = update(params, *options)
    clean_up_passwords
    result
  end

  private

    def create_cart
      self.create_cart!
    end
end

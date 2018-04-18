class User < ApplicationRecord
  # Validations
  validates_presence_of :email, :password_digest
  validates :email, uniqueness: true

  # Associations
  has_many :messages, dependent: :destroy
  has_many :likes, dependent: :destroy

  # encrypt password
  has_secure_password

  def likes?(message)
    message.likes.where(user_id: id).any?
  end
end

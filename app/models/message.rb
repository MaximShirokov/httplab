class Message < ApplicationRecord
  # Validations
  validates_presence_of :text
  validates :text, length: { in: 5..140 }

  # Associations
  belongs_to :user
  has_many :likes, dependent: :destroy
end

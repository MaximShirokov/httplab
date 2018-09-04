# frozen_string_literal: true

class Message < ApplicationRecord
  # Validations
  validates :text, presence: true
  validates :text, length: { in: 5..140 }

  # Associations
  belongs_to :user
  has_many :votes, dependent: :destroy
end

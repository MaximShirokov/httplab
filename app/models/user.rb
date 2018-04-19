class User < ApplicationRecord
  # Validations
  validates_presence_of :email, :password_digest
  validates :email, uniqueness: true

  # Associations
  has_many :messages, dependent: :destroy
  has_many :likes, dependent: :destroy

  # Scopes
  scope :top_by_messages, -> (period = nil) do
    case period
    when :one_day
      left_joins(:messages).where('messages.created_at = ?', 1.day.ago)
    when :one_week
      left_joins(:messages).where('messages.created_at = ?', 1.week.ago)
    else
      left_joins(:messages)
    end.group(:id).order('COUNT(messages.id) DESC').limit(5)
  end

  scope :top_by_likes, -> (period = nil) do
    case period
    when :one_day
      left_joins(:likes).where('likes.created_at = ?', 1.day.ago)
    when :one_week
      left_joins(:likes).where('likes.created_at = ?', 1.week.ago)
    else
      left_joins(:likes)
    end.group(:id).order('COUNT(likes.id) DESC').limit(5)
  end

  # encrypt password
  has_secure_password

  def likes?(message)
    message.likes.where(user_id: id).any?
  end
end

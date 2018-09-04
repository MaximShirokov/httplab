# frozen_string_literal: true

class User < ApplicationRecord
  # Validations
  validates :email, :password_digest, presence: true
  validates :email, uniqueness: true

  # Associations
  has_many :messages, dependent: :destroy
  has_many :votes, dependent: :destroy

  # encrypt password
  has_secure_password

  # Scopes
  scope :top_by_avg_messages_rating, lambda { |period = nil|
    if period == :last_day
      period_in_time = 1.day.ago
    elsif period == :last_week
      period_in_time = 1.week.ago
    end

    messages =  if %i[last_day last_week].include?(period)
                  Message.where('created_at = ?', period_in_time).joins(:votes)
                else
                  Message.joins(:votes)
                end

    users_ids = messages.select('messages.user_id, avg(votes.rating) as average_rating')
      .group('messages.user_id')
      .order('average_rating DESC')

    where(id: users_ids)
  }

  def votes?(message)
    message.votes.where(user_id: id).any?
  end
end

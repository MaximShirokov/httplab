class User < ApplicationRecord
  # Validations
  validates_presence_of :email, :password_digest
  validates :email, uniqueness: true

  # Associations
  has_many :messages, dependent: :destroy
  has_many :votes, dependent: :destroy

  # Scopes
  scope :top_by, -> (scope, period = nil) do
    if period == :last_day
      period_in_time = 1.day.ago
    elsif period == :last_week
      period_in_time = 1.week.ago
    end

    case period
    when :last_day, :last_week
      left_joins(scope).where("#{scope}.created_at = ?", period_in_time)
    else
      left_joins(scope)
    end.group(:id).order("COUNT(#{scope}.id) DESC").limit(5)
  end

  scope :top_by_avg_messages_rating, -> (period = nil) do
    if period == :last_day
      period_in_time = 1.day.ago
    elsif period == :last_week
      period_in_time = 1.week.ago
    end

    users_ids = case period
                when :last_day, :last_week
                  Message.where("created_at = ?", period_in_time).joins(:votes)
                else
                  Message.joins(:votes)
                end.select('messages.user_id, avg(votes.rating) as average_rating')
                  .group('messages.user_id')
                  .order('average_rating DESC')

    where(id: users_ids)
  end


  # encrypt password
  has_secure_password

  def votes?(message)
    message.votes.where(user_id: id).any?
  end
end

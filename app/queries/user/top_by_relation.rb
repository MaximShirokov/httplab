# frozen_string_literal: true

module Queries
  class User::TopByRelation
    def initialize(initial_scope)
      @initial_scope = initial_scope
    end

    def call(relation:, period: nil)
      periods = { last_day: 1.day.ago, last_week: 1.week.ago }
      qperiod = periods[period]

      if qperiod.present?
        @initial_scope.left_joins(relation).where("created_at <= ?", qperiod)
      else
        @initial_scope.left_joins(relation)
      end.group(:id).order("COUNT(#{relation}.id) DESC").limit(5)
    end
  end
end

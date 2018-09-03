# frozen_string_literal: true

class MessageSerializer < ActiveModel::Serializer
  attributes :id, :text, :user_id
end

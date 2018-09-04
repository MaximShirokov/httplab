# frozen_string_literal: true

class AddIndexRatingToVotes < ActiveRecord::Migration[5.1]
  def change
    add_index :votes, :rating
  end
end

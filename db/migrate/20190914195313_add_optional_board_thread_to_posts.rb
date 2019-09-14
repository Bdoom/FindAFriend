# frozen_string_literal: true

class AddOptionalBoardThreadToPosts < ActiveRecord::Migration[5.2]
  def change
    add_reference :posts, :board_thread, foreign_key: true
  end
end

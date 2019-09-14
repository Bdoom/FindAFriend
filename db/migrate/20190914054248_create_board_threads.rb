# frozen_string_literal: true

class CreateBoardThreads < ActiveRecord::Migration[5.2]
  def change
    create_table :board_threads do |t|
      t.belongs_to :board
      t.belongs_to :user
      t.string :title
      t.text :body

      t.timestamps
    end
  end
end

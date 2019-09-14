# frozen_string_literal: true

class BoardsController < ApplicationController
    
  def index
    @boards = Board.all
  end

  def show
    @board = Board.find_by(name: params[:id])

    if @board.board_threads.count.positive?
        @threads = @board.board_threads.order('created_at DESC') 
    end

  end

end

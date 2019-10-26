# frozen_string_literal: true

class BoardsController < ApplicationController

  breadcrumb 'Boards', :boards_path, only: [:show]
    
  def index
    @boards = Board.all

    @page_title       = 'Boards'
    @page_description = 'uwuanimu.com message boards.'
  end

  def show
    @board = Board.find_by(name: params[:id])

    if @board.board_threads.count.positive?
        @threads = @board.board_threads.order('created_at DESC') 
    end

    breadcrumb @board.name, board_path(@board)
    @page_title       = @board.name
    @page_description = @board.description
  end

end

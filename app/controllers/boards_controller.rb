# frozen_string_literal: true

class BoardsController < ApplicationController
  def index
    @boards = Board.all
  end

  def show
    @board = Board.find_by(name: params[:id])

  end
end

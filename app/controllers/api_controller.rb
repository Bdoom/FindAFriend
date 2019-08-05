class ApiController < ApplicationController

  def status
    render json: { data: 'ok' }
  end

end

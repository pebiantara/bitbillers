class MarketsController < ApplicationController

  def index
    render json: prices_json
  end
end
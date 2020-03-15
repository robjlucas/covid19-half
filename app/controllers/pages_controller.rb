class PagesController < ApplicationController
  def show
    render action: params.fetch(:page)
  end
end

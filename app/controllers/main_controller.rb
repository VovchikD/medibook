# frozen_string_literal: true

class MainController < BaseController
  def index
    render inertia: 'main/Index'
  end
end

# frozen_string_literal: true

class LandingController < ApplicationController
  def index
    @users = User.all
  end
end

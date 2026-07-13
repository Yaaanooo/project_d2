class GamesController < ApplicationController
  def top
    @genres = Genre.all
  end

  def quiz
  end

  def result
  end
end

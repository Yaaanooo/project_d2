class AdminsController < ApplicationController
  def list
  @results=Question.all
  @genres=Genre.all
  end
  def search
  @genres=Genre.all
  query = params[:query]
  @results = Question.where("body LIKE ?", "%#{query}%").where(id: params[:sGenres]||[])
  render :list
  end

  def new
    @new_table = Question.new
    @genre_tables = Genre.all
  end

# TOP画面とジャンル関連
  def genre
    @genres = Genre.all
  end
  def update_genre
    @genre = Genre.first || Genre.new
    if @genre.update(genre_params)
      redirect_to game_top_path
    else
      render :genre
    end
  end
  private
  def genre_params
    params.require(:genre).permit(
      :genre1_area,
      :genre2_area,
      :genre3_area,
      :genre4_area,
      :genre5_area
    )
  end

end

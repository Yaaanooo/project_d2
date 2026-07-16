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

#new画面
 def create
    @new_table = Question.new(question_params)

    if @new_table.save
      redirect_to admins_list_path, notice: "新しい問題を追加しました！"
    else
      @genre_tables = Genre.all
      render :new, status: :unprocessable_entity
    end
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

  def question_params
    params.require(:question).permit(
      :genre_id, 
      :body, 
      :correct_answer, 
      :wrong_answer_1, 
      :wrong_answer_2, 
      :wrong_answer_3
    )
  end

  
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

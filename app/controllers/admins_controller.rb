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
# new

def create
    @new_table = Question.new(question_params)

    if @new_table.save
      redirect_to admins_list_path, notice: "新しい問題を追加しました！"
    else
      @genre_tables = Genre.all
      render :new, status: :unprocessable_entity
    end
  end

  private
  def question_params
    # @new_table (Questionモデル) のフォームから送られてくるパラメータを許可する
    params.require(:question).permit(
      :genre_id, 
      :body, 
      :correct_answer, 
      :wrong_answer_1, 
      :wrong_answer_2, 
      :wrong_answer_3
    )
  end

# TOP画面とジャンル関連
  # def genre
  #   @genres = Genre.all
  # end
  # def genre_new
  #   @genres = Genre.new
  # end
  # def crerate
  #   # @genre = Genre.first || Genre.new
  #   # if @genre.crerate(genre_params)
  #   #   redirect_to game_top_path
  #   # else
  #   #   render :genre
  #   # end
  # end
    # ジャンル登録画面
  def genre
    @genres = Genre.order(:id).limit(5)
  end

  # ジャンルを登録・更新
  def update_genre
    genre_names = params[:genre_names] || []
    genres = Genre.order(:id).limit(5)

    Genre.transaction do
      genre_names.each_with_index do |genre_name, index|
        genre_name = genre_name.strip

        # 既存のジャンルがある場合
        if genres[index].present?
          genres[index].update!(genre_name: genre_name)

        # 既存データがなく、入力されている場合
        elsif genre_name.present?
          Genre.create!(genre_name: genre_name)
        end
      end
    end
  

    redirect_to games_top_path, notice: "ジャンルを登録しました"
  rescue ActiveRecord::RecordInvalid
    @genres = Genre.order(:id).limit(5)
    flash.now[:alert] = "ジャンルを登録できませんでした"
    render :genre, status: :unprocessable_entity
  end
end


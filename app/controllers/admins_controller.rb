class AdminsController < ApplicationController
  def list
    @results = Question.all
    @genres = Genre.all
  end

  def search
    @genres = Genre.all
    query = params[:query]
    @results = Question.where("body LIKE ?", "%#{query}%").where(id: params[:sGenres] || [])
    render :list
  end

  # 問題追加（初期表示）
  def new
    if params[:id].present?
      @new_table = Question.find(params[:id])
    else
      @new_table = Question.new
    end
    @genre_tables = Genre.all
  end

  # 問題作成（保存処理）
  def create
    @new_table = Question.new(question_params)
    if @new_table.save
      redirect_to admins_list_path, notice: "新しい問題を追加しました！"
    else
      @genre_tables = Genre.all
      render :new, status: :unprocessable_entity
    end
  end

  # 問題更新
  def update
    @new_table = Question.find(params[:id])
    if @new_table.update(question_params)
      redirect_to admins_list_path, notice: "問題を更新しました！"
    else
      @genre_tables = Genre.all
      render :new, status: :unprocessable_entity
    end
  end

  # 問題削除
  def destroy
    question = Question.find(params[:id])
    question.destroy
    redirect_to admins_list_path, notice: "問題を削除しました"
  end

  # ジャンル関連
  def genre
    @genres = Genre.order(:id).limit(5)
  end

  def update_genre
    genre_names = params[:genre_names] || []
    genres = Genre.order(:id).limit(5)

    Genre.transaction do
      genre_names.each_with_index do |genre_name, index|
        genre_name = genre_name.strip
        if genres[index].present?
          genres[index].update!(genre_name: genre_name)
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
end
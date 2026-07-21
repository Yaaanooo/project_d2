class GamesController < ApplicationController
  def top
    @genres = Genre.all
  end

  def start
    genre_id = params[:genre_id]
    question_count = params[:question_count].to_i

    questions = Question.where(genre_id: genre_id).sample(question_count)

    if questions.empty?
      redirect_to root_path, alert: "問題が登録されていません"
      return
    end

    session[:question_ids] = questions.map(&:id)
    session[:question_index] = 0
    session[:correct_count] = 0
    session[:answers] = {}

    session[:choices] = {}

    questions.each do |question|
      session[:choices][question.id.to_s] = [
        question.correct_answer,
        question.wrong_answer_1,
        question.wrong_answer_2,
        question.wrong_answer_3
      ].shuffle
    end

    redirect_to game_quiz_path
  end



  # クイズ画面
  def quiz
    if Question.count.zero?
      redirect_to root_path, alert: "問題が登録されていません"
      return
    end

    if session[:question_index] >= session[:question_ids].length
      redirect_to games_result_path
      return
    end

    question_id = session[:question_ids][session[:question_index]]
    @question = Question.find_by(id: question_id)

    unless @question
      redirect_to root_path, alert: "問題データを取得できませんでした"
      return
    end

    @question_number = session[:question_index] + 1

    @choices = session[:choices][@question.id.to_s]

  end

  # 次へボタン
  def next
    question_id = session[:question_ids]&.[](session[:question_index])
    question = Question.find_by(id: question_id)

    unless question
      reset_quiz_session
      redirect_to root_path, alert: "問題データを取得できませんでした"
      return
    end

    user_answer = params[:user_answer]

    if user_answer == question.correct_answer
      session[:correct_count] += 1
    end

    session[:question_index] += 1

    if session[:question_index] >= session[:question_ids].length
      redirect_to games_result_path
    else
      redirect_to game_quiz_path
    end
  end

  # 前へボタン
  def back
    # 1問目ならそのまま
    if session[:question_index] > 0
      session[:question_index] -= 1
    end

    redirect_to game_quiz_path
end




  def result
    @genre = Genre.find_by(session[:genre_id])

    @correct_count = session[:correct_count]
    @question_count =session[:question_ids].length

    @correct_rate = @correct_count.to_f / @question_count

    if @correct_rate == 1.0
      @comment = "全問正解！！素晴らしい！"
    elsif @correct_rate >= 0.8
      @comment = "あと少しで満点！"
    elsif @correct_rate >= 0.6
      @comment = "よく頑張りました！"
    else
      @comment = "もう一度挑戦してみましょう"
    end

  end

end


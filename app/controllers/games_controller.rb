class GamesController < ApplicationController
  def top
    @genres = Genre.all
  end





  # クイズ画面
  def quiz
    if Question.count.zero?
      redirect_to root_path, alert: "問題が登録されていません"
      return
    end

    session[:question_ids] ||= Question.all.sample(5).map(&:id)
    session[:question_index] ||= 0
    session[:correct_count] ||= 0

    if session[:question_index] >= session[:question_ids].length
      redirect_to games_result_path
      return
    end

    question_id = session[:question_ids][session[:question_index]]
    @question = Question.find_by(id: question_id)

    unless @question
      reset_quiz_session
      redirect_to root_path, alert: "問題データを取得できませんでした"
      return
    end

    @question_number = session[:question_index] + 1

    @choices = [@question.correct_answer, @question.wrong_answer_1, @question.wrong_answer_2, @question.wrong_answer_3].shuffle
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
    # TODO: quiz画面で計算した結果（ジャンル名・正解数・問題数・コメント）を受け取るように変更する
    @genre = "ネットワーク"
    @score = 3
    @total = 5
    @comment = "よくできました！"
  end

end

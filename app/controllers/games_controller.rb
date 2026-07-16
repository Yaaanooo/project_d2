class GamesController < ApplicationController
  def top
    @genres = Genre.all
  end

  def quiz
  end

  def result
    # TODO: quiz画面で計算した結果（ジャンル名・正解数・問題数・コメント）を受け取るように変更する
    @genre = "ネットワーク"
    @score = 3
    @total = 5
    @comment = "よくできました！"
  end

end

# README

問題追加CSV
コンソールを開いて
以下のコマンドをENDまでコピペする

require "csv"

CSV.foreach(Rails.root.join("db", "questions.csv"), headers: true) do |row|
Question.create!(
genre_id: row["genre_id"],
body: row["body"],
correct_answer: row["correct_answer"],
wrong_answer_1: row["wrong_answer_1"],
wrong_answer_2: row["wrong_answer_2"],
wrong_answer_3: row["wrong_answer_3"]
)
end

開発基礎チームD
クイズの作成

- OKADA

- KAWAI

- TOJO

- MISHIMA

- YANO

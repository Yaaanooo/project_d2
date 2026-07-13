class CreateGames < ActiveRecord::Migration[7.1]
  def change
    create_table :games do |t|
      t.integer :question_id
      t.integer :question_number
      t.integer :f_correct_answer
      t.integer :f_wrong_answer_1
      t.integer :f_wrong_answer_2
      t.integer :f_wrong_answer_3
      t.integer :f_user_answer

      t.timestamps
    end
  end
end

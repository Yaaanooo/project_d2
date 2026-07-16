class Question < ApplicationRecord
  belongs_to :genre
  has_many :games

  validates :genre_id, presence: true
  validates :body, presence: true
  validates :correct_answer, presence: true
  validates :wrong_answer_1, presence: true
  validates :wrong_answer_2, presence: true
  validates :wrong_answer_3, presence: true
end
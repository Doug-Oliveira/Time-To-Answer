class Question < ApplicationRecord
  belongs_to :subject, inverse_of: :questions
  has_many :answers

  accepts_nested_attributes_for :answers, reject_if: :all_blank, allow_destroy: true
  
  #paginates_per 8
  
  def self.list_questions_params(page_params)
    Question.includes(:answers)
            .where('lower(description) LIKE ?', "%#{page_params.downcase}%")
  end
  
  def self.list_questions
    Question.includes(:answers)
            .order('created_at desc')
  end
end

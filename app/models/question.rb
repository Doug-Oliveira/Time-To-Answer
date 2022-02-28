class Question < ApplicationRecord
  belongs_to :subject, counter_cache: true, inverse_of: :questions
  #atualiza o banco apos adicionar a coluna para contagem de assunto.(counter_cache)
  # x = Subject.last
  #Subject.reset_counters(x.id, :questions)

  has_many :answers

  accepts_nested_attributes_for :answers, reject_if: :all_blank, allow_destroy: true
  
  #paginates_per 8
  
  #scope são usadas quando é necessario fazer alguma pesquisa no model
  scope :list_questions_params, ->(page_params){
    Question.includes(:answers, :subject)
            .where('lower(description) LIKE ?', "%#{page_params.downcase}%")
  }
  
  scope :list_questions, ->{
    Question.includes(:answers, :subject)
            .order('created_at desc')
  }

  scope :list_subject_params, ->(page_params, subject_id){
    Question.includes(:answers, :subject)
            .where(subject_id: subject_id)
  }
end

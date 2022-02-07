module Site
  class SearchController < SiteController
    
    def questions
      questions = Question.list_questions_params(params[:term])

      @questions = paginate_questions(questions)
    end

    private

    def paginate_questions(questions)
      Kaminari.paginate_array(questions).page(params[:page]).per(8)
    end
  end
end

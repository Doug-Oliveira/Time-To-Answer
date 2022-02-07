module Site
  class WelcomeController < SiteController
    
    def index
      questions = Question.list_questions

      @questions = paginate_questions(questions)
    end
    
    private

    def paginate_questions(questions)
      Kaminari.paginate_array(questions).page(params[:page]).per(8)
    end
  end
end

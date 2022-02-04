module Site
  class WelcomeController < SiteController
    
    def index
      @questions = Question.includes(:answers).page(params[:page])

    end
  end
end

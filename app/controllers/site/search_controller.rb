module Site
  class SearchController < SiteController
    
    def questions
      @questions = Question.includes(:answers)
                           .where('description LIKE ?', "%#{params[:term]}%")
        
    end
  end
end

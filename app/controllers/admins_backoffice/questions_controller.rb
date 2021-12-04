class AdminsBackoffice::QuestionsController < AdminsBackofficeController
  before_action :set_question, only: [:edit, :update, :destroy]
  before_action :get_subjects, only: [:new, :edit]
  
  def index
    #código '.page' referente a páginação com kaminari
    #'.order' ordena em ordem alfabetica
    #includes abaixo traz junto com a tabela questions, o assunto, assim possibilitando que na view não seja necessario
    #fazer uma nova query evitando o problema de n+1
    @questions = Question.includes(:subject).all
                          .order(:description)
                          .page(params[:page])
  end

  #rails consegue identificar que a rota para um Hash que está em branco é new
  def new
    @question = Question.new
  end
  
  def create
    @question = Question.new(params_question)
    if @question.save
      redirect_to admins_backoffice_questions_path, notice: "Questão cadastrada com sucesso"
    else
      render :edit
    end
  end

  def edit
  end

  def update
    if @question.update(params_question)
      redirect_to admins_backoffice_questions_path, notice: "Questão atualizada com sucesso"
    else
      render :edit
    end
  end

  def destroy
    if @question.destroy
      redirect_to admins_backoffice_questions_path, notice: "Questão excluida com sucesso"
    else
      render :index
    end
  end

  private
  def params_question
    #segurança permite que as informações abaixo sejam recebidas pelo controller
    params.require(:question).permit(:description, :subject_id, 
      answers_attributes: [:id, :description, :correct, :_destroy])   
  end

  def set_question
    @question = Question.find(params[:id])
  end

  def get_subjects
    @subjects = Subject.all
  end
end

class AdminsBackoffice::AdminsController < AdminsBackofficeController
  
  before_action :verify_password, only: [:update]
  before_action :set_admin, only: [:edit, :update, :destroy]
  
  def index
  #código '.page' referente a páginação com kaminari
    @admins = Admin.all.page(params[:page])
  end

  #rails consegue identificar que a rota para um Hash que está em branco é new
  def new
    @admin = Admin.new
  end
  
  def create
    @admin = Admin.new(params_admin)
    if @admin.save
      redirect_to admins_backoffice_admins_path, notice: "Administrador cadastrado com sucesso"
    else
      render :edit
    end
  end

  def edit
  end

  def update
    if @admin.update(params_admin)
      redirect_to admins_backoffice_admins_path, notice: "Administrador atualizado com sucesso"
    else
      render :edit
    end
  end

  def destroy
    if @admin.destroy
      redirect_to admins_backoffice_admins_path, notice: "Administrador excluido com sucesso"
    else
      render :index
    end
  end

  private
  def params_admin
    #segurança permito que as informações abaixo sejam recebidas pelo controller
    params_admin = params.require(:admin).permit(:email, :password, :password_confirmation)
  end

  def set_admin
    @admin = Admin.find(params[:id])
  end

  def verify_password
    if params[:admin][:password].blank? && params[:admin][:password_confirmation].blank?
      params[:admin].extract!(:password, :password_confirmation)
    end
  end  

end

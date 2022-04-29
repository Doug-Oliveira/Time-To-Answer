module UsersBackoffice
  class ProfileController < UsersBackofficeController

    def edit
      @user = User.find(current_user.id)
    end
  end
end
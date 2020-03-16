class UsersController < Clearance::UsersController
  before_action :require_login, only: [:edit, :update], raise: false

  def create
    @user = user_from_params

    if @user.save
      sign_in @user
      redirect_back_or url_after_create
    else
      flash[:errors] = @user.errors.full_messages
      render template: "users/new"
    end
  end


  def edit
  end

  def update
    if current_user.update(user_params)
      flash[:notice] = "Account updated"
    else
      flash[:errors] = current_user.errors.full_messages
    end
    render template: "users/edit"
  end

  private def user_params
    params.required(:user).permit(:email, :password)
  end
end

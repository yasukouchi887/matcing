class UsersController < ApplicationController
  before_action :require_user_logged_in, only: [:index, :show, :edit, :destroy, :followings, :followers]
  def index
    @users = User.order(id: :desc).page(params[:page]).per(25)
    
  end

  def show
    @user = User.find(params[:id])
    counts(@user)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      flash[:success] = 'ユーザを登録しました。'
      redirect_to @user
    else
      flash.now[:danger] = 'ユーザの登録に失敗しました。'
      render :new
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])

    if @user.update_attributes(user_params)
      @user.save!
      flash[:success] = 'ユーザは正常に更新されました。'
      redirect_to @user
    else
      flash.now[:danger] = 'ユーザの更新に失敗しました。'
      render :edit
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    flash[:success] = 'ユーザは正常に削除されました'
    redirect_to root_url
  end
  
  def followings
    @user = User.find(params[:id])
    @followings = @user.followings.page(params[:page])
    @relathinships = @user.relationships.page(params[:page])
    counts(@user)
  end
  
  def followers
    @user = User.find(params[:id])
    @followers = @user.followers.page(params[:page])
    @relathinships = @user.reverses_of_relationship.page(params[:page])
    counts(@user)
  end
  
  def matchings
    @user = User.find(params[:id])
    @matchings = @user.reverses_of_relationship.where(status: 2).page(params[:page])
    @matchings = @user.relationships.where(status: 2).page(params[:page])
    @relathinships = @user.reverses_of_relationship.page(params[:page])
    
  end
  
  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end

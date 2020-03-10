class RoomsController < ApplicationController
  before_action :require_user_logged_in
  before_action :correct_user, only: [:show]

  def show
    # @micropost = current_user.microposts.build  # form_with 用
    # @microposts = current_user.microposts.order(id: :desc).page(params[:page])
    
    @microposts = Micropost.where(room_id: params[:id])
    @own_microposts, @other_microposts = @microposts.partition { |micropost| micropost.user_id == current_user.id }
  end
  
  private
  
  def correct_user
    @room = Room.find(params[:id])
    relathinship = @room.relathinship
    
    if relathinship.user_id == current_user.id || relathinship.follow_id == current_user.id
      # do notihng
    else
      redirect_to root_url
    end
  end
  
  #def correct_user
    #@room = current_user.rooms.find(params[:id])
    #unless @room
    #redirect_to root_url
    #end
  #end
  
end

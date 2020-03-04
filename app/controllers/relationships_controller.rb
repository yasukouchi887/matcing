class RelationshipsController < ApplicationController
  before_action :require_user_logged_in
  
  def create
    user = User.find(params[:follow_id])
    current_user.follow(user)
    flash[:success] = 'ユーザをフォローしました。'
    redirect_to user
  end
  
  def accept
    matching = current_user.reverses_of_relationship.find(params[:id])
    matching.status = 2
    flash[:success] = 'マッチングしました。'
    
    room = Room.new
    room.create(relationship_id: matching.id)
    
    room.save!
    matching.save!
  end
  
  def not_accept
    matching = current_user.reverses_of_relationship.find(params[:id])
    matching.status = 1
    
    matching.save!
  end
  
end

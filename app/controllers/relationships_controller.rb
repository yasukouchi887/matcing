class RelationshipsController < ApplicationController
  before_action :require_user_logged_in
  
  def create
    user = User.find(params[:follow_id])
    current_user.follow(user)
    flash[:success] = 'ユーザをフォローしました。'
    redirect_to user
  end
  
  def update
    matching = current_user.reverses_of_relationship.find(params[:relationship_id])
    matching.status = 2
    flash[:success] = 'マッチングしました。'
    
    room = Room.new(relationship_id: matching.id)
    #room.create(relationship_id: matching.id)
    
    room.save!
    matching.save!
    
    render "rooms/show"
  end
  
  def destroy
    matching = current_user.reverses_of_relationship.find(params[:id])
    matching.status = 1
    
    matching.save!
    
    redirect_to root_url
  end
  
end

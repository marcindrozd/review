class UsersController < ApplicationController

  expose(:user) { find_user }
  expose(:users)

  respond_to :json

  def index
    respond_with(users)
  end

  def show
    respond_with(user)
  end

  private

  def find_user
    for_current_user? ? current_user : User.find(params[:id])
  end

  def for_current_user?
    params[:id] == 'me'
  end
end

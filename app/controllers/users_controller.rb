class UsersController < ApplicationController

  before_action :set_user
  # DELETE /users/1
  def destroy
    @user.destroy
    render json: { user: @user, message:"deleted successfully"}, status: :ok
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
  
      @user = User.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    
    def user_params 
        params.permit(:email, :password)
    end

end

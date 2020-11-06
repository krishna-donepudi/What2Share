class UsersController < ApplicationController
  # before_action :set_user, only: [:show, :edit, :update, :destroy, :edit_apps, 
  #                         :update_uapps, :edit_user_apps_1, :edit_user_apps_2,
  #                         :update_uapps_1, :update_uapps_2]
  # before_action :check_login

  # GET /users
  # GET /users.json
  def index
    @users = User.all
  end

  # GET /users/
  # GET /users/1.json
  def show
    @user = User.find(params[:id])
    debugger
  end

  # GET /users/new
  def new
    @user = User.new
    @partners = User.alphabetical.map{|x| [x.username, x.id] }
  end

  # GET /users/1/edit
  def edit
    if current_user.role == "admin"
      @partners = User.all.alphabetical.map{|x| [x.username, x.id] }
    elsif current_user.partner.nil?
      if current_user.possible_partners.empty?
        @partners = User.singles.map{|x| [x.username, x.id] }
      else
        @partners = current_user.possible_partners.map{|x| [x.username, x.id] }
      end
    else
      @partners = [current_user.partner].map{|x| [x.username, x.id] }
    end
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    if @user.update_attributes(user_params)
      redirect_to user_path, notice: "Updated user information."
    else
      render action: 'edit'
    end
  end

  def edit_apps
    n = 10 - @user.user_apps.length
    n.times { @user.apps.build }
  end
  
  def update_uapps
    apps = user_params['apps_attributes']
    existing = []
    apps.values.each do |app|
      if !app["name"].nil?
        record = App.find_or_create_by(name: app["name"])
        existing << record
      end
    end
    existing.each do |app|
      UserApp.find_or_create_by(user_id: @user.id, app_id: app.id)
    end
    redirect_to edit_user_apps_1_path
  end

  def edit_user_apps_1
  end

  def update_uapps_1
    if @user.update_attributes(user_params)
      redirect_to edit_user_apps_2_path
    else
      redirect_to edit_user_apps_1
    end
  end

  def edit_user_apps_2
  end

  def update_uapps_2
    if @user.update_attributes(user_params)
      redirect_to @user
    else
      redirect_to edit_user_apps_2_path
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      if @current_user
        @user = @current_user
      else
        @user = User.find(params[:id])
      end
    end

    # Only allow a list of trusted parameters through.
    def user_params
      params.require(:user).permit(:username, :partner_id, :role, 
        :password, :password_confirmation, apps_attributes: [:id, :name],
        user_apps_attributes: [:id, :will_to_share, :currently_sharing])
    end
end

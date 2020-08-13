class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy, :edit_apps, 
                          :update_apps, :edit_user_apps_1, :edit_user_apps_2]
  before_action :check_login

  # GET /users
  # GET /users.json
  def index
    @users = User.all
  end

  # GET /users/1
  # GET /users/1.json
  def show
  end

  # GET /users/new
  def new
    @user = User.new
    @partners = User.alphabetical.map{|x| [x.username, x.id] }
  end

  # GET /users/1/edit
  def edit
    @partners = User.alphabetical.map{|x| [x.username, x.id] }
  end

  def edit_apps
    10.times { @user.apps.build }
  end

  def edit_user_apps_1
    @part_one = true
  end

  def edit_user_apps_2
    @part_two = true
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
    apps = user_params['apps_attributes']
    if apps.nil? || apps.empty?
      p @part_one, @part_two
      if @part_one
        p "hemlo 11231231e12"
        redirect_to edit_user_apps_2_path
      elsif @part_two
        p "hemlo"
        redirect_to user_apps_path
      elsif @user.update_attributes(user_params)
        redirect_to user_path, notice: "Updated user information."
      else
        render action: 'edit'
      end
    else
      existing = []
      apps.values.each do |app|
        p app
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
      @user = User.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def user_params
      params.require(:user).permit(:username, :partner_id, :role, 
        :password, :password_confirmation, apps_attributes: [:id, :name],
        user_apps_attributes: [:id, :will_to_share, :currently_sharing])
    end
end

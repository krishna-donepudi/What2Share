class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy, :edit_apps, :update_apps]
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

  def update_apps
    not_existing = []
    existing = []
    apps = user_params['apps_attributes']
    apps.values.each do |app|
      if (App.exists? name: app.name).nil?
        not_existing << app
      else
        existing << app
      end
    end
    not_existing.values.each do |app|
      created_app = App.create(name: app[:name])
      existing << created_app
    end
    existing.values.each do |app|
      UserApp.create(user_id: @current_user.id, app_id: app.id)
    end
    redirect_to apps
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
    if apps.empty?
      if @user.update_attributes(user_params)
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
        UserApp.find_or_create_by(user_id: @current_user.id, app_id: app.id)
      end
      redirect_to user_apps_path
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
      params.require(:user).permit(:username, :partner_id, :role, :password, :password_confirmation, apps_attributes: [:id, :name])
    end
end

class ProjectsController < ApplicationController
  before_action :set_project, only: [:show, :edit, :update, :destroy]

  def index
    @projects = Project.all
  end

  def show
  end

  def new
    @project = Project.new
  end

  def edit
  end

  def create
    # セッションで管理しており、current_userでログイン中のユーザーを管理
    @user = current_user
    # ログイン中のユーザーにプロジェクト情報を追加
    @project = @user.projects.new(params_project)
    respond_to do |format|
      if @user.save
        # DB保存成功時の処理
        format.html { redirect_to @project, notice: 'Project was successfully created.' }
      else
        # DB保存失敗時の処理
        format.html { render :new }
      end
    end
  end

  def update
    respond_to do |format|
      if @project.update(project_params)
        format.html { redirect_to @project, notice: 'Project was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    @project.destroy
    respond_to do |format|
      format.html { redirect_to projects_url, notice: 'Project was successfully destroyed.' }
    end
  end

  private

  def params_project
    params.require(:project).permit(:name, :body)
  end

  # 簡易的に最初のユーザーをログイン中のユーザーと見なす
  def current_user
    User.first
  end

  def set_project
    @project = Project.find(params[:id])
  end
end

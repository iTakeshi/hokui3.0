class Admin::MlAccountsController < Admin::ApplicationController
  before_action :set_year

  def new
    @ml_account = @year.build_ml_account
  end

  def create
    @ml_account = @year.build_ml_account(ml_account_params)
    if @ml_account.save
      redirect_to edit_admin_year_ml_account_path(@year), notice: 'メーリングリストアカウントを設定しました。'
    else
      render action: :new
    end
  end

  def edit
    @ml_account = @year.ml_account
  end

  def update
    @ml_account = @year.ml_account
    @ml_account.attributes = ml_account_params
    if @ml_account.save
      redirect_to edit_admin_year_ml_account_path(@year), notice: 'メーリングリストアカウントを設定しました。'
    else
      render action: :edit
    end
  end

  private
  def set_year
    @year = Year.find_by_class_year(params[:year_id])
  end

  def ml_account_params
    params.require(:ml_account).permit %i(email subject_prefix)
  end
end

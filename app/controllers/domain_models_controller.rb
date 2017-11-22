class DomainModelsController < ApplicationController
  before_action :set_domain_model, only: [:show, :edit, :update, :destroy, :replace]

  # GET /domain_models
  def index
    @domain_models = DomainModel.all
  end

  # GET /domain_models/1
  def show
  end

  # GET /domain_models/new
  def new
    @domain_model = DomainModel.new
  end

  # GET /domain_models/1/edit
  def edit
  end

  # POST /domain_models
  def create
    @domain_model = DomainModel.new(domain_model_params)

    if @domain_model.save
      redirect_to @domain_model, notice: 'Domain model was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /domain_models/1
  def update
    if @domain_model.update(domain_model_params)
      redirect_to @domain_model, notice: 'Domain model was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /domain_models/1
  def destroy
    @domain_model.destroy
    redirect_to domain_models_url, notice: 'Domain model was successfully destroyed.'
  end

  def replace
    @domain_model.replace!
    redirect_to @domain_model
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_domain_model
      @domain_model = DomainModel.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def domain_model_params
      params.require(:domain_model).permit(:name, :desc)
    end
end

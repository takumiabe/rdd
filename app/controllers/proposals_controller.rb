class ProposalsController < ApplicationController
  before_action :set_requirement
  before_action :set_proposal, only: [:show, :edit, :update, :destroy]

  # GET /proposals
  def index
    @proposals = @requirement.proposals
  end

  # GET /proposals/1
  def show
  end

  # GET /proposals/new
  def new
    @proposal = @requirement.proposals.build
  end

  # GET /proposals/1/edit
  def edit
  end

  # POST /proposals
  def create
    @proposal = @requirement.proposals.build(proposal_params)

    if @proposal.save
      redirect_to [@requirement, @proposal], notice: 'Proposal was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /proposals/1
  def update
    if @proposal.update(proposal_params)
      redirect_to [@requirement, @proposal], notice: 'Proposal was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /proposals/1
  def destroy
    @proposal.destroy
    redirect_to [@requirement, :proposals], notice: 'Proposal was successfully destroyed.'
  end

  private
    def set_requirement
      @requirement = Requirement.find(params[:requirement_id])
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_proposal
      @proposal = Proposal.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def proposal_params
      params.require(:proposal).permit(:title, :description, :remark)
    end
end

class RequirementsController < ApplicationController
  before_action :set_requirement, only: [:show, :edit, :update, :destroy]

  # GET /requirements
  def index
    @requirements = Requirement.preload(:proposals).all

    if params[:format] == 'xlsx'
      workbook = RubyXL::Workbook.new
      sheet = workbook[0]
      sheet.sheet_name = "要求"

      %w[ID 状態 条件 要求 備考].each.with_index do |v, column|
        sheet.add_cell(0, column, v)
      end

      @requirements.each.with_index(1) do |r, row|
        [
          r.id,
          r.status,
          helpers.decorate(r.condition, text: true),
          helpers.decorate(r.description, text: true),
          helpers.decorate(r.remark, text: true),
        ].each.with_index do |v, column|
          cell = sheet.add_cell(row, column, v)
          cell.change_text_wrap(true) if v.to_s.include? "\n"
        end
        sheet.change_row_vertical_alignment(row, 'top')
      end

      sheet = workbook.add_worksheet("要件")
      %w[要求ID タイトル 要件 備考].each.with_index do |v, column|
        sheet.add_cell(0, column, v)
      end

      Proposal.all.each.with_index(1) do |r, row|
        [
          r.requirement_id,
          r.title,
          helpers.decorate(r.description, text: true),
          helpers.decorate(r.remark, text: true),
        ].each.with_index do |v, column|
          cell = sheet.add_cell(row, column, v)
          cell.change_text_wrap(true) if v.to_s.include? "\n"
        end
        sheet.change_row_vertical_alignment(row, 'top')
      end

      send_data workbook.stream.read, filename: '要件定義.xlsx'
    end
  end

  # GET /requirements/1
  def show
  end

  # GET /requirements/new
  def new
    @requirement = Requirement.new
  end

  # GET /requirements/1/edit
  def edit
  end

  # POST /requirements
  def create
    @requirement = Requirement.new(requirement_params)

    if @requirement.save
      redirect_to @requirement, notice: 'Requirement was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /requirements/1
  def update
    if @requirement.update(requirement_params)
      redirect_to @requirement, notice: 'Requirement was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /requirements/1
  def destroy
    @requirement.destroy
    redirect_to requirements_url, notice: 'Requirement was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_requirement
      @requirement = Requirement.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def requirement_params
      params.require(:requirement).permit(:status, :condition, :description, :remark)
    end
end

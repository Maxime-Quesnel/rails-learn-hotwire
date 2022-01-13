class EmployeesController < ApplicationController
  include ActionView::RecordIdentifier
  before_action :set_employee, only: %i[ show edit update destroy ]

  # GET /employees or /employees.json
  def index
    @employees = case params[:active]
                 when "active"
                   Employee.all.active
                 when "disable"
                   Employee.all.disable
                 else
                   Employee.all
                 end

    @employees = @employees.search(params[:query]) if params[:query].present?
    @pagy, @employees = pagy @employees.reorder(sort_column => sort_direction), items: params.fetch(:count, 10), link_extra: 'data-turbo-frame="listings" data-turbo-action="advance"'
    @employee = Employee.new

  end

  def sort_column
    params[:sort].presence_in(%w{ name position office age start_date likes }) || "name"
  end

  def sort_direction
    %w{ asc desc }.include?(params[:direction]) ? params[:direction] : "asc"
  end

  # GET /employees/1 or /employees/1.json
  def show
  end

  # GET /employees/new
  def new
    @employee = Employee.new
  end

  # GET /employees/1/edit
  def edit
  end

  def like
    @employee = Employee.find(params[:id])
    @employee.increment!(:likes)
    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: turbo_stream.replace("#{dom_id(@employee)}_likes", partial: 'employees/likes', locals: { employee: @employee })
      end
    end
  end

  # POST /employees or /employees.json
  def create
    @employee = Employee.create(employee_params)
  end

  # PATCH/PUT /employees/1 or /employees/1.json
  def update
    respond_to do |format|
      if @employee.update(employee_params)
        format.html { redirect_to employee_url(@employee), notice: "Employee was successfully updated." }
        format.json { render :show, status: :ok, location: @employee }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @employee.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /employees/1 or /employees/1.json
  def destroy
    @employee.destroy

    respond_to do |format|
      format.html { redirect_to employees_url, notice: "Employee was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_employee
    @employee = Employee.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def employee_params
    params.require(:employee).permit(:name, :position, :office, :age, :start_date)
  end
end

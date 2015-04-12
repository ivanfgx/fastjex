class PaymentSchedulesController < ApplicationController
  before_action :set_payment_schedule, only: [:show, :edit, :update, :destroy]

  # GET /payment_schedules
  # GET /payment_schedules.json
  def index
    @payment_schedules = PaymentSchedule.all
  end

  # GET /payment_schedules/1
  # GET /payment_schedules/1.json
  def show
  end

  # GET /payment_schedules/new
  def new
    @payment_schedule = PaymentSchedule.new
  end

  # GET /payment_schedules/1/edit
  def edit
  end

  # POST /payment_schedules
  # POST /payment_schedules.json
  def create
    @payment_schedule = PaymentSchedule.new(payment_schedule_params)

    respond_to do |format|
      if @payment_schedule.save
        format.html { redirect_to @payment_schedule, notice: 'Payment schedule was successfully created.' }
        format.json { render :show, status: :created, location: @payment_schedule }
      else
        format.html { render :new }
        format.json { render json: @payment_schedule.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /payment_schedules/1
  # PATCH/PUT /payment_schedules/1.json
  def update
    respond_to do |format|
      if @payment_schedule.update(payment_schedule_params)
        format.html { redirect_to @payment_schedule, notice: 'Payment schedule was successfully updated.' }
        format.json { render :show, status: :ok, location: @payment_schedule }
      else
        format.html { render :edit }
        format.json { render json: @payment_schedule.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /payment_schedules/1
  # DELETE /payment_schedules/1.json
  def destroy
    @payment_schedule.destroy
    respond_to do |format|
      format.html { redirect_to payment_schedules_url, notice: 'Payment schedule was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_payment_schedule
      @payment_schedule = PaymentSchedule.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def payment_schedule_params
      params.require(:payment_schedule).permit(:account, :regularity, :start_date, :end_date, :amount, :name, :user_id)
    end
end

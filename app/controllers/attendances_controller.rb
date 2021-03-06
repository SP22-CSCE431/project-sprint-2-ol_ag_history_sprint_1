class AttendancesController < ApplicationController
  before_action :set_attendance, only: %i[ show edit update destroy ]

  # GET /attendances or /attendances.json
  def index
    #@attendances = Attendance.all
    @members = Member.all
    @events = Event.all

    @q = Attendance.ransack(params[:q])
    @attendances = @q.result(distinct: true).includes(:member, :event)
    
  end

  def search
    index
    render :index
  end

  # GET /attendances/1 or /attendances/1.json
  def show
    @member = Member.find(@attendance.member_id)
    @event = Event.find(@attendance.event_id)
  end

  # GET /attendances/new
  def new
    @attendance = Attendance.new
    @members = Member.all
    @events = Event.all
  end

  # GET /attendances/1/edit
  def edit
    @members = Member.all
    @events = Event.all
  end

  # POST /attendances or /attendances.json
  def create
    @attendance = Attendance.new(attendance_params)

    respond_to do |format|
      if @attendance.save
        format.html { redirect_to attendance_url(@attendance), notice: "Attendance was successfully created." }
        format.json { render :show, status: :created, location: @attendance }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @attendance.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /attendances/1 or /attendances/1.json
  def update
    respond_to do |format|
      if @attendance.update(attendance_params)
        format.html { redirect_to attendance_url(@attendance), notice: "Attendance was successfully updated." }
        format.json { render :show, status: :ok, location: @attendance }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @attendance.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /attendances/1 or /attendances/1.json
  def destroy
    @attendance.destroy

    respond_to do |format|
      format.html { redirect_to attendances_url, notice: "Attendance was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_attendance
      @attendance = Attendance.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def attendance_params
      params.require(:attendance).permit(:member_id, :event_id, :attended, :rsvp)
    end
end

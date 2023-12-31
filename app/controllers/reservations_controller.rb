class ReservationsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_reservation, only: %i[ show edit update destroy ]

  # GET /reservations or /reservations.json
  def index
    @reservations = current_user.reservations
  end

  # GET /reservations/1 or /reservations/1.json
  def show
    reservation = Reservation.find(params[:id])
    unless current_user == reservation.user
      flash[:alert] = "You are not authorized to access this reservation."
      redirect_to root_path
    end
  end

  # GET /reservations/new
  def new
    @reservation = Reservation.new
    @available_seats = Seat.all
  end

  # GET /reservations/1/edit
  def edit
    reservation = Reservation.find(params[:id])
    unless current_user == reservation.user
      flash[:alert] = "You are not authorized to access this reservation."
      redirect_to root_path
    end
    @available_seats = Seat.all
  end

  # POST /reservations or /reservations.json
  def create
    @reservation = current_user.reservations.build(reservation_params)
    @available_seats = Seat.all

    respond_to do |format|
      if @reservation.save
        format.html { redirect_to reservation_url(@reservation), notice: "Reservation was successfully created." }
        format.json { render :show, status: :created, location: @reservation }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @reservation.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /reservations/1 or /reservations/1.json
  def update
    respond_to do |format|
      if @reservation.update(reservation_params)
        format.html { redirect_to reservation_url(@reservation), notice: "Reservation was successfully updated." }
        format.json { render :show, status: :ok, location: @reservation }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @reservation.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /reservations/1 or /reservations/1.json
  def destroy
    @reservation.destroy

    respond_to do |format|
      format.html { redirect_to reservations_url, notice: "Reservation was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_reservation
      @reservation = Reservation.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def reservation_params
      params.require(:reservation).permit(:reservation_date, :seat_id, :morning, :afternoon)
    end
end

class PoolsController < ApplicationController
  before_action :authenticate_user!, except: [ :index ]
  before_action :set_pool, only: %i[ show edit update destroy join finish]

  # GET /pools or /pools.json
  def index
    @pools = Pool.all
  end

  # GET /pools/1 or /pools/1.json
  def show
  end

  # GET /pools/new
  def new
    @pool = Pool.new
  end

  # GET /pools/1/edit
  def edit
  end

  # POST /pools or /pools.json
  def create
    @pool = Pool.new(pool_params)
    @pool.user = current_user
    @pool.user_min ||= 2

    respond_to do |format|
      if @pool.save
        format.html { redirect_to @pool, notice: "카풀 생성 완료 됐습니다!" }
        format.json { render :show, status: :created, location: @pool }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @pool.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /pools/1 or /pools/1.json
  def update
    respond_to do |format|
      if @pool.update(pool_params)
        format.html { redirect_to @pool, notice: "성공적으로 수정 됐습니다!" }
        format.json { render :show, status: :ok, location: @pool }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @pool.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pools/1 or /pools/1.json
  def destroy
    @pool.destroy!

    respond_to do |format|
      format.html { redirect_to pools_path, status: :see_other, notice: "카풀 삭제 됐습니다!" }
      format.json { head :no_content }
    end
  end

  def finish
    if @pool.bookings.first.user_id != current_user.id
      return redirect_to @pool, alert: "방장만 마감할 수 있습니다!"
    end

    # 풀 종료 확인
    if @pool.end_at <= Time.current
      # 종료된 경우 메시지 출력하고 return
      return redirect_to @pool, alert: "이미 카풀 종료된 상태입니다!"
    end

    @pool.update(end_at: Time.current)

    redirect_to @pool, notice: "모집 마감 완료 됐습니다!"
  end

  def join
    @booking = @pool.bookings.new(user: current_user)

    if @pool.end_at <= Time.current
      return redirect_to @pool, alert: "시간 초과 됐습니다!"
    end

    if @pool.start_at > Time.current
      return redirect_to @pool, alert: "모집 시간이 아닙니다!"
    end

    if @pool.bookings.count >= @pool.user_max
      return redirect_to @pool, alert: "인원수 초과 됐습니다!"
    end

    if @pool.bookings.where(user: current_user).any?
      return redirect_to @pool, alert: "이미 참가한 상태입니다!"
    end

    # Time.current

    respond_to do |format|
      if @booking.save
        format.html { redirect_to @pool, notice: "참여 성공 했습니다!" }
      else
        format.html { redirect_to @pool, alert: "참여 실패 했습니다!" }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_pool
      @pool = Pool.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def pool_params
      params.require(:pool).permit(:pool_type, :user_id, :start_place_id, :end_place_id, :start_at, :end_at, :user_max, :user_min)
    end
end

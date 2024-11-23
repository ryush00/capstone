class PoolsController < ApplicationController
  include Pagy::Backend
  before_action :authenticate_user!, except: [:index]
  before_action :set_pool, only: %i[show edit update destroy join finish]
  before_action :check_permissions, only: %i[edit update destroy finish]

  class User < ApplicationRecord
    def admin?
      self.admin
    end
  end

  # GET /pools or /pools.json
  def index
    if params[:end_id].present?
      @pagy, @pools = pagy(Pool.joins(:end_place).where(places: { id: params[:end_id] }).order(created_at: :desc), limit: 10)
    elsif params[:start_id].present?
      @pagy, @pools = pagy(Pool.joins(:start_place).where(places: { id: params[:start_id] }).order(created_at: :desc), limit: 10)
    else
      @pagy, @pools = pagy(Pool.all.order(created_at: :desc), limit: 10)
    end
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
    # 권한은 before_action으로 처리
  end

  def random_name
    all_names = ["스폰지밥", "뚱이", "징징이", "집게사장", "다람이", "플랑크톤", "퐁퐁부인"]
    used_names = Pool.where(name: all_names).where("end_at > ?", Time.current).pluck(:name)
    available_names = all_names - used_names

    if available_names.any?
      available_names.sample
    else
      nil
    end
  end

  # POST /pools or /pools.json
  def create
    @pool = Pool.new(pool_params)
    @pool.user = current_user
    @pool.user_min = 2
    @pool.start_at = Time.current
    @pool.end_at = Time.current + 60.minutes
    @pool.name = random_name

    if @pool.name.nil?
      @pool.errors.add(:base, "지금은 카풀 생성이 어려워요. 나중에 다시 시도해 주세요.")
      flash[:alert] = "지금은 카풀 생성이 어려워요. 나중에 다시 시도해 주세요."
      respond_to do |format|
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @pool.errors, status: :unprocessable_entity }
      end
      return
    end

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
    # 권한은 before_action으로 처리
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
    if current_user.admin?
      @pool.destroy!
      respond_to do |format|
        format.html { redirect_to pools_path, status: :see_other, notice: "카풀 삭제 됐습니다!" }
        format.json { head :no_content }
      end
    else
      redirect_to @pool, alert: "관리자만 이 작업을 수행할 수 있습니다!"
    end
  end

  def finish
    if @pool.user_id != current_user.id
      return redirect_to @pool, alert: "방장만 마감할 수 있습니다!"
    end

    if @pool.end_at <= Time.current
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

    respond_to do |format|
      if @booking.save
        format.html { redirect_to @pool, notice: "참여 성공 했습니다!" }
      else
        format.html { redirect_to @pool, alert: "참여 실패 했습니다!" }
      end
    end
  end

  private

  def set_pool
    @pool = Pool.find(params[:id])
  end

  def pool_params
    params.require(:pool).permit(:pool_type, :user_id, :start_place_id, :end_place_id, :start_at, :end_at, :user_max, :user_min)
  end

  def check_permissions
    if action_name == "destroy" && !current_user.admin?
      redirect_to @pool, alert: "관리자만 이 작업을 수행할 수 있습니다!"
    elsif !current_user.admin? && @pool.user_id != current_user.id
      redirect_to @pool, alert: "권한이 없습니다!"
    end
  end
end

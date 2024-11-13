class PoolsController < ApplicationController
  before_action :set_pool, only: %i[ show edit update destroy ]

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

    respond_to do |format|
      if @pool.save
        format.html { redirect_to @pool, notice: "Pool was successfully created." }
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
        format.html { redirect_to @pool, notice: "Pool was successfully updated." }
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
      format.html { redirect_to pools_path, status: :see_other, notice: "Pool was successfully destroyed." }
      format.json { head :no_content }
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

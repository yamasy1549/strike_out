class ResultsController < ApplicationController
  before_action :set_result, only: [:edit, :update, :destroy]

  def index
    @result = Result.new
    @results = Result.all
    @top_results = Result.order('score desc').take(3)
  end

  def new
    @result = Result.new
  end

  def edit
  end

  def create
    @result = Result.new(result_params)

    respond_to do |format|
      if @result.save
        format.html { redirect_to results_url, notice: 'Result was successfully created.' }
        format.json { render :index, status: :created }
      else
        format.html { render :new }
        format.json { render json: @result.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @result.update(result_params)
        format.html { redirect_to results_url, notice: 'Result was successfully updated.' }
        format.json { render :index, status: :ok }
      else
        format.html { render :edit }
        format.json { render json: @result.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @result.destroy
    respond_to do |format|
      format.html { redirect_to results_url, notice: 'Result was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_result
      @result = Result.find(params[:id])
    end

    def result_params
      params.require(:result).permit(:name, :score)
    end
end

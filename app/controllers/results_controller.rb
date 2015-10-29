class ResultsController < ApplicationController
  before_action :set_result, only: [:edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index]

  def index
    today_adult_top_scores = Result.where(created_at: 0.day.ago.all_day, adult: true).pluck(:score).uniq.max(3)
    today_child_top_scores = Result.where(created_at: 0.day.ago.all_day, adult: false).pluck(:score).uniq.max(3)
    yesterday_adult_top_scores = Result.where(created_at: 1.day.ago.all_day, adult: true).pluck(:score).uniq.max(3)
    yesterday_child_top_scores = Result.where(created_at: 1.day.ago.all_day, adult: false).pluck(:score).uniq.max(3)
    @today_adult_top_results = Result.where(score: today_adult_top_scores, adult: true).order('score desc')
    @today_child_top_results = Result.where(score: today_child_top_scores, adult: false).order('score desc')
    @yesterday_adult_top_results = Result.where(score: yesterday_adult_top_scores, adult: true).order('score desc')
    @yesterday_child_top_results = Result.where(score: yesterday_child_top_scores, adult: false).order('score desc')
  end

  def all
    @results = Result.order('created_at desc')
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
        format.html { redirect_to new_result_url, notice: 'スコアを記録しました。' }
        format.json { render :new, status: :created }
      else
        format.html { render :new }
        format.json { render json: @result.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @result.update(result_params)
        format.html { redirect_to new_result_url, notice: 'スコア情報を更新しました。' }
        format.json { render :new, status: :ok }
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
      params.require(:result).permit(:name, :score, :adult)
    end
end

class WorldController < ApplicationController
  # before_action :all_countries

  def index
  	# @countries = Country.all.order(name: :desc)
  	@countries = Country.all.order(:name)
  end

  def by_population
  	@countries = Country.all.order(population: :desc)
  end

  def by_age
  	@countries = Country.all.order(median_age: :asc).where('median_age > 30')
  end

  def by_required_service
  	@countries = Country.where(mandatory_military_service: true)
  	                    .order(:life_expectancy)
  end

  def search_results
  	select = params[:country]
  	search = '%' + params[:search] + '%'
  	case select
	when '1'
	  @result = Country.where("name LIKE ?", search).first
	when '2'
	  @result = Country.where(mandatory_military_service: true).where("name LIKE ?",
	  						  search).first
	else
	  @result = Country.where(mandatory_military_service: false).where("name LIKE ?",
	  						  search).first
	end
  	if @result.nil?
  	  redirect_to root_path
      flash[:notice] = 'No country found'
    else
      flash[:found] = params[:search] + ' found!'
  	end
  	(session[:last_search] ||= []) << params[:search]
  	if session[:last_search].count > 3
  	  session[:last_search].shift
      # session.delete(:last_search)
  	end
  	# reset_session
  	# session[:last_search] = params[:search]
  end

  private

    # def all_countries
    #   @countries = Country.all
    # end
end

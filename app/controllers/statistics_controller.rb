class StatisticsController < ApplicationController
  def index
    @dates = (Date.parse(Setting.find_by(key: :start_date).value)..Date.parse(Setting.find_by(key: :end_date).value)).to_a
    @beer_consumption = [1,2,3,4,5]

  end
end

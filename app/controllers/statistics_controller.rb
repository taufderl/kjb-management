class StatisticsController < ApplicationController
  def index
    # Tabelle Verbrauch
    @count_beer = ScoutConsumption.all.sum(:beer)
    @count_sausage = ScoutConsumption.all.sum(:sausage)
    @count_pork = ScoutConsumption.all.sum(:pork)
    @count_turkey = ScoutConsumption.all.sum(:turkey)
    @count_corn = ScoutConsumption.all.sum(:corn)
    
    @count_scouts_softdrink = ScoutConsumption.all.sum(:soft_drink)
    @count_children_softdrink = ChildConsumption.all.sum(:soft_drink)
    @count_softdrink = @count_scouts_softdrink + @count_children_softdrink
    
    @count_beer_crate = (@count_beer.to_d/24)
    @count_softdrink_crate = (@count_softdrink.to_d/24)
    
    
    # Tabelle Gruppenleiter Bierkonsum
    @scouts = Scout.all
    # @scout_beer = @scouts.max_by{|a| a.beer_consumption} 
    
    
    # Graphik
    @dates = (Date.parse(Setting.find_by(key: :start_date).value)..Date.parse(Setting.find_by(key: :end_date).value)).to_a

    @beer_consumption = []
    @sausage_consumption = []
    @pork_consumption = []
    @turkey_consumption = []
    @corn_consumption = []
    @softdrink_consumption = []
    
    @dates.each do |date|
      if (!ScoutConsumption.where(date: date).empty?)
        @beer_consumption.push(ScoutConsumption.where(date: date).sum(:beer))
        @sausage_consumption.push(ScoutConsumption.where(date: date).sum(:sausage))
        @pork_consumption.push(ScoutConsumption.where(date: date).sum(:pork))
        @turkey_consumption.push(ScoutConsumption.where(date: date).sum(:turkey))
        @corn_consumption.push(ScoutConsumption.where(date: date).sum(:corn))
      end
    end
    
  end
end

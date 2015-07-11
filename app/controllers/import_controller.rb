class ImportController < ApplicationController
  require 'csv'
  
  def index
  end
  
  def upload
    if params[:upload][:data] == 'children'
      file = params[:upload][:file]
      @file = params[:upload][:file]
      @filecontent = @file.read
      @filecontent.force_encoding('UTF-8')
      @csv = CSV.new(@filecontent, headers: true, col_sep: ",", encoding: "UTF-8")
      @content = @csv.to_a.map {|row| row.to_hash }
      @content.each do |row|
        data = {
          first_name: row["Vorname"],
          last_name: row["Nachname"],
          birthday: Date.strptime(row["Geburtsdatum"].split(' ')[0], '%m/%d/%Y'),
          phone: "Telefon: "+row["Telefon"].to_s+"\nElternTelefon: "+row["ElternTelefon"].to_s+"\nElternTelefonDienstlich: "+row["ElternTelefonDienstlich"].to_s + "\nElternErreichbarUrlaub: "+row["ElternErreichbarUrlaub"].to_s
        }
        child = Child.create(data)
      end
      flash[:notice] = "Import successful"
    elsif params[:upload][:data] == 'scouts'
      @file = params[:upload][:file]
      @filecontent = @file.read
      @filecontent.force_encoding('UTF-8')
      @csv = CSV.new(@filecontent, headers: true, col_sep: ",")
      @content = @csv.to_a.map {|row| row.to_hash }
      @content.each do |row|
        data = {
          first_name: row["Vorname"],
          last_name: row["Nachname"],
          birthday: Date.strptime(row["Geburtsdatum"].split(' ')[0], '%m/%d/%Y')
        }
        scout = Scout.create(data)
      end
      flash[:notice] = "Import successful"
    end
    render :index
  end
  
end

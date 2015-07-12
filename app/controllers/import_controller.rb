class ImportController < ApplicationController
  
  def index
  end
  
  def upload
    if params[:upload][:data] == 'children'
      @file = params[:upload][:file]
      if @file.content_type == "text/xml"
        import_children_from_xml
      elsif @file.content_type == "text/csv"
        import_children_from_csv
      else
        flash[:alert] = "Could not import the given file: unknown format"
      end
    elsif params[:upload][:data] == 'scouts'
      @file = params[:upload][:file]
      if @file.content_type == "text/xml"
        import_scouts_from_xml
      elsif @file.content_type == "text/csv"
        import_scouts_from_csv
      else
        flash[:alert] = "Could not import the given file: unknown format"
      end      
    elsif params[:upload][:data] == 'tents'
      @file = params[:upload][:file]
      if @file.content_type == "text/csv"
        import_tents_from_csv
      else
        flash[:alert] = "Could not import the given file: unknown format"
      end
    elsif params[:upload][:data] == 'tent_members'
      @file = params[:upload][:file]
      if @file.content_type == "text/csv"
        import_tent_members_from_csv
      else
        flash[:alert] = "Could not import the given file: unknown format"
      end
    end
    render :index
  end
  
  def import_scouts_from_csv
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
  
  def import_children_from_xml
    @filecontent = @file.read
    @data = Hash.from_xml @filecontent
    @data["RECORDS"]["RECORD"].each do |row|
      data = {
        first_name: row["Vorname"],
        last_name: row["Nachname"],
        birthday: Date.strptime(row["Geburtsdatum"].split(' ')[0], '%m/%d/%Y'),
        phone: "Telefon: "+row["Telefon"].to_s+"\nElternTelefon: "+row["ElternTelefon"].to_s+"\nElternTelefonDienstlich: "+
          row["ElternTelefonDienstlich"].to_s + "\nElternErreichbarUrlaub: "+row["ElternErreichbarUrlaub"].to_s,
        source_id: row["id"].to_i,
        image: row["TeilnehmerImage"]
      }
      child = Child.create(data)
    end
    flash[:notice] = "Import successful"
  end
  
  def import_children_from_csv
    @filecontent = @file.read
    @filecontent.force_encoding('UTF-8')
    @csv = CSV.new(@filecontent, headers: true, col_sep: ",", encoding: "UTF-8")
    @content = @csv.to_a.map {|row| row.to_hash }
    @content.each do |row|
      data = {
        first_name: row["Vorname"],
        last_name: row["Nachname"],
        birthday: Date.strptime(row["Geburtsdatum"].split(' ')[0], '%m/%d/%Y'),
        phone: "Telefon: "+row["Telefon"].to_s+"\nElternTelefon: "+row["ElternTelefon"].to_s+"\nElternTelefonDienstlich: "+
          row["ElternTelefonDienstlich"].to_s + "\nElternErreichbarUrlaub: "+row["ElternErreichbarUrlaub"].to_s,
        source_id: row["id"].to_i,
        image: row["TeilnehmerImage"]
      }
      child = Child.create(data)
    end
    flash[:notice] = "Import successful"
  end
  
  def import_tents_from_csv
    @filecontent = @file.read
    @filecontent.force_encoding('UTF-8')
    @csv = CSV.new(@filecontent, headers: true, col_sep: ",", encoding: "UTF-8")
    @content = @csv.to_a.map {|row| row.to_hash }
    @content.each do |row|
      data = {
        number: row["Bezeichnung"].split(" ").last.to_i,
        source_id: row["id"].to_i
      }
      tent = Tent.create(data)
    end
    flash[:notice] = "Import successful"
  end
  
  def import_tent_members_from_csv
    @filecontent = @file.read
    @filecontent.force_encoding('UTF-8')
    @csv = CSV.new(@filecontent, headers: true, col_sep: ",", encoding: "UTF-8")
    @content = @csv.to_a.map {|row| row.to_hash }
    @content.each do |row|
      tent = Tent.find_by_source_id(row["zeltId"])
      child = Child.find_by_source_id(row["TeilnehmerId"])
      child.tent = tent
      child.save
    end
    flash[:notice] = "Import successful"
  end
  
end

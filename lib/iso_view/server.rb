# encoding: utf-8

# require 'json'
# require 'sinatra'
# require "sinatra/activerecord"
# require 'countries'


set :database, "sqlite3:///db/zipcodes.db"
ActiveRecord::Base.include_root_in_json = false

class Zipcode < ActiveRecord::Base
  # extend IndexSearchable
  # self.primary_key = 'index'
end


module IsoView

  class Server < Sinatra::Base

    # register Sinatra::ActiveRecordExtension

    root = File.dirname(File.expand_path(__FILE__))
    set :root, root
    # set :views,  "#{root}/views"
    # if respond_to? :public_folder
    #   set :public_folder, "#{root}/resources"
    # else
    #   set :public, "#{root}/resources"
    # end
    # set :static, true

    def countries(lang="en")

        $country={}
        i = ISO3166::Country::Names.map{ |(n1,n2)| n2 }
        i.each do |variable|
          if lang != "en"
            if Country[variable].translations["#{lang}"]
              $country[Country[variable].alpha2] = Country[variable].translations["#{lang.downcase}"]
            else
              $country[Country[variable].alpha2] = Country[variable].name
            end
          else
            $country[Country[variable].alpha2] = Country[variable].name
          end
        end
        $country.to_json
      
    end

    def subdivision(country, lang="en")
        $subdivisions={}
        c = Country.new(country.to_s.upcase)

        c.subdivisions.each do |e|
         if e[1]['translations'] and lang
           $subdivisions[e[0]] = e[1]['translations']
         else
           $subdivisions[e[0]] = e[1]['name']
         end

        end
        $subdivisions.to_json
    end




    def cities(cou, subdiv)

      pathi="#{File.dirname(File.expand_path(__FILE__))}"+"/ru_area_city/"

      filess={}
      Dir.glob(pathi+"*.json").each do |e|
        t1=e.gsub(/#{pathi}/,"")
        t2=t1[0..-14]
        filess[t2]=e
      end

      return File.read(filess[subdiv])
    end



    get "/" do
      content_type :json
      return { "database.putZipcode" => "?params[:zipcode]",
               "database.getCountries" => "?params[:locale]",
               "database.getSubdivisions" => "?params[:country]&params[:locale]",
               "database.getCities" => "?params[:country]&params[:subdivision]"}.to_json
    end


    get "/zipcode/city/:start" do
      content_type :json
      @z_all={}
      l_name_var = "#{params[:start]}"
      @all=Zipcode.where("zipcodes.city LIKE :l_name", {:l_name => "#{l_name_var}%"}).limit(500)
      @z_all=@all
      return @z_all.to_json(only: [:index, :region, :autonom, :area, :city, :city2])
    end


    get "/zipcode/city2/:start" do
      content_type :json
      @z_all={}
      l_name_var = "#{params[:start]}"
      @all=Zipcode.where("zipcodes.city2 LIKE :l_name", {:l_name => "#{l_name_var}%"}).limit(500)
      @z_all=@all
      return @z_all.to_json(only: [:index, :region, :autonom, :area, :city, :city2])
    end

# search_by("zipcode", { params[:zipcode], params[:country], params[:subdivision], params[:area], params[:city], params[:city2], params[:locale] })

    get "/:start" do
      content_type :json
  
      case params[:start]
        when "database.putZipcode"
          l_name_var = "#{params[:zipcode]}"
          @all=Zipcode.where("\"index\" LIKE :l_name", {:l_name => "#{l_name_var}%"})
          return @all.to_json(only: [:index, :region, :autonom, :area, :city, :city2])

        when "database.getCountries"
          countries params[:locale]

        when "database.getSubdivisions"
          subdivision params[:country],params[:locale]

        when "database.getCities"
          cities params[:country], params[:subdivision]

      end
  
    end


    post "/zipcode" do
      zipcode     = params[:zipcode]
      region      = params[:region]
      autonom     = params[:autonom]
      area        = params[:area]
      city        = params[:city]
      city2       = params[:city2]
    end





    def url_path(*path_parts)
      [ path_prefix, path_parts ].join("/").squeeze('/')
    end
    alias_method :u, :url_path

    private

    def path_prefix
      request.env['SCRIPT_NAME']
    end


  end
end
module IsoView

  class Server < Sinatra::Base

  info=<<-CODE

    get "/iso/countries/:lang?" do
      countries params[:lang]
    end

    get "/iso/subdivisions/:country/:lang?" do
      subdivision params[:country],params[:lang]
    end

    get "/iso/cities/:country/:subdivision/" do
      cities params[:country], params[:subdivision]
    end

  CODE

    root = File.dirname(File.expand_path(__FILE__))
    set :root, root

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
        @subdivisions={}
        c = Country.new(country.to_s.upcase)
        c.subdivisions.each do |e|
         if e[1]['translations'] and lang
           @subdivisions[e[0]] = e[1]['translations']
         else
           @subdivisions[e[0]] = e[1]['name']
         end
        end
        @subdivisions.to_json
    end




    def cities(country, subdivision)

        c = Country.new(country.to_s.upcase)
        c.subdivisions[subdivision.upcase].to_json

        Dir.glob("ru_area_city/*").each do |e|
          #ru_area_city/KHM_1159710.json 
          if e[0..15].gsub('ru_area_city/', '') == subdivision

            f = File.read(e)
            # j = JSON.load(f)

            return f
            # return "#{subdivision} + #{e}"

          else
             subdivision
          end
        end


    end



    get "/" do
         # { countries: '/iso/countries/:translations?', subdivisions: '/iso/subdivisions/:country/:translations?' }.to_json
      info
    end

     not_found do
      redirect "/"
     end

    error do
      redirect "/"
    end

    get "/iso/countries/:lang?" do
      countries params[:lang]
    end

    get "/iso/subdivisions/:country/:lang?" do
      subdivision params[:country],params[:lang]
    end

    get "/iso/cities/:country/:subdivision/" do
      cities params[:country], params[:subdivision]
    end

  end
end
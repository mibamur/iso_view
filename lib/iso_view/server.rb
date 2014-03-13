require 'countries'

module IsoView

  class Server < Sinatra::Base

  info=<<-CODE
{
    countries:
    'get "/iso/countries/:lang?" do
      countries params[:lang]
    end',
    subdivisions:
    'get "/iso/subdivisions/:country/:lang?" do
      subdivision params[:country],params[:lang]
    end',
    cities:
    'get "/iso/cities/:country/:subdivision/" do
      cities params[:country], params[:subdivision]
    end'
}
  CODE

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
      countries params[:lang]
    end

    get "/countries/:lang?" do
      content_type :json
      countries params[:lang]
    end

    get "/subdivisions/:country/:lang?" do
      content_type :json
      subdivision params[:country],params[:lang]
    end

    get "/cities/:country/:subdivision/:lang?" do
      # root
      # content_type :json
      cities params[:country], params[:subdivision]
    end

    # get "/iso/cities/:country/:subdivision/:lang?" do
    #   # root
    #   content_type :json
    #   cities params[:country], params[:subdivision]
    # end


    # get "/iso/:country?/:subdivision?" do
    #   # content_type :json
    #   cities params[:country], params[:subdivision]
    #   # root
    # end


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
module Routes
  def self.included( app )
    app.get '/' do
      haml :index
    end
  end
end

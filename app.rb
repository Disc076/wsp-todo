require 'debug'
require "awesome_print"

class App < Sinatra::Base

  # Funktion för att prata med databasen
  # Exempel på användning: db.execute('SELECT * FROM fruits')
  def db
    return @db if @db

    @db = SQLite3::Database.new(DB_PATH)
    @db.results_as_hash = true

    return @db
  end

  # Routen /
  get '/' do
    erb(:"index")
  end

  get '/todos' do 
    @todos = db.execute('SELECT * FROM todos')
    erb(:"todos/index")
  end 
  
  get '/todos/new' do 
    erb(:"todos/new")
  end 

  post '/todos/:id/delete' do | id |
    db.execute('DELETE FROM todos WHERE id=?', id)
    redirect('/todos') 
  end 

  post '/todos' do 
    f_name = params['name']
    f_description = params['description']
    db.execute("INSERT INTO todos (name, description) VALUES(?,?)", [f_name, f_description])
    redirect('/todos')
  end

  get '/todos/:id' do | id |
    @todo = db.execute('SELECT * FROM todos WHERE id=?', id).first 
    ap @todo
    erb(:"todos/show")
  end 
  
  get "/todos/:id/edit" do | id |
    @todos = db.execute('SELECT * FROM todos WHERE id=?', id).first
    erb(:"todos/edit")
  end
  
  post "/todos/:id/update" do | id |
    f_name = params["name"]
    f_category = params["description"]
    db.execute("UPDATE todos SET name=?, description=? WHERE id=?", [f_name, f_category, id])
    redirect("/todos")
  end

  get '/users' do 
    erb(:"users/index")
  end
end

require 'sqlite3'
require_relative '../config'

class Seeder

  def self.seed!
    puts "Using db file: #{DB_PATH}"
    puts "🧹 Dropping old tables..."
    drop_tables
    puts "🧱 Creating tables..."
    create_tables
    puts "🍎 Populating tables..."
    populate_tables
    puts "✅ Done seeding the database!"
  end

  def self.drop_tables
    db.execute('DROP TABLE IF EXISTS todos') 
    db.execute('DROP TABLE IF EXISTS users')
    #ta bort användsartabellen
  end

  def self.create_tables
    db.execute('CREATE TABLE todos (
                id INTEGER PRIMARY KEY AUTOINCREMENT,
                name TEXT NOT NULL,
                category_id INTEGER, 
                description TEXT)') 
    db.execute('CREATE TABLE users (
                user_name TEXT NOT NULL,
                user_password)')

  #skapa användartabellen
  end

  def self.populate_tables
    db.execute('INSERT INTO todos (name, description) VALUES ("Köp mjölk", "3 lite mellanmjölk, eko")')
    db.execute('INSERT INTO todos (name, description) VALUES ("Köp julgran", "En rödgran")')
    db.execute('INSERT INTO todos (name, description) VALUES ("Pynta gran", "Glöm inte lamporna i granen och tomten")')
    db.execute('INSERT INTO users (user_name, user_password) VALUES ("Albert", "Westman")') 
    db.execute('INSERT INTO users (user_name, user_password) VALUES ("Simon", "Olesen")') 
    #lägg till 2 användare i users
  end

  private

  def self.db
    @db ||= begin
      db = SQLite3::Database.new(DB_PATH)
      db.results_as_hash = true
      db
    end
  end
end

Seeder.seed!
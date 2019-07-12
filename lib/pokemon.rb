require 'pry'
require_relative "../bin/environment.rb"
class Pokemon
  attr_accessor :id, :name, :type, :db, :hp

  def initialize(id:, name:, type:, db:, hp: nil)
    @id = id
    @name = name
    @type = type
    @hp = hp
    @db = db
  end

  def self.save(name, type, db)
      sql = <<-SQL
      INSERT INTO pokemon (name, type) VALUES (?, ?)
      SQL
      db.execute(sql, name, type)
      @id = db.execute("SELECT last_insert_rowid() FROM pokemon")[0][0]
  end

  def self.find(id, db)
    sql = <<-SQL
    SELECT * FROM pokemon WHERE id = ?
    SQL
    result = db.execute(sql, id)[0]
    self.new(id: result[0], name: result[1], type: result[2], db: db, hp: 60)
  end
  #
  # def alter_hp(hp, db)
  #   sql = "UPDATE pokemon SET hp = ? WHERE id = ?;"
  #   db.execute(sql, hp, self.id)
  # #   Pokemon.new(id: self.id, name: self.name, type: self.type, hp: self.hp, db: db)
  # # #   binding.pry
  # # #   db.execute(sql, self.hp, self.id)
  # end
  #

end

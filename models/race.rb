require_relative('../db/sql_runner')

class Race

  attr_reader :race, :id

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @race = options['race']
  end

  def save
    values = [@race]
    sql = 'INSERT INTO races
            (race)
            VALUES
            ($1)
            RETURNING id'
    @id = SqlRunner.run(sql, values).first['id'].to_i
  end

  def update
    values = [@race, @id]
    sql = 'UPDATE races
            SET race
            =
            $1
            WHERE id = $2'
    SqlRunner.run(sql, values)
  end

  def self.delete_by_id(id)
    values = [id]
    sql = 'DELETE FROM races
            WHERE id = $1'
    SqlRunner.run(sql, values)
  end

  def self.find_by_id(id)
    values = [id]
    sql = 'SELECT * FROM races
            WHERE id = $1'
    SqlRunner.run(sql,values).first
  end

  def self.find_other_races(id)
    values = [id]
    sql = 'SELECT * FROM races
            WHERE races.id > 0 AND races.id NOT IN ($1)'
    SqlRunner.run(sql, values).map{|race|race}
  end

  def self.find_chars(id)
    values = [id]
    sql = 'SELECT * FROM characters
            WHERE characters.race_id = $1'
    SqlRunner.run(sql, values).map{|character|Character.new(character)}
  end

  def self.all
    sql = 'SELECT * FROM races
            WHERE id > 0
            ORDER BY race'
    SqlRunner.run(sql).map{|race|Race.new(race)}
  end

  def self.delete_all
    sql = 'DELETE FROM races
            WHERE id > 0'
    SqlRunner.run(sql)
  end
end

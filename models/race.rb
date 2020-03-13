require_relative('../db/sql_runner')

class Race

  attr_reader :race, :id

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @race = options['race']
  end

  def save()
    values = [@race]
    sql = 'INSERT INTO races
            (race)
            VALUES
            ($1)
            RETURNING id'
    @id = SqlRunner.run(sql, values).first['id'].to_i
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

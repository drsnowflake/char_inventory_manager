require_relative('../db/sql_runner')

class Character

  attr_reader :name, :race, :class, :id

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @name = options['name']
    @race = options['race']
    @class = options['class']
  end

  def save()
    values = [@name, @race, @class]
    sql = 'INSERT INTO characters
            (name, race, class)
            VALUES
            ($1,$2,$3)
            RETURNING id'
    @id = SqlRunner.run(sql, values).first()['id'].to_i
  end

  def update()
    values = [@name, @race, @class, @id]
    sql = "UPDATE characters
            SET (name, race, class)
            =
            ($1,$2,$3)
            WHERE id = $4"
    SqlRunner.run(sql, values)
  end

  def inventory()
    values = [@id]
    sql = 'SELECT * FROM characters
            INNER JOIN inventory ON characters.id = inventory.char_id
            WHERE characters.id = $1'
    results = SqlRunner.run(sql,values).first
  end

  def self.delete_all
    sql = 'DELETE FROM characters'
    SqlRunner.run(sql)
  end
end

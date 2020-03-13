require_relative('../db/sql_runner')

class Item

  attr_reader :name, :slot, :flav, :id

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @name = options['name']
    @slot = options['slot'].to_i
    @flav = options['flav']
  end

  def save()
    values = [@name, @slot, @flav]
    sql = 'INSERT INTO items
            (name, slot, flav)
            VALUES
            ($1,$2,$3)
            RETURNING id'
    @id = SqlRunner.run(sql, values).first()['id'].to_i
  end


  def self.delete_all
    sql = 'DELETE FROM items'
    SqlRunner.run(sql)
  end
end

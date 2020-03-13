require_relative('../db/sql_runner')

class Slot

  attr_reader :slot_name, :id

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @slot_name = options['slot_name']
  end

  def save()
    values = [@slot_name]
    sql = 'INSERT INTO slots
            (slot_name)
            VALUES
            ($1)
            RETURNING id'
    @id = SqlRunner.run(sql, values).first['id'].to_i
  end

  def self.all
    sql = 'SELECT * FROM slots
            WHERE id > 0
            ORDER BY slot_name'
    SqlRunner.run(sql).map{|slot|Slot.new(slot)}
  end

  def self.delete_all
    sql = 'DELETE FROM slots
            WHERE id > 0'
    SqlRunner.run(sql)
  end
end

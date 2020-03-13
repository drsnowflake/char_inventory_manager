require_relative('../db/sql_runner')

class Inventory

  attr_reader :char_id, :item_id, :id

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @char_id = options['char_id'].to_i
    @item_id = options['item_id'].to_i
  end

  def save()
    values = [@char_id, @item_id]
    sql = 'INSERT INTO inventory
            (char_id, item_id)
            VALUES
            ($1,$2)
            RETURNING id'
    @id = SqlRunner.run(sql, values).first()['id'].to_i
  end


  def self.delete_all
    sql = 'DELETE FROM inventory'
    SqlRunner.run(sql)
  end
end

require_relative('../db/sql_runner')

class Inventory

  attr_reader :char_id, :item_id, :id

  @capacity = 8

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @char_id = options['char_id'].to_i
    @item_id = options['item_id'].to_i
    @equipped = options['equipped']
  end

  def save
    values = [@char_id, @item_id]
    sql = 'INSERT INTO inventory
            (char_id, item_id)
            VALUES
            ($1,$2)
            RETURNING id'
    @id = SqlRunner.run(sql, values).first['id'].to_i
  end

  def update
    values = [@char_id, @item_id, @id]
    sql = 'UPDATE inventory
            SET (char_id, item_id)
            =
            ($1,$2)
            WHERE id = $4'
    SqlRunner.run(sql, values)
  end

  def self.capacity
    @capacity
  end

  def self.all
    sql = 'SELECT * FROM inventory'
    SqlRunner.run(sql).map{|inv|Inventory.new(inv)}
  end

  def self.find_by_id(id)
    values = [id]
    sql = 'SELECT characters.id AS char_id,
                  characters.char_name,
                  items.id,
                  items.item_name,
                  items.slot,
                  slots.slot_name,
                  inventory.id AS inv_id
            FROM items
            INNER JOIN slots
            ON slots.id = items.slot
            INNER JOIN inventory
            ON inventory.item_id = items.id
            INNER JOIN characters
            ON characters.id = inventory.char_id
            WHERE inventory.id = $1'
    SqlRunner.run(sql,values).first
  end

  def self.find_inventory(id)
    values = [id]
    sql = 'SELECT items.id,
                  items.item_name,
                  slots.slot_name,
                  inventory.id as inv_id
            FROM items
            INNER JOIN inventory
            ON inventory.item_id = items.id
            INNER JOIN slots
            ON slots.id = items.slot
            INNER JOIN characters
            ON characters.id = inventory.char_id
            WHERE characters.id = $1'
    SqlRunner.run(sql,values)
  end

  def self.delete_by_id(id)
    values = [id]
    sql = 'DELETE FROM inventory
            WHERE id = $1'
    SqlRunner.run(sql,values)
  end

  def self.delete_all
    sql = 'DELETE FROM inventory'
    SqlRunner.run(sql)
  end
end

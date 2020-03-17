require_relative('../db/sql_runner')

class Item

  attr_reader :item_name, :slot, :flav, :id

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @item_name = options['item_name']
    @slot = options['slot'].to_i
    @flav = options['flav']
  end

  def save
    values = [@item_name, @slot, @flav]
    sql = 'INSERT INTO items
            (item_name, slot, flav)
            VALUES
            ($1,$2,$3)
            RETURNING id'
    @id = SqlRunner.run(sql, values).first['id'].to_i
  end

  def update
    values = [@item_name, @slot, @flav, @id]
    sql = 'UPDATE items
            SET (item_name, slot, flav)
            =
            ($1,$2,$3)
            WHERE id = $4'
    SqlRunner.run(sql, values)
  end

  def self.find_by_id(id)
    values = [id]
    sql = 'SELECT characters.id AS char_id,
                  characters.char_name,
                  items.id,
                  items.item_name,
                  items.slot,
                  items.flav,
                  slots.slot_name,
                  inventory.id AS inv_id
            FROM items
            INNER JOIN slots
            ON slots.id = items.slot
            INNER JOIN inventory
            ON inventory.item_id = items.id
            INNER JOIN characters
            ON characters.id = inventory.char_id
            WHERE items.id = $1'
    SqlRunner.run(sql,values).first
  end

  def self.delete_by_id(id)
    values = [id]
    sql = 'DELETE FROM items
            WHERE id = $1'
    SqlRunner.run(sql,values)
  end

  def self.all
    sql = 'SELECT * FROM items
            ORDER BY item_name'
    SqlRunner.run(sql).map{|item|Item.new(item)}
  end

  def self.delete_all
    sql = 'DELETE FROM items'
    SqlRunner.run(sql)
  end
end

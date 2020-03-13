require_relative('../db/sql_runner')

class Character

  attr_reader :char_name, :race_id, :role_id, :id

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @char_name = options['char_name']
    @race_id = options['race_id'].to_i
    @role_id = options['role_id'].to_i
  end

  def save_holder
    values = [@char_name, @race_id, @role_id, @id]
    sql = 'INSERT INTO characters
            (char_name, race_id, role_id, id)
            VALUES
            ($1,$2,$3,$4)'
    SqlRunner.run(sql, values)
  end

  def save
    values = [@char_name, @race_id, @role_id]
    sql = 'INSERT INTO characters
            (char_name, race_id, role_id)
            VALUES
            ($1,$2,$3)
            RETURNING id'
    @id = SqlRunner.run(sql, values).first['id'].to_i
  end

  def update
    values = [@char_name, @race_id, @role_id, @id]
    sql = "UPDATE characters
            SET (char_name, race_id, role_id)
            =
            ($1,$2,$3)
            WHERE id = $4"
    SqlRunner.run(sql, values)
  end

  def self.find_by_id(id)
    values = [id]
    sql = 'SELECT characters.*, races.race, roles.role FROM characters
            INNER JOIN races on races.id = characters.race_id
            INNER JOIN roles on roles.id = characters.role_id
            WHERE characters.id = $1'
    SqlRunner.run(sql,values).first
  end

  def self.all
    sql = 'SELECT * FROM characters
            ORDER BY id'
    SqlRunner.run(sql).map{|character|Character.new(character)}
  end

  def self.delete_by_id(id)
    values = [id]
    sql = 'DELETE FROM characters
            WHERE id = $1'
    SqlRunner.run(sql,values)
  end

  def self.delete_all
    sql = 'DELETE FROM characters
            WHERE id >= 0'
    SqlRunner.run(sql)
  end
end

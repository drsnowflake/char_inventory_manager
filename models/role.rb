require_relative('../db/sql_runner')

class Role

  attr_reader :role, :id

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @role = options['role']
  end

  def save
    values = [@role]
    sql = 'INSERT INTO roles
            (role)
            VALUES
            ($1)
            RETURNING id'
    @id = SqlRunner.run(sql, values).first['id'].to_i
  end

  def update
    values = [@role, @id]
    sql = 'UPDATE roles
            SET role
            =
            $1
            WHERE id = $2'
    SqlRunner.run(sql, values)
  end

  def self.delete_by_id(id)
    values = [id]
    sql = 'DELETE FROM roles
            WHERE id = $1'
    SqlRunner.run(sql, values)
  end

  def self.find_by_id(id)
    values = [id]
    sql = 'SELECT * FROM roles
            WHERE id = $1'
    SqlRunner.run(sql,values).first
  end

  def self.find_other_roles(id)
    values = [id]
    sql = 'SELECT * FROM roles
            WHERE roles.id > 0 AND roles.id NOT IN ($1)'
    SqlRunner.run(sql, values).map{|role|role}
  end

  def self.find_chars(id)
    values = [id]
    sql = 'SELECT * FROM characters
            WHERE characters.role_id = $1'
    SqlRunner.run(sql, values).map{|character|Character.new(character)}
  end

  def self.all
    sql = 'SELECT * FROM roles
            WHERE id > 0
            ORDER BY role'
    SqlRunner.run(sql).map{|role|Role.new(role)}
  end

  def self.delete_all
    sql = 'DELETE FROM roles
            WHERE id > 0'
    SqlRunner.run(sql)
  end
end

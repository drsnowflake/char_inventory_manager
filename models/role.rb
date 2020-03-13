require_relative('../db/sql_runner')

class Role

  attr_reader :role, :id

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @role = options['role']
  end

  def save()
    values = [@role]
    sql = 'INSERT INTO roles
            (role)
            VALUES
            ($1)
            RETURNING id'
    @id = SqlRunner.run(sql, values).first['id'].to_i
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

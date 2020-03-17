require_relative('../db/sql_runner')

class Character

  attr_accessor :race_id, :role_id
  attr_reader :id, :char_name

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @char_name = options['char_name']
    @race_id = options['race_id'].to_i
    @role_id = options['role_id'].to_i
  end

  def save
    if @id.to_i == -1
      return
    end
    values = [@char_name, @race_id, @role_id]
    sql = 'INSERT INTO characters
            (char_name, race_id, role_id)
            VALUES
            ($1,$2,$3)
            RETURNING id'
    @id = SqlRunner.run(sql, values).first['id'].to_i
  end

  def update
    if @id.to_i == -1
      return
    end
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
    sql = 'SELECT characters.id,
                  characters.char_name,
                  characters.race_id,
                  characters.role_id,
                  races.race,
                  roles.role
            FROM characters
            INNER JOIN races
            ON races.id = characters.race_id
            INNER JOIN roles
            ON roles.id = characters.role_id
            WHERE characters.id = $1'
    SqlRunner.run(sql,values).first
  end

  def self.all
    sql = 'SELECT * FROM characters
            ORDER BY char_name'
    SqlRunner.run(sql).map{|character|Character.new(character)}
  end

  def self.delete_by_id(id)
    if id.to_i == -1
      return
    end
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

  def self.random_name
    first_names = [{"first_name"=>"Devin"},{"first_name"=>"Gannon"},{"first_name"=>"Upton"},{"first_name"=>"Jin"},{"first_name"=>"Bevis"},{"first_name"=>"Blair"},{"first_name"=>"Nathaniel"},{"first_name"=>"Jesse"},{"first_name"=>"Stone"},{"first_name"=>"Kyra"},{"first_name"=>"Inga"},{"first_name"=>"Oren"},{"first_name"=>"Peter"},{"first_name"=>"Kyle"},{"first_name"=>"Dara"},{"first_name"=>"Venus"},{"first_name"=>"Kendall"},{"first_name"=>"Adria"},{"first_name"=>"Vivian"},{"first_name"=>"Barry"},{"first_name"=>"Melyssa"},{"first_name"=>"Dieter"},{"first_name"=>"Marsden"},{"first_name"=>"Kylie"},{"first_name"=>"Addison"},{"first_name"=>"Seth"},{"first_name"=>"Althea"},{"first_name"=>"Anika"},{"first_name"=>"Basil"},{"first_name"=>"Sean"},{"first_name"=>"Mohammad"},{"first_name"=>"Peter"},{"first_name"=>"Lillian"},{"first_name"=>"Lara"},{"first_name"=>"Fleur"},{"first_name"=>"Chiquita"},{"first_name"=>"Stone"},{"first_name"=>"Abdul"},{"first_name"=>"Rebekah"},{"first_name"=>"Zahir"},{"first_name"=>"Camden"},{"first_name"=>"Cathleen"},{"first_name"=>"Paki"},{"first_name"=>"Bruce"},{"first_name"=>"Jackson"},{"first_name"=>"Rajah"},{"first_name"=>"Eden"},{"first_name"=>"Kato"},{"first_name"=>"Marsden"},{"first_name"=>"Patience"},{"first_name"=>"Randall"},{"first_name"=>"Stone"},{"first_name"=>"Valentine"},{"first_name"=>"Yuri"},{"first_name"=>"Aubrey"},{"first_name"=>"Kaseem"},{"first_name"=>"Irene"},{"first_name"=>"Adele"},{"first_name"=>"John"},{"first_name"=>"Jorden"},{"first_name"=>"Hedda"},{"first_name"=>"Oliver"},{"first_name"=>"Dane"},{"first_name"=>"Sasha"},{"first_name"=>"Samson"},{"first_name"=>"Hayes"},{"first_name"=>"Jonah"},{"first_name"=>"Ryder"},{"first_name"=>"Martin"},{"first_name"=>"Geoffrey"},{"first_name"=>"Deborah"},{"first_name"=>"Isabelle"},{"first_name"=>"Ursula"},{"first_name"=>"Maya"},{"first_name"=>"Cruz"},{"first_name"=>"Paula"},{"first_name"=>"Micah"},{"first_name"=>"Stephanie"},{"first_name"=>"Rhea"},{"first_name"=>"Evan"},{"first_name"=>"Hilel"},{"first_name"=>"Leila"},{"first_name"=>"Laith"},{"first_name"=>"Ruby"},{"first_name"=>"Bruno"},{"first_name"=>"Hamish"},{"first_name"=>"Yardley"},{"first_name"=>"Jordan"},{"first_name"=>"Avram"},{"first_name"=>"Wynter"},{"first_name"=>"Mikayla"},{"first_name"=>"Kennedy"},{"first_name"=>"Coby"},{"first_name"=>"Indira"},{"first_name"=>"Hanna"},{"first_name"=>"Scott"},{"first_name"=>"Isaac"},{"first_name"=>"Erasmus"},{"first_name"=>"Kaseem"},{"first_name"=>"Vincent"}]

    last_names = [{"last_name"=>"Crawford"},{"last_name"=>"Fitzgerald"},{"last_name"=>"Franco"},{"last_name"=>"Smith"},{"last_name"=>"Davis"},{"last_name"=>"Parker"},{"last_name"=>"Leonard"},{"last_name"=>"Kline"},{"last_name"=>"West"},{"last_name"=>"Stewart"},{"last_name"=>"Hernandez"},{"last_name"=>"Ratliff"},{"last_name"=>"Medina"},{"last_name"=>"Chaney"},{"last_name"=>"Frye"},{"last_name"=>"Underwood"},{"last_name"=>"Foreman"},{"last_name"=>"Horton"},{"last_name"=>"Solomon"},{"last_name"=>"Vaughan"},{"last_name"=>"Nieves"},{"last_name"=>"Young"},{"last_name"=>"Chandler"},{"last_name"=>"Carpenter"},{"last_name"=>"Finley"},{"last_name"=>"Yates"},{"last_name"=>"Mullen"},{"last_name"=>"Wilkinson"},{"last_name"=>"Holcomb"},{"last_name"=>"Calhoun"},{"last_name"=>"Bowers"},{"last_name"=>"Bates"},{"last_name"=>"Macdonald"},{"last_name"=>"Battle"},{"last_name"=>"Carroll"},{"last_name"=>"Delgado"},{"last_name"=>"Sparks"},{"last_name"=>"Cruz"},{"last_name"=>"Mckee"},{"last_name"=>"Montoya"},{"last_name"=>"Wade"},{"last_name"=>"Cook"},{"last_name"=>"Bates"},{"last_name"=>"Weaver"},{"last_name"=>"Velazquez"},{"last_name"=>"Cooke"},{"last_name"=>"Blankenship"},{"last_name"=>"Harrington"},{"last_name"=>"Wilkinson"},{"last_name"=>"Alston"},{"last_name"=>"Mckenzie"},{"last_name"=>"Powell"},{"last_name"=>"Massey"},{"last_name"=>"Mcintosh"},{"last_name"=>"Schmidt"},{"last_name"=>"Rowe"},{"last_name"=>"Rasmussen"},{"last_name"=>"Nunez"},{"last_name"=>"Stanley"},{"last_name"=>"Bruce"},{"last_name"=>"Walker"},{"last_name"=>"Chambers"},{"last_name"=>"Puckett"},{"last_name"=>"Horne"},{"last_name"=>"Harmon"},{"last_name"=>"Ellis"},{"last_name"=>"Joyner"},{"last_name"=>"Patterson"},{"last_name"=>"Mayer"},{"last_name"=>"Blackwell"},{"last_name"=>"Huffman"},{"last_name"=>"Trujillo"},{"last_name"=>"Benjamin"},{"last_name"=>"Christensen"},{"last_name"=>"Foreman"},{"last_name"=>"Winters"},{"last_name"=>"Donovan"},{"last_name"=>"Jenkins"},{"last_name"=>"Hale"},{"last_name"=>"Bell"},{"last_name"=>"Terry"},{"last_name"=>"Zimmerman"},{"last_name"=>"Garcia"},{"last_name"=>"Parks"},{"last_name"=>"Santos"},{"last_name"=>"Ferguson"},{"last_name"=>"Lambert"},{"last_name"=>"Head"},{"last_name"=>"Mullins"},{"last_name"=>"Puckett"},{"last_name"=>"Larson"},{"last_name"=>"Calderon"},{"last_name"=>"Rowland"},{"last_name"=>"Castro"},{"last_name"=>"Riggs"},{"last_name"=>"Mcintyre"},{"last_name"=>"Gillespie"},{"last_name"=>"Galloway"},{"last_name"=>"Francis"},{"last_name"=>""}]

    chosen_first = first_names.sample['first_name']
    chosen_last = last_names.sample['last_name']
    random_name = "#{chosen_first} #{chosen_last}"
  end
end

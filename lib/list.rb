require 'pry'
class List

  def initialize name, id=nil
    @id = id
    @name = name
  end

  def name
    @name
  end

  def == another_list
    @id = another_list.id
  end

  def self.all
    results = DB.exec("SELECT * FROM lists;")
    lists = []
    results.each do |result|
      name = result['name']
      id = result['id'].to_i
      lists << List.new(name, id)
    end
    lists
  end

  def save
    results = DB.exec("INSERT INTO lists (name) VALUES ('#{@name}') RETURNING id;")
    @id = results.first['id'].to_i
  end

  def id
    @id
  end

  def tasks
    tasks = DB.exec("SELECT * FROM tasks WHERE list_id = #{@id};")
    results = []
    tasks.each do |task|
      results << task['name']
    end
    results
  end

  def delete!
    list = DB.exec("SELECT * FROM lists")
    list.each do |list_name|
      if name == list_name['name']
        DB.exec("DELETE FROM lists;")
        DB.exec("DELETE FROM tasks;")
      end
    end
  end
end

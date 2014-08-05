require 'pg'

class Task
  def initialize name, list_id, completed=nil
    @list_id = list_id
    @name = name
    @completed = completed
  end

  def name
    @name
  end

  def list_id
    @list_id
  end

  def completed
    results = []
    marked = DB.exec("SELECT * FROM tasks WHERE completed = 'true';")
    marked.each do |mark|
      results << mark['completed']
    end
    results
  end

  def save
    DB.exec("INSERT INTO tasks (name, list_id) VALUES ('#{@name}', '#{@list_id}');")
  end

  def self.all
    results = DB.exec("SELECT * FROM tasks;")
    tasks = []
    results.each do |result|
      name = result['name']
      list_id = result['list_id'].to_i
      tasks << Task.new(name, list_id)
    end
    tasks
  end

  def == another_task
    @name == another_task.name && @list_id == another_task.list_id
  end

  def delete
    results = DB.exec("SELECT * FROM tasks;")
    results.each do |result|
      if @name == result['name']
        DB.exec("DELETE FROM tasks WHERE name = '#{@name}';")
      end
    end
  end

  def mark_completed
    DB.exec("UPDATE tasks SET completed = 'true' WHERE name = '#{@name}';")
  end
end

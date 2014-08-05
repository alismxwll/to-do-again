require 'spec_helper'

describe 'Task' do
  it 'initializes with a name amd a list ID' do
    task = Task.new 'learn SQrrrLLLLL', 1
    expect(task).to be_an_instance_of Task
  end

  it 'returns its name' do
    task = Task.new 'stuff and things', 2
    expect(task.name).to eq 'stuff and things'
  end

  it 'returns its list ID' do
    task = Task.new 'stuff and things', 2
    expect(task.list_id).to eq 2
  end

  it 'starts with no tasks' do
    expect(Task.all).to eq []
  end

  it 'lets you save tasks to a database' do
    task = Task.new('learning is fun!!', 3)
    task.save
    expect(Task.all).to eq [task]
  end

  it 'is the same task if it has the same name' do
    task1 = Task.new 'learn juggling', 4
    task2 = Task.new 'learn juggling', 4
    expect(task1).to eq task2
  end

  it 'deletes a task' do
    task_twelve = Task.new('Im twelve', 3)
    task_twelve.save
    task = Task.new('fly away', 3)
    task.save
    task.delete
    Task.all
    expect(Task.all).to eq [task_twelve]
  end

  it 'allows the capability to mark a task as finished' do
    task = Task.new('learn to ski', 8)
    task.save
    task.mark_completed
    expect(task.completed).to eq ['t']
  end
end

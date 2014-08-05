require 'spec_helper'

describe 'List' do
  it 'initializes with a name and nil ID' do
    list = List.new 'classes'
    expect(list).to be_an_instance_of List
  end

  it 'has a name' do
    new_list = List.new 'work, work, work'
    expect(new_list.name).to eq 'work, work, work'
  end

  it 'is the same list as the list with the same id' do
    new_list = List.new 'work, work, work', 4
    new_list2 = List.new 'work, work, work', 4
    expect(new_list).to eq new_list2
  end

  it 'starts off with no lists' do
    expect(List.all).to eq []
  end

  it 'saves lists to the database' do
    list = List.new 'learn to make money'
    list.save
    expect(List.all).to eq [list]
  end

  it 'sets its ID when saved' do
    list = List.new('Collages')
    list.save
    expect(list.id).to be_an_instance_of Fixnum
  end

  it 'initializes with its database id' do
    list = List.new('stuffinit', 1)
    expect(list).to be_an_instance_of List
  end
end

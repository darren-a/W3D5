require_relative 'db_connection'
require 'active_support/inflector'
# NB: the attr_accessor we wrote in phase 0 is NOT used in the rest
# of this project. It was only a warm up.


# Before we begin writing methods that interact with the DB, we need to
# be able to figure out which table the records should be fetched from,
# inserted into, etc. We should write a class getter method ::table_name
# which will get the name of the table for the class. We should also
# write a ::table_name= setter to set the table. Since our SQLObject
# class is itself an object (an instance of Class), we can store that as
# a instance variable on the class #everythingisanobject.


class SQLObject

  def self.columns
    # here we got to the dB, grab the columns (with data), extract element
    # 0, which is the list of column names, and return it.
    @columns ||= DBConnection.execute2(<<-SQL)
    SELECT
      *
    FROM
      #{self.table_name}
    SQL
    .first.map(&:to_sym) # .first gives col names only
  end

  def self.finalize!
  end

  def self.table_name=(table_name)
    @table_name = table_name
  end

  def self.table_name
    # since we're using active_support/tableize there is a String.tableize
    # method we can call to turn class names into plural, lowercase, table
    # names
    @table_name ||= self.to_s.tableize
  end

  def self.all
    # return an array of all the records in the DB


  end

  def self.parse_all(results)
    # ...
  end

  def self.find(id)
    # look up a single record by primary key


  end

  def initialize(params = {})
    # ...
  end

  def attributes
    # Let's define #attributes in SQLObject. It should lazily initialize
    # @attributes to an empty hash in case it doesn't exist yet.
    # After we set up the ::finalize! method properly, it should work like so:
    #   cat = Cat.new
    #   cat.attributes #=> {}
    #   cat.name = "Gizmo"
    #   cat.attributes #=> { name: "Gizmo" }
    @attributes ||= {}
  end

  def attribute_values
    # ...
  end

  def insert
    # insert a new row into the table to represent the SQLObject


  end

  def update
    # update the row with the id of this SQLObject


  end

  def save
    # convenience method that either calls insert/update
    # depending on whether or not the SQLObject already exists
    # in the table.


  end
end

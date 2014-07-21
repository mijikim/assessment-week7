class Messages
  def initialize(database_connection)
    @database_connection = database_connection
  end

  def create(name, message)
    insert_message_sql = <<-SQL
      INSERT INTO messages (username, messages)
      VALUES ('#{name}', '#{message}')
      RETURNING id
      SQL

    @database_connection.sql(insert_message_sql).first["id"]
  end

  def messages
    messages_sql = <<-SQL
    SELECT * FROM messages
    SQL

    @database_connection.sql(messages_sql)
  end

end

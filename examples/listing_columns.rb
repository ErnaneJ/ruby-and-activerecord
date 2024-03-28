# ./examples/listing_columns.rb

puts "-" * 10 + " Listando Colunas da Tabela " + "-" * 10
User.columns.each do |column|
  puts "#{column.name} => #{column.type}"
end
puts "-" * 50
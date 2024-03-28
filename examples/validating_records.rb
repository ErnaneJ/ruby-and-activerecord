# ./examples/validating_records.rb

puts "-" * 10 + " Validando campos " + "-" * 10

usuario = User.new
usuario.email = 'test'
usuario.admin = 1
usuario.name = "Ernane123"
usuario.age = 50.5
usuario.tshirt_size = 'XM'

# Alternativamente, chame `u.valid?` ou `u.invalid?` para gerar erros
unless usuario.save
  usuario.errors.messages.each do |field, messages|
    puts "#{field}: #{messages}"
  end
end
puts "-" * 50
# ./examples/finding_records.rb

puts "-" * 10 + " Encontrando Registros " + "-" * 10

# Obter o primeiro usuário
primeiro_usuario = User.first
puts primeiro_usuario.name

# Obter o último usuário
ultimo_usuario = User.last
puts ultimo_usuario.name

# Também disponível: User.second, User.third, User.fourth, User.fifth

# Encontrar o primeiro usuário que corresponde à consulta
usuario = User.find_by(name: 'nomeNovo')
puts usuario.name

# Encontrar todos os usuários que correspondem à consulta e depois pegar o primeiro da lista
adultos = User.where('age > ?', 18)
puts "Adultos: #{adultos.length}"

# ./examples/finding_records.rb

# Obter todos os usuários
puts "Total de usuários: #{User.all.length}"

# Obter todos os usuários e classificar
usuarios_classificados = User.all.order(age: :desc)
usuarios_classificados.each do |usuario|
  puts "#{usuario.name}: #{usuario.age}"
end

# Você pode combinar vários campos dinamicamente em consultas find_by_*
usuario = User.find_by_name_and_age('nomeNovo', 16)
puts "#{usuario.name} tem #{usuario.age} anos"

# Consultar usando SQL personalizado
usuarios = User.find_by_sql('select * from users')
usuarios.each do |usuario|
  puts "#{usuario.name} tem #{usuario.age} anos"
end

puts "-" * 50
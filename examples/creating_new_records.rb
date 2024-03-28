# ./examples/creating_new_records.rb

puts "-" * 10 + " Criando Novos Registros " + "-" * 10
# Criar um novo objeto de usuário e então salvá-lo para armazenar no banco de dados
user = User.new(name: 'ErnaneDois', age: 16, email: 'teste@teste.com', admin: false, tshirt_size: 'M')
user.save

# Usar um bloco para preencher o objeto e então salvar
User.new do |u|
  u.name = 'ErnaneUm'
  u.age = 18
  u.email = 'teste@teste.com'
  u.admin = false
  u.tshirt_size = 'M'
end.save

# Criar e salvar em uma única etapa com ".create()"
User.create(name: 'ErnaneTres', age: 18, email: 'teste@teste.com', admin: false, tshirt_size: 'M')
puts "-" * 50
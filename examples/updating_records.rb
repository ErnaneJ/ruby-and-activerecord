# ./examples/updating_records.rb

puts "-" * 10 + " Atualizando Registros " + "-" * 10
# Atualizar modificando um objeto de usuário e chamando explicitamente ".save"
usuario = User.first
usuario.name = 'novoNome'
usuario.save

# Atualizar e salvar em uma única etapa
User.first.update(name: 'nomeNovo')
puts "-" * 50
# ./examples/testing_transactions.rb

# Exemplo 1: Deve tentar mudar o nome e idade e falhar. 
# Deve tentar mudar a idade e deve falhar pois o valor tem que ser inteiro. 
# Como falhou as alterações já realizadas, mesmo que em sucesso, devem ser revertidas.

puts "-" * 10 + " Testando Transactions " + "-" * 10
begin
  ActiveRecord::Base.transaction do
    usuario = User.first
    puts "Antes 1 =>", usuario.attributes
    usuario.name = 'novonome' # deve funcionar
    usuario.save!

    usuario.age = 50.6 # deve falhar
    usuario.save!
  end
rescue ActiveRecord::RecordInvalid => e
  puts "\nErro ao salvar: #{e.message}\n"
end

# nada muda
usuario = User.first
puts "\nDepois 1 (nada muda) =>", usuario.attributes

# Exemplo 2: Deve tentar mudar o nome e idade e funcionar. 
# Deve tentar mudar a idade funcionar. Como não falhou, as alterações persistem.

ActiveRecord::Base.transaction do
  usuario = User.first
  puts "\nAntes 2 =>", usuario.attributes
  usuario.name = 'novonome' # deve funcionar
  usuario.save!

  usuario.age = 50  # deve funcionar
  usuario.save!
end

# Agora nome e idade foram alterados
usuario = User.first
puts "\nDepois 2 =>", usuario.attributes
puts "Funciona perfeitamente."
puts "-" * 50
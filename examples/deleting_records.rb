# ./examples/deleting_records.rb

puts "-" * 10 + " Excluindo Registros " + "-" * 10
# Maneira funcional, mas ineficiente, de excluir todos os registros:
User.all.each { |usuario| usuario.delete } # ou ainda => User.all.each(&:delete)

# Opção mais eficiente:
User.delete_all
puts "-" * 50
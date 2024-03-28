# Criar um usuário
usuario = User.create(name: 'ErnaneTeste', age: 18, email: 'teste2@teste.com', admin: false, tshirt_size: 'M')

# Criar um perfil associado ao usuário
perfil = Profile.create(bio: 'ErnaneJ', user: usuario)

# Outras maneiras de criar e associar um perfil ao usuário
perfil = Profile.create(bio: 'Hello World! :)')
usuario.profile = perfil

perfil = usuario.create_profile(bio: 'Hello World! :)')

# ./examples/relationships.rb

puts "-" * 10 + " Relacionamentos " + "-" * 10
# Criar alguns posts associados ao usuário (relacionamento um para muitos)
post1 = usuario.posts.create(content: 'Tutorial - Ruby & ActiveRecord (sem Rails) 🚀')
post2 = Post.create(content: 'Tutorial 2', user: usuario)
post3 = usuario.posts.create(content: 'Tutorial 3')

# Criar os departamentos e associá-los ao usuário (relacionamento muitos para muitos)
departamento1 = usuario.departments.create(name: 'Vendas')
departamento2 = Department.create(name: 'Tecnologia da Informação')
departamento2.users << usuario

departamento3 = usuario.departments.create(name: 'Jogos')

# Obtendo os objetos relacionados
usuario_recuperado = User.find_by_name('ErnaneTeste')
puts "\ninspect => ", usuario_recuperado.inspect
puts "\nprofile.inspect => ", usuario_recuperado.profile.inspect
puts "\npost_ids.inspect => ", usuario_recuperado.post_ids.inspect
puts "\nposts.inspect => ", usuario_recuperado.posts.inspect
puts "\ndepartment_ids.inspect => ", usuario_recuperado.department_ids.inspect
puts "\ndepartments.inspect => ", usuario_recuperado.departments.inspect
puts "-" * 50

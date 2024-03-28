# Ruby & ActiveRecord (sem Rails) 🚀

> Recentemente, tive contato com alguns novos entusiastas do Ruby que provavelmente em breve estarão explorando o Rails, dado o caminho que estão seguindo. Acredito que, uma vez que tenhamos uma compreensão básica de Ruby e a linguagem devidamente instalada, é vantajoso explorarmos o Active Record, uma poderosa gem que simplifica significativamente as operações no banco de dados. Dedico este conteúdo a vocês.

## Introdução 🎉

A *gem* Ruby `ActiveRecord` é uma ferramenta poderosa que oferece abstrações simplificadas para interagir com bancos de dados, permitindo uma troca fácil do *back-end* do banco de dados, por exemplo, migrando de `SQLite3` para `MySQL` sem a necessidade de alterar o código. Esta gem possui suporte integrado para abstrações de banco de dados para `SQLite3`, `MySQL` e `PostgreSQL`, e uma das suas principais vantagens é a necessidade mínima de configuração. Embora o `ActiveRecord` seja amplamente utilizado com o framework [Ruby-on-Rails](https://rubyonrails.org/), ele também pode ser empregado com o Sinatra ou até mesmo de forma independente, sem qualquer estrutura web. Aqui iremos nos concentrar em demonstrar o uso do `ActiveRecord` de forma autônoma, fora de qualquer estrutura específica. 🌟

## Preparando o Projeto 🛠️

Para desenvolver este tutorial de forma organizada e facilitar a compreensão e consulta posterior do conteúdo, adotarei uma certa estrutura de pastas e arquivos.

### Criando uma Pasta para o Projeto 📂

```bash
mkdir ruby-and-activerecord
```

### Inicializando o Bundle 📦

Para gerenciar as gems que serão utilizadas, recomenda-se o uso do Bundler. Neste tutorial utilizaremos o Gemfile para escopar as dependências do projeto. Para começar, execute o seguinte comando:

```bash
bundle init
```

Isso criará um novo Gemfile.

### Instalando a Gem ActiveRecord 💎

Para instalar a gem ActiveRecord, você pode utilizar a ferramenta `gem` ou o gerenciador de pacotes do seu sistema, caso esteja disponível. Por exemplo:

```bash
# Instalando com gem
gem install activerecord

# No Ubuntu
apt install ruby-activerecord
```

Entretanto, neste tutorial, utilizaremos o `Gemfile` para organizar as dependências do projeto. Para isso, execute o seguinte comando:

```bash
bundle add activerecord
```

Você também pode adicionar diretamente ao seu `Gemfile`. Ele ficará semelhante ao conteúdo abaixo:

```gemfile
# frozen_string_literal: true

source "https://rubygems.org"

gem "activerecord", "~> 7.1"
```

Depois basta executar o `bundle install`.

### Consultando a Documentação 📚

Antes, durante ou após a leitura deste tutorial (ou qualquer outro), é altamente recomendável que você consulte e verifique as informações diretamente na documentação oficial. Você pode usar o comando `ri` ou acessar a [documentação online](https://api.rubyonrails.org/classes/ActiveRecord/Base.html).

Por exemplo:

```bash
ri ActiveRecord
ri ActiveRecord::Base
```

## Estabelecendo Conexão com o Banco de Dados 🎲

Antes de utilizar qualquer modelo, é essencial estabelecer uma conexão com o banco de dados. Como mencionado anteriormente, há uma grande praticidade em conectar uma aplicação ao `ActiveRecord` com diferentes tipos de banco de dados, como `SQLite3`, `MySQL` ou `PostgreSQL`, por exemplo. Abaixo, apresento exemplos para três adaptadores diferentes:

```ruby
require 'active_record'

# SQLite3
ActiveRecord::Base.establish_connection(
  adapter: 'sqlite3',
  database: 'test.db'
)

# MySQL
ActiveRecord::Base.establish_connection(
  adapter: 'mysql2',
  host: 'localhost',
  username: 'seu_nome_de_usuario_do_banco_de_dados',
  password: 'sua_senha_do_banco_de_dados',
  database: 'seu_nome_do_banco_de_dados'
)

# PostgreSQL
ActiveRecord::Base.establish_connection(
  adapter: 'postgresql',
  host: 'localhost',
  username: 'seu_nome_de_usuario_do_banco_de_dados',
  password: 'sua_senha_do_banco_de_dados',
  database: 'seu_nome_do_banco_de_dados'
)
```

Para este tutorial, estaremos utilizando o SQLite, mas você pode optar por qualquer adaptador que desejar.

### Instalando a Gem SQLite3 🪶

Para utilizar o adaptador `SQLite3`, é necessário instalar a gem correspondente. Assim como fizemos anteriormente com o `ActiveRecord`, faremos o mesmo processo para instalar essa *gem*. Nosso `Gemfile` ficará assim:

```ruby
# frozen_string_literal: true

source "https://rubygems.org"

gem "activerecord", "~> 7.1"
gem "sqlite3", "~> 1.7"
```

### Estabelecendo Conexão com o Banco de Dados SQLite

Para uma melhor organização, criaremos uma pasta de configurações e dentro dela um arquivo `initializer.rb`. Este arquivo será responsável por realizar a conexão com o banco de dados. Para simplificar o processo de configuração, também optaremos por criar um arquivo `.yaml` para armazenar as configurações do banco de dados fora do código.

```ruby
# configurations/initializer.rb
require 'yaml'
require 'active_record'

db_config = YAML::load(File.open(Dir.pwd + '/configurations/database.yaml'))

ActiveRecord::Base.establish_connection(db_config)
```

E em nosso arquivo `database.yaml` teremos as configurações da seguinte forma:

```yaml
# configurations/database.yaml
adapter: 'sqlite3'
database: './database/database.sqlite3'
```

> ℹ️ Estamos armazenando o banco de dados no caminho `./database/database.db`. Se necessário, altere esse caminho ou crie a pasta 'database' na raiz do projeto.

Com isso, a conexão está estabelecida. Para testá-la, basta executar o `initializer.rb` da seguinte forma:

```basg
ruby ./configurations/initializer.rb
```

Se não houver erros, estamos no caminho certo!

## Criando um Modelo 🧑🏼‍💻

Para criar um modelo, basta criar a classe desejada herdando de `ActiveRecord::Base`. Os nomes das tabelas são assumidos com base no nome da classe do modelo que está sendo criado. Por exemplo, um modelo chamado `User` espera ter uma tabela chamada `users`. Um modelo chamado `ProfileUser` espera uma tabela chamada `profile_users`. Ele converte tudo para minúsculas e adiciona um sublinhado entre as palavras em maiúsculas.

Para uma melhor organização, criaremos uma pasta adicional na raiz do projeto, onde guardaremos todas as nossas models. Para começarmos, vamos criar uma model de User.

```ruby
# ./models/user.rb
class User < ActiveRecord::Base
end
```

Tecnicamente, isso é tudo que você precisa fazer. Por padrão, ele mapeará os campos existentes do banco de dados para atributos no modelo. Você não precisa definir cada campo no código. No entanto, se desejar, você pode sobrescrever propriedades como o nome da tabela e a chave primária — *por sua conta e risco* 😬.

```ruby
# ./models/user.rb
class User < ActiveRecord::Base
  self.table_name = 'user'
  self.primary_key = 'user_id'
end
```

## Juntando as Peças 🛠️

Vamos criar um arquivo principal para reunir e usar nossos componentes enquanto experimentamos. Portanto, crie um `main.rb` na raiz do projeto e adicione o seguinte conteúdo:

```ruby
# main.rb
require 'active_record'

require './configurations/initializer.rb'
require './models/user'

User.create(
  name: 'Ernane', 
  age: 16
)
```

Observe que estamos carregando o `ActiveRecord`, executando o `initializer.rb` para estabelecer a conexão com o banco de dados e importando nossa nova `model` de usuário. As próximas linhas são usadas para criar um usuário. Entraremos em detalhes sobre essas instruções em breve.

Para executar, realizamos a mesma ação que fizemos com o initializer:

```bash
ruby main.rb
```

Você pode notar que recebeu um erro porque nossa tabela `users` não existe no banco de dados ainda. Isso ocorre porque, como mencionado, o `ActiveRecord` realiza o mapeamento dos atributos do banco de dados em métodos da classe modelo correspondente. Se a tabela não existir, ocorrerá o erro que você deve estar vendo agora.

Para criar a tabela, você pode executar a criação manualmente em SQL. Por exemplo:

```sql
CREATE TABLE IF NOT EXISTS users (name TEXT, age INT);
```

Ou, se quiser adiantar um pouco no conteúdo, você pode criar uma migração.

Para uma melhor organização, mais uma vez, criaremos uma nova pasta chamada `migrations` dentro da nossa pasta de banco de dados. Lá, adicionaremos uma migração, que nada mais é do que um arquivo Ruby. Por exemplo, para o nosso modelo de usuário:

```ruby
# ./database/migrations/create_user_table.rb

require './configurations/initializer.rb'

class CreateUserTable < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :name
      t.integer :age
      t.string :email
      t.boolean :admin
      t.string :tshirt_size
      t.timestamps
    end
  end
end

CreateUserTable.migrate(:up)
```

Para executar essa migração, basta usar o Ruby no seu terminal como de costume.

```bash
ruby ./database/migrations/create_user_table.rb
```

> Essa não é a melhor forma de lidar com migrações em um projeto. Você pode criar uma tarefa Rake para executar suas migrações, facilitando o processo. No entanto, não vou me ater a esse tópico agora, pois não é o objetivo dessa publicação.

## Uso do ActiveRecord 🤩

Agora que tudo está pronto, podemos executar novamente nosso arquivo principal. Como agora temos a tabela criada, o erro anterior desaparecerá e poderemos realizar nossas primeiras manipulações com o `ActiveRecord`.

### Listando Colunas da Tabela 📋

Depois de criar um modelo, você pode acessar as colunas como objetos vinculados ao modelo. Aqui está um exemplo que irá imprimir as colunas de uma tabela:

```ruby
# ./examples/listing_columns.rb

User.columns.each do |column|
  puts "#{column.name} => #{column.type}"
end
```

### Criando Novos Registros

Existem várias maneiras de criar um novo registro:

- Criar um novo objeto e chamar explicitamente o método `.save()`;
- Usar um bloco para preencher o objeto e chamar o método `.save()`;
- Chamar `.create()` que criará e salvará em uma única etapa;

Aqui estão alguns exemplos de como isso é feito:

```ruby
# ./examples/creating_new_records.rb

# Criar um novo objeto de usuário e então salvá-lo para armazenar no banco de dados
user = User.new(name: 'ErnaneDois', age: 16, email: 'teste0@teste.com', admin: false, tshirt_size: 'M')
user.save

# Usar um bloco para preencher o objeto e então salvar
User.new do |u|
  u.name = 'ErnaneUm'
  u.age = 18
  u.email = 'teste1@teste.com'
  u.admin = false
  u.tshirt_size = 'M'
end.save

# Criar e salvar em uma única etapa com ".create()"
User.create(name: 'ErnaneTres', age: 18, email: 'teste2@teste.com', admin: false, tshirt_size: 'M')
```

### Encontrando Registros

Existem muitos métodos que você pode usar para consultar registros. Alguns deles incluem:

- `first()`
- `last()`
- `second()`, `third()`, `fourth()`, `fifth()`
- `all()`
- `where()`
- `find_by()`
- `find_by_sql()`
- `find_by_*()`

Aqui está um exemplo de como utilizá-los:

```ruby
# ./examples/finding_records.rb

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
```

Acesse o [Guia do Ruby](https://guides.rubyonrails.org/active_record_querying.html) para obter mais informações.

### Atualizando Registros

Para atualizar um registro, você também tem algumas opções. Uma delas é obter o registro, modificá-lo e, em seguida, chamá-lo explicitamente. Outra opção é chamar o método `update()` para fazer a alteração e salvar em uma única ação.

```ruby
# ./examples/updating_records.rb

# Atualizar modificando um objeto de usuário e chamando explicitamente ".save"
usuario = User.first
usuario.name = 'novoNome'
usuario.save

# Atualizar e salvar em uma única etapa
User.first.update(name: 'nomeNovo')
```

### Excluindo Registros

Para excluir um registro, você pode acessar um registro individual ou chamar métodos para excluir todos os registros. Aqui estão alguns exemplos:

```ruby
# ./examples/deleting_records.rb

# Maneira funcional, mas ineficiente, de excluir todos os registros:
User.all.each { |usuario| usuario.delete } # ou ainda => User.all.each(&:delete)

# Opção mais eficiente:
User.delete_all
```

### Funções de Retorno de Chamada

Existem vários métodos que você pode adicionar em modelo que serão acionados automaticamente quando determinadas ações forem executadas, como `criar`, `atualizar` ou `excluir` um registro, além de `consultar` um registro.

Saiba mais sobre retornos de chamada em [Ruby on Rails Guides](https://guides.rubyonrails.org/active_record_callbacks.html#available-callbacks).

Esses métodos de retorno de chamada podem ser classificados em diferentes categorias:

#### Ações de Criação:

- `before_create`
- `after_create`

#### Ações de Criação e Atualização:

- `before_validation`
- `after_validation`
- `before_update`
- `after_update`
- `before_save`
- `after_save`

#### Ação de Exclusão:

- `before_destroy`
- `after_destroy`

#### Ações de Criação, Atualização e Exclusão:

- `after_commit`
- `after_rollback`

#### Ações de Consulta:

- `after_initialize`
- `after_find`

Aqui está um exemplo de como configurar um retorno de chamada usando blocos:

```ruby
# ./models/user.rb

class User < ActiveRecord::Base
  before_create do |u|
    puts "Prestes a criar o usuário: #{u.name}"
  end

  after_create do |u|
    puts "Novo objeto de usuário criado: #{u.name}"
  end
end
```

Outra maneira é especificar as funções de retorno de chamada a serem executadas usando `symbols`, operando em `self`:

```ruby
# ./models/user.rb

class User < ActiveRecord::Base
  before_create :before_create_callback
  after_create :after_create_callback

  def before_create_callback
    puts "Prestes a criar o usuário: #{self.name}"
  end

  def after_create_callback
    puts "Novo objeto de usuário criado: #{self.name}"
  end
end
```

```ruby
User.create(name: 'Ernane', age: 16) # Aciona os callbacks definidos anteriormente
```

Os retornos de chamada "*around*" (`around_create`, por exemplo) são um pouco mais complexos. Eles permitem que você execute código antes e depois de uma ação, podendo ser úteis para *benchmarking* de desempenho, por exemplo.

```ruby
# ./models/user.rb

class User < ActiveRecord::Base
  around_create :around_create_callback

  def around_create_callback
    puts 'Um usuário está prestes a ser criado'
    yield # Aguarde até que o salvamento tenha ocorrido
    puts 'Um usuário foi criado.'
  end
end
```

```ruby
User.create(name: 'Ernane', age: 16) # Aciona o callback definido anteriormente
```

### Validação de Campos

Ao adicionar validações a um modelo, você garante que qualquer objeto salvo atenda a determinados padrões. Existem várias validações integradas disponíveis. Aqui estão alguns exemplos de validações que você pode aplicar:

- Garantir que um campo esteja vazio ou não vazio
- Garantir que um campo contenha um valor exclusivo
- Garantir o comprimento de um campo
- Garantir que um campo seja um valor numérico
- Garantir que um campo corresponda a uma expressão regular
- Implementar funções de validação personalizadas (*o céu é o limite, ou quase*)

Após aplicar as validações, você pode chamar os métodos `.valid?` e `.invalid?` no modelo para realizar as validações e gerar mensagens de erro, que podem ser acessadas no modelo. A chamada também executará as validações e gerará mensagens de erro. Ela retornará `falso` se a operação não for bem-sucedido. Você pode aprender mais sobre validações no [Guia de Validações do ActiveRecord](https://guides.rubyonrails.org/active_record_validations.html).

Aqui está um exemplo de modelo de usuário com algumas validações e como verificar erros:

```ruby
# ./models/user.rb

class User < ActiveRecord::Base

  # ...

  # Garantir que um campo esteja vazio
  validates_absence_of :admin

  # Garantir que os campos de nome e idade estejam presentes
  validates_presence_of :name, :age
  
  # Usar uma expressão regular para limitar os valores do campo
  validates_format_of :name, with: /\A[a-zA-Z]+\z/, message: "Apenas letras são permitidas"
  
  # Garantir um comprimento mínimo e máximo
  validates_length_of :name, minimum: 2, maximum: 64
  
  # Outra forma de especificar o comprimento
  validates_length_of :name, in: 2..64

  # Garantir que um valor tenha um comprimento específico
  validates_length_of :credit_card, is: 16

  # Garantir que um campo seja único
  validates_uniqueness_of :email

  # Garantir que o valor corresponda a um conjunto específico
  validates_inclusion_of :tshirt_size, in: %w(PP P M G GG XG), message: "Tamanho de camiseta inválido: %{value}"

  # Garantir que o valor seja de um tipo específico
  validates_numericality_of :age, only_integer: true
  
  # ...
end
```

```ruby
# ./examples/validating_records.rb

usuario = User.new
usuario.email = 'test'
usuario.admin = 1
usuario.name = "Ernane123"
usuario.age = 50.5
usuario.tshirt_size = 'XM'

# Alternativamente, use `.valid?` ou `.invalid?` para gerar erros
unless usuario.save
  usuario.errors.messages.each do |field, messages|
    puts "#{field}: #{messages}"
  end
end
```

Este exemplo garantirá que os dados inseridos no objeto de usuário atendam aos critérios de validação definidos no modelo. Se houver algum erro de validação, ele será exibido na saída.

### Transações em Bancos de Dados

O uso de transações em bancos de dados permite executar várias operações de forma segura, garantindo que todas sejam realizadas ou nenhuma delas seja concluída. Por exemplo, ao realizar operações complexas que envolvem múltiplas atualizações ou inserções, é crucial garantir a integridade do banco de dados, evitando estados inconsistentes.

Você pode criar e executar transações em blocos de código utilizando o método `transaction` fornecido pelo `ActiveRecord`. Veja um exemplo:

```ruby
# ./examples/testing_transactions.rb

# Exemplo 1: 
# - Deve tentar mudar o nome e funcionar. 
# - Deve tentar mudar a idade e deve falhar pois o valor tem que ser inteiro (validação presente no modelo). 
# - Como falhou, as alterações já realizadas, mesmo que em sucesso, serão revertidas.

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

# Exemplo 2: 
# - Deve tentar mudar o nome e idade e funcionar. 
# - Como não falhou, as alterações persistem.

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
```

Dentro do bloco de transação, você pode capturar exceções para tratamento específico ou para permitir que a transação continue. Se necessário, você pode relançar exceções para sair da transação.

Além disso, você não está limitado a operar apenas no modelo associado ao bloco de transação. Você pode chamar o método `transaction` em qualquer modelo ou instância de modelo para iniciar uma transação específica para aquele objeto.

O uso de transações é essencial para garantir a integridade e consistência dos dados em aplicações que envolvem operações críticas no banco de dados.

### Relacionamentos

Associar modelos uns aos outros é um aspecto fundamental do `ActiveRecord`. Estes incluem relacionamentos como `um para um`, `um para muitos` e `muitos para muitos`.

Os relacionamentos disponíveis entre os modelos são:

- pertence a (`belongs_to`)
- tem um (`has_one`)
- tem muitos (`has_many`)
- tem muitos através de (`has_many :through`)
- tem um através de (`has_one :through`)
- tem e pertence a muitos (`has_and_belongs_to_many`)

Há uma espécie de 'mágica' ✨ que acontece quando se trata da nomeação de tabelas. Você pode substituir os nomes das tabelas e os nomes das colunas de chave estrangeira, mas é recomendado seguir as convenções para evitar configurações extras. Por exemplo, se um `Perfil` pertence a um `Usuário`, ele assume que existem tabelas de usuários e perfis, e a tabela de perfis terá uma coluna `user_id`.

Tabelas de ligação para relacionamentos `muitos para muitos` usam o nome de ambos os modelos em ordem alfabética. Por exemplo, se um **Usuário** tem um relacionamento muitos para muitos com um **Departamento**, então a tabela de ligação é esperada para ser nomeada `departments_users` e conter colunas `user_id` e `department_id` que fazem referência às tabelas denominadas `departments` e `users`.

Neste exemplo, preste atenção especial à singularidade ou pluralidade das palavras usadas nos nomes dos modelos, nomes dos relacionamentos e nomes das tabelas do banco de dados. Ao usar um relacionamento `has_and_belongs_to_many`, a tabela de ligação usa plurais de ambos os nomes em ordem alfabética.

> Nessa etapa será necessário criar novas tabelas para que o exemplo funcione pois precisamos de mais tabelas para relacionar. Dessa forma, você pode se aventurar criando-as manualmente ou executar a migration presente [aqui](https://github.com/ErnaneJ/ruby-and-activerecord/blob/main/database/migrations/create_profiles_posts_and_departments_tables.rb).

```ruby
# ./models/user.rb
class User < ActiveRecord::Base
  has_one :profile
  has_many :posts
  has_and_belongs_to_many :departments
end
```

```ruby
# ./models/post.rb
class Post < ActiveRecord::Base
  belongs_to :user
end
```

```ruby
# ./models/profile.rb
class Profile < ActiveRecord::Base
  belongs_to :user
end
```

```ruby
# ./models/department.rb
class Department < ActiveRecord::Base
  has_and_belongs_to_many :users
end
```

Dessa forma, podemos realizar as seguintes execuções:

```ruby
# main.rb
usuario = User.create(name: 'Ernane')

# Algumas maneiras de criar o perfil para o usuário:
Profile.create(bio: 'ErnaneJ', user: usuario)
usuario.profile = Profile.create(bio: 'Hello World! :)')
usuario.create_profile(bio: 'Hello World! :)')

# Algumas maneiras de adicionar um post ao usuário (relacionamento um para muitos)
usuario.posts.create(content: 'Post de exemplo')
Post.create(content: 'Outro post', user: usuario)
usuario.posts.append(Post.create(content: 'Um terceiro post'))

# Criar os clãs e relacionamentos (relacionamento muitos para muitos)
usuario.clans.create(name: 'Belgian ROFLs')
Clan.create(name: 'Hax0rs', users: [usuario])
usuario.clans.append(Clan.create(name: 'Lone Rangers'))

# Obtendo os objetos relacionados
usuario = User.find_by_name('Ernane')
puts usuario.inspect
puts usuario.profile.inspect
puts usuario.post_ids.inspect
puts usuario.posts.inspect
puts usuario.clan_ids.inspect
puts usuario.clans.inspect
```

Você pode ler mais sobre associações acessando o [Guides](https://guides.rubyonrails.org/association_basics.html).

### Migrações

Para evitar a necessidade de escrever instruções SQL para criar, modificar e destruir esquemas de banco de dados, o ActiveRecord fornece um mecanismo para realizar migrações. Isso permite que você escreva código Ruby para especificar como deve ser a estrutura do banco de dados sem escrever SQL bruto.

Existem alguns benefícios nisso. Por exemplo, como comentado anteriormente, você pode usar a mesma migração para criar o esquema de banco de dados para SQLite, MySQL e PostgreSQL, mesmo que as instruções SQL reais possam variar de banco de dados para banco de dados. Ele também permite que você execute atualizações, desmonte e reconstrua facilmente um banco de dados apenas executando os scripts de migração Ruby, que por sua vez podem ser configurados em um `Rakefile` por conveniência.

#### Métodos Disponíveis

Ao definir classes de migração, estes são alguns dos métodos disponíveis que você pode usar para executar operações de banco de dados. Você pode ler mais sobre os métodos disponíveis [aqui](https://api.rubyonrails.org/classes/ActiveRecord/Migration.html).

- `create_table()`
- `change_table()`
- `rename_table()`
- `drop_table()`
- `create_join_table()`
- `drop_join_table()`
- `add_column()`
- `change_column()`
- `change_column_default()`
- `change_column_null()` *(permitir/proibir nulo)*
- `rename_column()`
- `remove_column()`
- `remove_columns()`
- `add_timestamps()` *(created_at e updated_at)*
- `remove_timestamps()`
- `add_foreign_key()`
- `remove_foreign_key()`
- `add_index()`
- `rename_index()`
- `remove_index()`
- `add_reference()`
- `remove_reference()`

#### Diferença Entre CHANGE() e UP()/DOWN()

No início, pode ser um pouco confuso entender a necessidade desses dois métodos e você também pode estar se perguntando. Basicamente, se você definir migrações usando o método `change`, ele determinará automaticamente o que precisa ser feito para que as migrações `up` e `down` executem ou desfaçam as ações especificadas.

Se quiser especificar uma ação que funcione apenas em uma direção ou ter mais controle, você poderá definir explicitamente os métodos `.up` e `.down`. Eu usaria o padrão, `change`, a menos que você tenha alguma necessidade especial.

#### Criar e Eliminar Tabelas

Este exemplo mostra como fazer uma migração simples que criará uma tabela chamada `users` com alguns campos: `name`, `age`, `created_at` e `updated_at`.

Chame o método `migrate` da classe de migração para atualizar o banco de dados. Você deve fornecer uma direção (`:up` ou `:down`) para especificar se deseja executar as alterações ou desfazê-las. Ele determinará automaticamente quais instruções precisam ser executadas para realizar cada ação.

```ruby
class CreateUserTable < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |table|
      table.string :name
      table.integer :age
      table.timestamps
    end
  end
end

# Criar a tabela
CreateUserTable.migrate(:up)

# Eliminar a tabela
CreateUserTable.migrate(:down)
```

### Usando no IRB

Ao usar o Ruby on Rails, você pode acessar o console do Rails com o comando `rails console` para entrar em um ambiente interativo que permite consultar e manipular seus modelos `ActiveRecord`. No entanto, se você estiver fora do ambiente Rails, precisará requerer os módulos Ruby onde seus modelos estão definidos.

Você pode usar o argumento `-r` para exigir os módulos desejados na inicialização do IRB. Isso economiza tempo, pois você não precisa digitar os comandos `require` manualmente dentro do interpretador.

```bash
irb -r ./models
```

Dessa forma, você pode iniciar o IRB com seus módulos já importados e prontos para uso.

Alternativamente, como dito, você pode importar manualmente os módulos dentro do IRB digitando os comandos `require`. No entanto, criar um script com os comandos de `require` economiza tempo e esforço. Uma vez dentro do IRB, você pode usar seus modelos como de costume:

```ruby
$ irb
irb(main):001> require "./configurations/initializer.rb"
# => true
irb(main):002> require "./models/user.rb"
# => true
irb(main):003> User
# => User (call 'User.connection' to establish a connection)
irb(main):004> User.last
# => #<User:0x000000010bdb0630 ...> 
```

Isso permite que você execute consultas e manipulações em seus modelos `ActiveRecord` diretamente do console interativo.

## Conclusão 🎉

Após absorver este tutorial, você agora possui um entendimento sólido dos fundamentos do `ActiveRecord`. Agora, você deve se sentir confiante para instalar o `ActiveRecord`, explorar sua documentação e começar a utilizá-lo em seus projetos Ruby.

Aqui está um resumo do que foi aprendido:

- Instalação e configuração inicial do ActiveRecord;
- Definição de modelos e relacionamentos entre eles;
- Execução de consultas para recuperar dados do banco de dados;
- Criação e manipulação de registros no banco de dados;
- Utilização de retornos de chamada para executar ações automáticas em modelos;
- Realização de transações para garantir que várias operações de banco de dados sejam executadas com sucesso ou revertidas em caso de erro;
- Criação e execução de migrações para gerenciar o esquema do banco de dados de forma programática;
- Utilização do ActiveRecord em uma sessão interativa no IRB ou Pry.

Com esses conhecimentos, você está pronto para aproveitar ao máximo o ActiveRecord em seus projetos Ruby, facilitando o trabalho com bancos de dados e simplificando o desenvolvimento de aplicativos web. Lembre-se de continuar explorando a documentação oficial e praticar com exemplos do mundo real para aprimorar suas habilidades. 🚀

O [repositório](https://github.com/ErnaneJ/ruby-and-activerecord/) com os exemplos mencionados neste post está disponível e totalmente aberto a contribuições. Além disso, esta publicação também. Sinta-se à vontade!

Espero que tenha gostado dessa postagem e que ela tenha te ajudado, de alguma forma, a encontrar ou que você procurava! 💙
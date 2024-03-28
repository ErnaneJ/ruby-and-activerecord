# ./models/user.rb
class User < ActiveRecord::Base
  has_one :profile
  has_many :posts
  has_and_belongs_to_many :departments
  
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

  # Garantir que um campo seja único
  validates_uniqueness_of :email

  # Garantir que o valor corresponda a um conjunto específico
  validates_inclusion_of :tshirt_size, in: %w(PP P M G GG XG), message: "Tamanho de camiseta inválido: %{value}"

  # Garantir que um número seja fornecido
  validates_numericality_of :age, only_integer: true

  before_create :before_create_callback
  def before_create_callback
    puts "Prestes a criar o usuário: #{self.name}"
  end
  
  after_create :after_create_callback
  def after_create_callback
    puts "Novo objeto de usuário criado: #{self.name}"
  end
end

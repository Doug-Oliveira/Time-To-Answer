namespace :dev do

DEFAULT_PASSWORD = 123456
DEFAULT_FILES_PATH = File.join(Rails.root, 'lib', 'tmp')


  desc "Configura o ambiente de Dev"
  task setup: :environment do
#as {} abaixo tambem podem ser substituidas por do end, foi usado {} porque so tem uma linha de código
  if Rails.env.development?
    show_spinner("Apagando BD") {%x(rails db:drop)}
    show_spinner("Criando BD") {%x(rails db:create)}
    show_spinner("Migrando BD") {%x(rails db:migrate)}
    show_spinner("Cadastrado Default Admin") {%x(rails dev:add_default_admin)}
    show_spinner("Cadastrado novos administradores") {%x(rails dev:add_extra_admin)}
    show_spinner("Cadastrado Default User") {%x(rails dev:add_default_user)}
    show_spinner("Cadastrado Assuntos padrões") {%x(rails dev:add_subjects)}
    show_spinner("Cadastrado questões e respostas") {%x(rails dev:add_answer_and_questions)}

    #%x(rails dev:add_mining_types)
  else
  puts "!--Você não esta em Ambiente de Desenvolvimento--!"
    end
  end

  desc "Adiciona o admin padrão"
  task add_default_admin: :environment do
    10.times do
      Admin.create!(
        email: Faker::Internet.email,
        password: DEFAULT_PASSWORD,
        password_confirmation: DEFAULT_PASSWORD
      )
    end
  end

  desc "Cadastrado Assuntos padrões"
  task add_subjects: :environment do
    file_name = 'subjects.txt'
    file_path = File.join(DEFAULT_FILES_PATH, file_name)
    #o 'r' vai abrir o arquivo como somente leitura (read)
    File.open(file_path, 'r').each do |line|
      Subject.create(description: line.strip)
    end
  end

  desc "Cadastrado Perguntas e repostas"
  task add_answer_and_questions: :environment do
    Subject.all.each do |subject|
      rand(5..10).times do |i|
        params = create_question_params(subject)
        answer_array = params[:question][:answers_attributes]
        
        add_answers(answer_array)
        elect_true_answer(answer_array)
        
        Question.create!(params[:question])
      end
    end
  end

  desc "Adiciona admin extra"
  task add_extra_admin: :environment do
      Admin.create!(
        email: 'admin@admin.com',
        password: DEFAULT_PASSWORD,
        password_confirmation: DEFAULT_PASSWORD
      )
  end

  desc "Adiciona o user padrão"
  task add_default_user: :environment do
      User.create!(
        email: 'user@user.com',
        password: DEFAULT_PASSWORD,
        password_confirmation: DEFAULT_PASSWORD
      )
  end

  private
  def show_spinner(msg_start, msg_end = "Concluido com sucesso!!")
    spinner = TTY::Spinner.new("[:spinner] #{msg_start} ...")
    spinner.auto_spin
    yield
    spinner.success("(#{msg_end})")
  end

  def create_question_params(subject = Subject.all.sample)
    {question: { description: "#{Faker::Lorem.paragraph} #{Faker::Lorem.question}", 
        subject: subject,
        answers_attributes: []}}
  end

  def create_answer_params(correct = false)
    {description: Faker::Lorem.sentence, correct: correct}
  end

  def add_answers(answer_array = [])
    rand(2..5).times do |j|
      answer_array.push(create_answer_params)
    end
  end

  def elect_true_answer(answer_array = [])
    selected_index = rand(answer_array.size)
    answer_array[selected_index] = create_answer_params(true)
  end
end

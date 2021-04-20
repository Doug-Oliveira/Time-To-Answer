namespace :dev do

DEFAULT_PASSWORD = 123456

  desc "Configura o ambiente de Dev"
  task setup: :environment do
#as {} abaixo tambem podem ser substituidas por do end, foi usado {} porque so tem uma linha de código
  if Rails.env.development?
    show_spinner("Apagando BD") {%x(rails db:drop)}
    show_spinner("Criando BD") {%x(rails db:create)}
    show_spinner("Migrando BD") {%x(rails db:migrate)}
    show_spinner("Cadastrado Default Admin") {%x(rails dev:add_default_admin)}
    show_spinner("Cadastrado Default User") {%x(rails dev:add_default_user)}
    #%x(rails dev:add_mining_types)
  else
  puts "!--Você não esta em Ambiente de Desenvolvimento--!"
    end
  end

  desc "Adiciona o admin padrão"
  task add_default_admin: :environment do
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
end

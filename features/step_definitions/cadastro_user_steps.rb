#encoding: utf-8

#Cenario 1
Dado("que eu acesse o sistema da jeasyui") do
    @lista_user = ListaUserPage.new
    @lista_user.load
  end
  
  Quando("tento criar um novo usuario sem preencher os dados") do
    @lista_user.clicar_add_novo_user
    @cadastro_user = CadastroUserPage.new
    @cadastro_user.clicar_save_user
  end
  
  Entao("o sistema nao deve permitir o cadastro") do
  end

  E ("os campos obrigatorios terao que estar em vermelho") do
  end

  #Cenario 2
  Quando("eu tento criar um novo usuario preenchendo o email {string}") do |string|
    @lista_user.clicar_add_novo_user
    @cadastro_user = CadastroUserPage.new
    @cadastro_user.preencher_dados_user(
      campo_first_name: 'Vitor',
      campo_last_name: 'Santana',
      campo_phone: '+5571999999999',
      campo_email: string
    )
    @cadastro_user.clicar_save_user
  end

  E("me indica que o email esta invalido") do
  end

  #Cenario 3
  Quando("eu informo os seguintes dados do usuario:") do |table|
    @lista_user.clicar_add_novo_user
    @cadastro_user = CadastroUserPage.new    
    @usuario = table.rows_hash
  end
  
  E("realizo o cadastro") do
    @cadastro_user.preencher_dados_user(
      campo_first_name: @usuario[:firstname],
      campo_last_name: @usuario[:lastname],
      campo_phone: @usuario[:phone],
      campo_email: @usuario[:email]
    )
    @cadastro_user.clicar_save_user
  end

  Entao("o sistema deve me mostrar o usuario na lista") do
    
  end
#encoding: utf-8

  Dado("que eu acesse o sistema da jeasyui") do
    @lista_user = ListaUserPage.new
    @lista_user.load
  end

  Quando("eu tento cadastrar um user sem o firstname") do
    @lista_user.clicar_add_novo_user
    @cadastro_user = CadastroUserPage.new
    @cadastro_user.preencher_dados_user(
      campo_first_name: '',
      campo_last_name: 'Santana',
      campo_phone: '+5571999999999',
      campo_email: 'vitor@email.com'
    )
    @cadastro_user.clicar_save_user
  end
  
  Quando("eu tento cadastrar um user sem o lastname") do
    @lista_user.clicar_add_novo_user
    @cadastro_user = CadastroUserPage.new
    @cadastro_user.preencher_dados_user(
      campo_first_name: 'Vitor',
      campo_last_name: '',
      campo_phone: '+5571999999999',
      campo_email: 'vitor@email.com'
    )
    @cadastro_user.clicar_save_user
  end
  
  Quando("eu tento cadastrar um user sem o phone") do
    @lista_user.clicar_add_novo_user
    @cadastro_user = CadastroUserPage.new
    @cadastro_user.preencher_dados_user(
      campo_first_name: 'Vitor',
      campo_last_name: 'Santana',
      campo_phone: '',
      campo_email: 'vitor@email.com'
    )
    @cadastro_user.clicar_save_user
  end
  
  Quando("eu tento cadastrar um user sem o email") do
    @lista_user.clicar_add_novo_user
    @cadastro_user = CadastroUserPage.new
    @cadastro_user.preencher_dados_user(
      campo_first_name: 'Vitor',
      campo_last_name: 'Santana',
      campo_phone: '+5571999999999',
      campo_email: ''
    )
    @cadastro_user.clicar_save_user
  end
  
  
  Entao("o sistema nao deve permitir o cadastro") do
    expect(@cadastro_user).to have_css('#_easyui_textbox_input1')
    expect(@cadastro_user).to have_css('#_easyui_textbox_input2')
    expect(@cadastro_user).to have_css('#_easyui_textbox_input3')
    expect(@cadastro_user).to have_css('#_easyui_textbox_input4')
    expect(@cadastro_user).to have_xpath('//div[@id="dlg-buttons"]/a[1]')
    expect(@cadastro_user).to have_xpath('//div[@id="dlg-buttons"]/a[2]')
    expect(@cadastro_user).to have_text('This field is required.')
  end

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

  Entao ("sera indicado que o email e invalido") do
    expect(@cadastro_user).to have_text('Please enter a valid email address.')
  end

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
    @lista_user = ListaUserPage.new
    @lista_user.selecionar_num_paginacao('999')
    @lista_user.selecionar_num_registros('50')
    expect(@cadastro_user).to have_text('Vitor')
    expect(@cadastro_user).to have_text('Santana')
    expect(@cadastro_user).to have_text('993962991')
    expect(@cadastro_user).to have_text('imavvitorsantana@email.com')
  end
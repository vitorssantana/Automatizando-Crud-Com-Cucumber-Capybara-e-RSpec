#encoding: utf-8

  Before ('@first_scenario') do
    # Criar user somente pra esse teste
  end

  Quando("eu tento editar um user com firstname em branco") do
    @lista_user = ListaUserPage.new
    @lista_user.selecionar_user_na_lista( 'Vitor', 'Santana')
    @lista_user.clicar_edit_novo_user

    @edicao_user = EdicaoUserPage.new
    @edicao_user.preencher_dados_user(
      campo_first_name: '',
      campo_last_name: 'Silva',
      campo_phone: '88888888',
      campo_email: 'souzasilva@email.com'
    )
    @edicao_user.clicar_save_user
  end
  
  Quando("eu tento editar um user com lastname em branco") do
    @lista_user.selecionar_user_na_lista(
      'Vitor', 'Santana'
    )
    @lista_user.clicar_edit_novo_user

    @edicao_user = EdicaoUserPage.new
    @edicao_user.preencher_dados_user(
      campo_first_name: 'Souza',
      campo_last_name: '',
      campo_phone: '88888888',
      campo_email: 'souzasilva@email.com'
    )
    @edicao_user.clicar_save_user
  end
  
  Quando("eu tento editar um user com phone em branco") do
    @lista_user.selecionar_user_na_lista(
      'Vitor', 'Santana'
    )
    @lista_user.clicar_edit_novo_user

    @edicao_user = EdicaoUserPage.new
    @edicao_user.preencher_dados_user(
      campo_first_name: 'Souza',
      campo_last_name: 'Silva',
      campo_phone: '',
      campo_email: 'souzasilva@email.com'
    )
    @edicao_user.clicar_save_user
  end
  
  Quando("eu tento editar um user com email em branco") do
    @lista_user.selecionar_user_na_lista(
      'Vitor', 'Santana'
    )
    @lista_user.clicar_edit_novo_user

    @edicao_user = EdicaoUserPage.new
    @edicao_user.preencher_dados_user(
      campo_first_name: 'Souza',
      campo_last_name: 'Silva',
      campo_phone: '88888888',
      campo_email: ''
    )
    @edicao_user.clicar_save_user
  end
  
  Quando("eu tento editar o user pondo email {string} invalido") do |string|
    @lista_user.selecionar_user_na_lista(
      'Vitor', 'Santana'
    )
    @lista_user.clicar_edit_novo_user
    @edicao_user = EdicaoUserPage.new
    @edicao_user.preencher_dados_user(
      campo_first_name: 'Vitor',
      campo_last_name: 'Santana',
      campo_phone: '+5571999999999',
      campo_email: string
    )
    @edicao_user.clicar_save_user
  end
  
  Quando("eu altero os dados do user por estes:") do |table|
    @lista_user.selecionar_user_na_lista(
      'Vitor', 'Santana'
    )
    @lista_user.clicar_edit_novo_user
    @edicao_user = EdicaoUserPage.new
    @usuario = table.rows_hash
    @edicao_user.preencher_dados_user(
      campo_first_name: @usuario[:firstname],
      campo_last_name: @usuario[:lastname],
      campo_phone: @usuario[:phone],
      campo_email: @usuario[:email]
    )

  end

  E("realizo a alteracao") do
    @edicao_user.clicar_save_user
  end
  
  Entao ("o sistema nao deve permitir a edicao") do
    expect(@edicao_user).to have_css('#_easyui_textbox_input1')
    expect(@edicao_user).to have_css('#_easyui_textbox_input2')
    expect(@edicao_user).to have_css('#_easyui_textbox_input3')
    expect(@edicao_user).to have_css('#_easyui_textbox_input4')
    expect(@edicao_user).to have_xpath('//div[@id="dlg-buttons"]/a[1]')
    expect(@edicao_user).to have_xpath('//div[@id="dlg-buttons"]/a[2]')
    expect(@edicao_user).to have_text('This field is required.')
    
  end

  Entao("o sistema deve me mostrar os novos dados na lista") do
    @lista_user = ListaUserPage.new
    @lista_user.selecionar_num_paginacao('999')
    @lista_user.selecionar_num_registros('50')
    expect(@lista_user).to have_text('Souza')
    expect(@lista_user).to have_text('Silva')
    expect(@lista_user).to have_text('88888888')
    expect(@lista_user).to have_text('souzasilva@email.com')
  end
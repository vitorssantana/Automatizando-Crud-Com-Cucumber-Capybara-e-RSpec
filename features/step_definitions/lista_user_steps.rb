  Before  ('@second_scenario_lista_user') do
    @lista_user = ListaUserPage.new
    @lista_user.load
    @lista_user.clicar_add_novo_user

    @cadastro_user = CadastroUserPage.new
    @cadastro_user.preencher_dados_user(
        campo_first_name: 'Teste',
        campo_last_name: 'Lista',
        campo_phone: '88888888',
        campo_email: 'testelista@email.com'
    )
    @cadastro_user.clicar_save_user
  end
  
  Quando("eu quiser criar um novo user") do
    @lista_user.clicar_add_novo_user
  end
  
  Entao("o sistema me exibe o modal de cadastro de user") do
    @cadastro_user = CadastroUserPage.new
    expect(@cadastro_user).to have_css('#_easyui_textbox_input1')
    expect(@cadastro_user).to have_css('#_easyui_textbox_input2')
    expect(@cadastro_user).to have_css('#_easyui_textbox_input3')
    expect(@cadastro_user).to have_css('#_easyui_textbox_input4')
    expect(@cadastro_user).to have_xpath('//div[@id="dlg-buttons"]/a[1]')
    expect(@cadastro_user).to have_xpath('//div[@id="dlg-buttons"]/a[2]')
  end
  
  Quando("eu escolho editar user sem seleciona-lo") do
    @lista_user.clicar_edit_novo_user
  end
  
  Entao("o sistema continua exibindo a listagem") do
    expect(@lista_user). to have_xpath('//div[@id="toolbar"]/a[1]')
    expect(@lista_user). to have_xpath('//div[@id="toolbar"]/a[2]')
    expect(@lista_user). to have_xpath('//div[@id="toolbar"]/a[3]')
    expect(@lista_user). to have_xpath('//select[@class="pagination-page-list"]')
    expect(@lista_user). to have_xpath('//input[@class="pagination-num"]')
    expect(@lista_user).to have_xpath('//tr[contains(@id, "dg_datagrid-row-r1-2-")]', count: 10)
  end
  
  Quando("eu escolho editar user o selecionando antes") do
    @lista_user.selecionar_num_paginacao('999')
    @lista_user.selecionar_num_registros('50')
    @lista_user.selecionar_user_na_lista('Teste', 'Lista')
    @lista_user.clicar_edit_novo_user
  end
  
  Entao("o sistema me exibe o modal de edicao de user") do
    @edicao_user = EdicaoUserPage.new
    expect(@edicao_user).to have_css('#_easyui_textbox_input1')
    expect(@edicao_user).to have_css('#_easyui_textbox_input2')
    expect(@edicao_user).to have_css('#_easyui_textbox_input3')
    expect(@edicao_user).to have_css('#_easyui_textbox_input4')
    expect(@edicao_user).to have_xpath('//div[@id="dlg-buttons"]/a[1]')
    expect(@edicao_user).to have_xpath('//div[@id="dlg-buttons"]/a[2]')
  end
  
  Quando("eu escolho remover user sem seleciona-lo") do
    @lista_user.clicar_remove_user
  end
  
  Quando("eu escolho remover user o selecionando antes") do
    @lista_user.selecionar_num_paginacao('999')
    @lista_user.selecionar_num_registros('50')
    @lista_user.selecionar_user_na_lista('Teste', 'Lista')
    @lista_user.clicar_remove_user
  end
  
  Entao("o sistema solicita a confirmacao de remocao") do
    @remocao_user = RemocaoUserPage.new
    expect(@remocao_user).to have_text('Are you sure you want to destroy this user?')
    expect(@remocao_user).to have_xpath('//div[@class="dialog-button messager-button"]/a[1]')
    expect(@remocao_user).to have_xpath('//div[@class="dialog-button messager-button"]/a[2]')
  end
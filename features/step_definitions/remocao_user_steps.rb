
 Before ('@first_scenario') do
    @lista_user = ListaUserPage.new
    @lista_user.load
    @lista_user.clicar_add_novo_user

    @cadastro_user = CadastroUserPage.new
    @cadastro_user.preencher_dados_user(      
        campo_first_name: 'Teste3',
        campo_last_name: 'Remocao3',
        campo_phone: '+5571999999999',
        campo_email: 'testeremocao@email.com')
    @cadastro_user.clicar_save_user    
 end
 
 E ("selecionei um usuario para remocao") do
    @lista_user.load
    @lista_user.selecionar_num_paginacao('999')
    @lista_user.selecionar_num_registros('50')
    @lista_user.selecionar_user_na_lista('Teste3', 'Remocao3')
    @lista_user.clicar_remove_user
    @remocao_user = RemocaoUserPage.new
  end

  Quando("eu desisto de remover o usuario") do
    @remocao_user.clicar_cancel
  end
  
  Entao("o sistema deve exibir o user na lista") do
    @lista_user.selecionar_num_paginacao('999')
    @lista_user.selecionar_num_registros('50')
    expect(@lista_user).to have_text('Teste3')
    expect(@lista_user).to have_text('Remocao3')
  end
  
  Quando("eu confirmar a remocao") do
    @remocao_user.clicar_ok
  end
  
  Entao("o sistema nao deve exibir mais o user na lista") do
    @lista_user.selecionar_num_paginacao('999')
    @lista_user.selecionar_num_registros('50')
    expect(@lista_user).not_to have_text('Teste3')
    expect(@lista_user).not_to have_text('Remocao3')
  end
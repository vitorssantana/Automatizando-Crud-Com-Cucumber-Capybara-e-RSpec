
#encoding: utf-8

  Quando("eu tento editar um user com firstname em branco") do
    @lista_user = ListaUserPage.new
    @lista_user.selecionar_user_na_lista(
      'Vitor', 'Santana', '+5571999999999', 'vitor@email.com'
    )
    @lista_user.clicar_edit_novo_user
    

  end
  
  Quando("eu tento editar um user com lastname em branco") do
  end
  
  Quando("eu tento editar um user com phone em branco") do
  end
  
  Quando("eu tento editar um user com email em branco") do
  end
  
  Quando("eu tento editar o user pondo email {string} invalido") do |string|
  end
  
  Quando("eu altero os dados do user por estes:") do |table|
  end
  
  Quando("realizo a alteracao") do
  end

  E("realizo a alteracao") do
  end
  
  Entao ("o sistema nao deve permitir a edicao") do
    
  end

  Entao("o sistema deve me mostrar os novos dados na lista") do
  end
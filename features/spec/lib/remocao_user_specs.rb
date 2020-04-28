# frozen_string_literal: true

require_relative '../spec_helper'
require_relative '../../pages/lista_user_page'
require_relative '../../pages/cadastro_user_page'
require_relative '../../pages/remocao_user_page'

describe RemocaoUserPage do
  let(:lista_user) { ListaUserPage.new }
  let(:cadastro_user) { CadastroUserPage.new }

  before :all do
    lista_user = ListaUserPage.new
    lista_user.load
    lista_user.clicar_add_novo_user
    cadastro_user = CadastroUserPage.new
    cadastro_user.preencher_dados_user(
      campo_first_name: 'Teste4',
      campo_last_name: 'Remocao4',
      campo_phone: '+5571999999999',
      campo_email: 'testeremocao@email.com')
    cadastro_user.clicar_save_user
  end

  context 'quando cancelar a remocao' do
    it 'entao o sistema nao exclui user da lista' do
      lista_user.selecionar_num_paginacao('999')
      lista_user.selecionar_num_registros('50')
      lista_user.selecionar_user_na_lista('Teste4', 'Remocao4')
      lista_user.clicar_remove_user
      remocao_user.clicar_cancel
      lista_user.selecionar_num_paginacao('999')
      lista_user.selecionar_num_registros('50')
      expect(page).to have_text('Teste4')
      expect(page).to have_text('Remocao4')
    end
  end

  context 'quando confirmar a remocao' do
    it 'entao o sistema exclui user da lista' do
      lista_user.load
      lista_user.selecionar_num_paginacao('999')
      lista_user.selecionar_num_registros('50')
      lista_user.selecionar_user_na_lista('Teste4', 'Remocao4')
      lista_user.clicar_remove_user
      remocao_user.clicar_ok
      lista_user.selecionar_num_paginacao('999')
      lista_user.selecionar_num_registros('50')
      expect(page).not_to have_text('Teste4')
      expect(page).not_to have_text('Remocao4')
    end
  end
end
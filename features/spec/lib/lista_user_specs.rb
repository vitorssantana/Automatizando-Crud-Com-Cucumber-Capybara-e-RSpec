# frozen_string_literal: true

require_relative '../spec_helper'
require_relative '../../pages/lista_user_page'
require_relative '../../pages/cadastro_user_page'
require_relative '../../pages/remocao_user_page'
require_relative '../../pages/edicao_user_page'

describe ListaUserPage do
  let(:lista_user) { ListaUserPage.new }
  let(:cadastro_user) { CadastroUserPage.new }

  before :all do
    lista_user = ListaUserPage.new
    lista_user.load
    lista_user.clicar_add_novo_user
    cadastro_user = CadastroUserPage.new
    cadastro_user.preencher_dados_user(
      campo_first_name: 'Teste',
      campo_last_name: 'Lista',
      campo_phone: '88888888',
      campo_email: 'testelista@email.com'
    )
    cadastro_user.clicar_save_user
  end

  before do
    lista_user.load
  end

  shared_examples 'o modal de cadastro/edicao' do
    it 'o modal de cadastro/edicao aparecera' do
      expect(page).to have_css('#_easyui_textbox_input1')
      expect(page).to have_css('#_easyui_textbox_input2')
      expect(page).to have_css('#_easyui_textbox_input3')
      expect(page).to have_css('#_easyui_textbox_input4')
      expect(page).to have_xpath('//div[@id="dlg-buttons"]/a[1]')
      expect(page).to have_xpath('//div[@id="dlg-buttons"]/a[2]')
    end
  end

  shared_examples 'a tela de lista do jeasyui' do
    it 'A tela de lista continua aparecendo' do
      expect(page).to have_xpath('//div[@id="toolbar"]/a[1]')
      expect(page).to have_xpath('//div[@id="toolbar"]/a[2]')
      expect(page).to have_xpath('//div[@id="toolbar"]/a[3]')
      expect(page).to have_xpath('//select[@class="pagination-page-list"]')
      expect(page).to have_xpath('//input[@class="pagination-num"]')
      expect(page).to have_xpath('//tr[contains(@id, "dg_datagrid-row-r1-2-")]', count: 10)
    end
  end

  context 'Quando eu quiser cadastrar novo user' do
    let!(:lista_user_page) { lista_user.clicar_add_novo_user }
    it_behaves_like 'o modal de cadastro/edicao'
  end

  context 'Quando eu quiser editar user' do
    context 'Se eu tiver selecionado user' do
      let!(:lista_user_page) {
        lista_user.selecionar_num_paginacao('999')
        lista_user.selecionar_num_registros('50')
        lista_user.selecionar_user_na_lista('Teste', 'Lista')
        lista_user.clicar_edit_novo_user
      }
      it_behaves_like 'o modal de cadastro/edicao'
    end

    context 'Se eu nao tiver selecionado user' do
      it_behaves_like 'a tela de lista do jeasyui'
    end
  end

  context 'Quando eu quiser remover user' do
    context 'Se eu tiver selecionado anteriormente' do
      it 'Sera solicitado confirmacao de remocao' do
        lista_user.selecionar_num_paginacao('999')
        lista_user.selecionar_num_registros('50')
        lista_user.selecionar_user_na_lista('Teste', 'Lista')
        lista_user.clicar_remove_user
        expect(page).to have_text('Are you sure you want to destroy this user?')
        expect(page).to have_xpath('//div[@class="dialog-button messager-button"]/a[1]')
        expect(page).to have_xpath('//div[@class="dialog-button messager-button"]/a[2]')
      end
    end

    context 'Se eu nao tiver selecionado user anteriormente' do
      let!(:lista_user_page) { lista_user.clicar_remove_user }
      it_behaves_like 'a tela de lista do jeasyui'
    end
  end
end
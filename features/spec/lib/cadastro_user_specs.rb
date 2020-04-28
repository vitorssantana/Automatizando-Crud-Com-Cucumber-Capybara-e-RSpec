# frozen_string_literal: true

require_relative '../spec_helper'
require_relative '../../pages/lista_user_page'
require_relative '../../pages/cadastro_user_page'

describe CadastroUserPage do
  let(:lista_user) { ListaUserPage.new }
  let(:cadastro_user) { CadastroUserPage.new }

  before do
    lista_user.load
    lista_user.clicar_add_novo_user
  end

  def preencher_dados_usuarios(firstname, lastname, phone, email)
    cadastro_user.preencher_dados_user(
      campo_first_name: firstname,
      campo_last_name: lastname,
      campo_phone: phone,
      campo_email: email
    )
    cadastro_user.clicar_save_user
  end

  shared_examples 'o modal continua na tela' do |firstname, lastname, phone, email|
    it 'o modal continua na tela' do
      subject { page }
      preencher_dados_usuarios(firstname, lastname, phone, email)
      expect(page).to have_css('#_easyui_textbox_input1')
      expect(page).to have_css('#_easyui_textbox_input2')
      expect(page).to have_css('#_easyui_textbox_input3')
      expect(page).to have_css('#_easyui_textbox_input4')
      expect(page).to have_xpath('//div[@id="dlg-buttons"]/a[1]')
      expect(page).to have_xpath('//div[@id="dlg-buttons"]/a[2]')
    end

    it 'o campo em branco deve emitir mensagem' do
      expect(page).to have_text('This field is required.')
    end
  end

  context 'quando tento cadastrar sem firstname' do
    it_behaves_like 'o modal continua na tela', '', 'Santana', '99999999', 'vitor@email.com'
  end

  context 'quando tento cadastrar sem lastname' do
    it_behaves_like 'o modal continua na tela', 'Vitor', '', '99999999', 'vitor@email.com'
  end

  context 'quando tento cadastrar sem phone' do
    it_behaves_like 'o modal continua na tela', 'Vitor', 'Santana', '', 'v@email.com'
  end

  context 'quando tento cadastrar sem email' do
    it_behaves_like 'o modal continua na tela', 'Vitor', 'Santana', '99999999', ''
  end

  context 'quando inserir email invalido' do
    it_behaves_like 'o modal continua na tela', 'Vitor', 'Santana', '99999999', 'vemailcom'
  end

  context 'quando inserir email valido' do
    it 'o usuario eh exibido na lista' do
      subject { page }
      preencher_dados_usuarios('ALAC', 'Santana', '99999999', 'vitor@email.com')
      lista_user.selecionar_num_paginacao('999')
      lista_user.selecionar_num_registros('50')
      expect(page).to have_text('ALAC')
      expect(page).to have_text('Santana')
      expect(page).to have_text('99999999')
      expect(page).to have_text('vitor@email.com')
    end
  end
end
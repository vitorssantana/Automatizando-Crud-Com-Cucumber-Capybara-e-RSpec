# frozen_string_literal: true

require_relative '../spec_helper'
require_relative '../../pages/lista_user_page'
require_relative '../../pages/edicao_user_page'
require_relative '../../pages/cadastro_user_page'

describe EdicaoUserPage do
  let(:lista_user) { ListaUserPage.new }
  let(:edicao_user) { EdicaoUserPage.new }

  before(:all) do
    lista_user = ListaUserPage.new
    lista_user.load
    lista_user.clicar_add_novo_user
    cadastro_user = CadastroUserPage.new
    cadastro_user.preencher_dados_user(
      campo_first_name: 'Teste',
      campo_last_name: 'Edicao',
      campo_phone: '+5571999999999',
      campo_email: 'testeremocao@email.com'
    )
    cadastro_user.clicar_save_user
  end

  let!(:open_edit_user_page) do
    lista_user.load
    lista_user.selecionar_num_paginacao('999')
    lista_user.selecionar_num_registros('50')
    lista_user.selecionar_user_na_lista('Teste', 'Edicao')
    lista_user.clicar_edit_novo_user
  end

  def preencher_dados_user(firstname, lastname, phone, email)
    edicao_user.preencher_dados_user(
      campo_first_name: firstname,
      campo_last_name: lastname,
      campo_phone: phone,
      campo_email: email
    )
    edicao_user.clicar_save_user
  end

  shared_examples 'o modal continua na tela' do |firstname, lastname, phone, email|
    it 'o modal continua na tela' do
      subject { page }
      preencher_dados_user(firstname, lastname, phone, email)
      expect(page).to have_css('#_easyui_textbox_input1')
      expect(page).to have_css('#_easyui_textbox_input2')
      expect(page).to have_css('#_easyui_textbox_input3')
      expect(page).to have_css('#_easyui_textbox_input4')
      expect(page).to have_xpath('//div[@id="dlg-buttons"]/a[1]')
      expect(page).to have_xpath('//div[@id="dlg-buttons"]/a[2]')
      expect(page).to have_text('This field is required.')
    end
  end

  context 'quando nao preencher campo firstname' do
    it_behaves_like 'o modal continua na tela', '', 'Silva', '88888888', 'souza@email.com'
  end

  context 'quando nao preencher campo lastname' do
    it_behaves_like 'o modal continua na tela', 'Souza', '', '88888888', 'souza@email.com'
  end

  context 'quando nao preencher campo phone' do
    it_behaves_like 'o modal continua na tela', 'Souza', 'Santana', '', 'souza@email.com'
  end

  context 'quando nao preencher campo email' do
    it_behaves_like 'o modal continua na tela', 'Souza', 'Santana', '88888888', ''
  end

  context 'quando inserir email invalido' do
    it 'sera indicado que o email esta errado' do
      edicao_user.preencher_dados_user(
        campo_first_name: 'Souza',
        campo_last_name: 'Silva',
        campo_phone: '88888888',
        campo_email: 'silvasantana@gmailcom'
      )
      edicao_user.clicar_save_user
      expect(page).to have_css('#_easyui_textbox_input1')
      expect(page).to have_css('#_easyui_textbox_input2')
      expect(page).to have_css('#_easyui_textbox_input3')
      expect(page).to have_css('#_easyui_textbox_input4')
      expect(page).to have_xpath('//div[@id="dlg-buttons"]/a[1]')
      expect(page).to have_xpath('//div[@id="dlg-buttons"]/a[2]')
      expect(page).to have_text('Please enter a valid email address.')
    end
  end

  context 'quando inserir email valido' do
    it 'sera indicado que o email esta errado' do
      preencher_dados_user('Souza', 'Silva', '88888888', 'ssantana@gmail.com')
      lista_user.selecionar_num_paginacao('999')
      lista_user.selecionar_num_registros('50')
      expect(page).to have_text('Souza')
      expect(page).to have_text('Silva')
      expect(page).to have_text('88888888')
      expect(page).to have_text('ssantana@gmail.com')
    end
  end
end
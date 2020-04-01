require_relative '../spec_helper'
require_relative '../../pages/lista_user_page'
require_relative '../../pages/cadastro_user_page'
require_relative '../../pages/remocao_user_page'
require_relative '../../pages/edicao_user_page'

describe ListaUserPage do

    before :all do
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
    
    before do
        @lista_user.load
    end

    shared_examples 'o modal sera exibido' do |page|
        it 'o modal sera exibido' do
            if page.is_a?(CadastroUserPage)
                @lista_user.clicar_add_novo_user
                @cadastro_user = CadastroUserPage.new
                expect(page).to have_css('#_easyui_textbox_input1')
                expect(page).to have_css('#_easyui_textbox_input2')
                expect(page).to have_css('#_easyui_textbox_input3')
                expect(page).to have_css('#_easyui_textbox_input4')
                expect(page).to have_xpath('//div[@id="dlg-buttons"]/a[1]')
                expect(page).to have_xpath('//div[@id="dlg-buttons"]/a[2]')
            else 
                @lista_user = ListaUserPage.new
                @lista_user.selecionar_num_paginacao('999')
                @lista_user.selecionar_num_registros('50')
                @lista_user.selecionar_user_na_lista('Teste', 'Lista')
                @lista_user.clicar_edit_novo_user
                @edicao_user = EdicaoUserPage.new
                expect(page).to have_css('#_easyui_textbox_input1')
                expect(page).to have_css('#_easyui_textbox_input2')
                expect(page).to have_css('#_easyui_textbox_input3')
                expect(page).to have_css('#_easyui_textbox_input4')
                expect(page).to have_xpath('//div[@id="dlg-buttons"]/a[1]')
                expect(page).to have_xpath('//div[@id="dlg-buttons"]/a[2]')
            end
        end
    end

    shared_examples 'A tela de lista continua sendo exibida' do |page|
        it 'A tela de lista continua sendo exibida' do
            if page.is_a?(EdicaoUserPage)
                expect(@lista_user).to have_xpath('//div[@id="toolbar"]/a[1]')
                expect(@lista_user).to have_xpath('//div[@id="toolbar"]/a[2]')
                expect(@lista_user).to have_xpath('//div[@id="toolbar"]/a[3]')
                expect(@lista_user).to have_xpath('//select[@class="pagination-page-list"]')
                expect(@lista_user).to have_xpath('//input[@class="pagination-num"]')
                expect(@lista_user).to have_xpath('//tr[contains(@id, "dg_datagrid-row-r1-2-")]', count: 10)
            else
                @lista_user = ListaUserPage.new
                # @lista_user.clicar_remove_user
            end
        end
    end
        
    context 'Quando eu quiser cadastrar novo user' do
        it_behaves_like 'o modal sera exibido', CadastroUserPage.new
    end

    context 'Quando eu quiser editar user' do
        context 'Se eu tiver selecionado anteriormente' do
            it_behaves_like 'o modal sera exibido', EdicaoUserPage.new           
        end

        context 'Se eu nao tiver selecionado user anteriormente' do
            it_behaves_like 'A tela de lista continua sendo exibida', EdicaoUserPage.new
        end
    end

    context 'Quando eu quiser remover user' do
        context 'Se eu tiver selecionado anteriormente' do
            it 'Sera solicitado confirmacao de remocao' do
                @lista_user = ListaUserPage.new
                @lista_user.selecionar_num_paginacao('999')
                @lista_user.selecionar_num_registros('50')
                @lista_user.selecionar_user_na_lista('Teste', 'Lista')
                @lista_user.clicar_remove_user
                @remocao_user = RemocaoUserPage.new
                expect(@remocao_user).to have_text('Are you sure you want to destroy this user?')
                expect(@remocao_user).to have_xpath('//div[@class="dialog-button messager-button"]/a[1]')
                expect(@remocao_user).to have_xpath('//div[@class="dialog-button messager-button"]/a[2]')
            end
        end

        context 'Se eu nao tiver selecionado user anteriormente' do
            it_behaves_like 'A tela de lista continua sendo exibida', RemocaoUserPage.new
        end
    end

end
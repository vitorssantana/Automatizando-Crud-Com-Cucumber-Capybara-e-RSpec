require_relative '../spec_helper'
require_relative '../../pages/lista_user_page'
require_relative '../../pages/cadastro_user_page'

describe CadastroUserPage do

    before do
        @lista_user = ListaUserPage.new
        @lista_user.load
        @lista_user.clicar_add_novo_user
        @cadastro_user = CadastroUserPage.new
    end

    shared_examples 'o modal continua sendo exibido' do |firstname , lastname, phone, email|
        it 'o modal continua sendo exibido' do
            @cadastro_user.preencher_dados_user(
                campo_first_name: firstname,
                campo_last_name: lastname,
                campo_phone: phone,
                campo_email: email
            )
            @cadastro_user.clicar_save_user
            expect(@cadastro_user).to have_css('#_easyui_textbox_input1')
            expect(@cadastro_user).to have_css('#_easyui_textbox_input2')
            expect(@cadastro_user).to have_css('#_easyui_textbox_input3')
            expect(@cadastro_user).to have_css('#_easyui_textbox_input4')
            expect(@cadastro_user).to have_xpath('//div[@id="dlg-buttons"]/a[1]')
            expect(@cadastro_user).to have_xpath('//div[@id="dlg-buttons"]/a[2]')
            expect(@cadastro_user).to have_text('This field is required.')
        end
    end

    context 'quando for cadastrar user' do
        
        context 'quando nao preencher campo firstname' do         
            it_behaves_like 'o modal continua sendo exibido', '', 'Santana', '5571999999999', 'vitor@email.com'      
        end
    
        context 'quando nao preencher campo lastname' do
            it_behaves_like 'o modal continua sendo exibido', '', 'Santana', '5571999999999', 'vitor@email.com'      
        end

        context 'quando nao preencher campo phone' do
            it_behaves_like 'o modal continua sendo exibido', '', 'Santana', '5571999999999', 'vitor@email.com'      
        end

        context 'quando nao preencher campo email' do
            it_behaves_like 'o modal continua sendo exibido', '', 'Santana', '5571999999999', 'vitor@email.com'        
        end

        context 'quando inserir email invalido' do
            it_behaves_like 'o modal continua sendo exibido', '', 'Santana', '5571999999999', 'vitor@email.com'           
        end

        context 'quando inserir email valido' do  
            it 'o usuario eh exibido na lista' do
                @cadastro_user.preencher_dados_user(
                    campo_first_name: 'ALAC',
                    campo_last_name: 'Santana',
                    campo_phone: '+5571999999999',
                    campo_email: 'vitor@email.com'
                )
                @cadastro_user.clicar_save_user
                @lista_user.selecionar_num_paginacao('999')
                @lista_user.selecionar_num_registros('50')
                expect(@cadastro_user).to have_text('ALAC')
                expect(@cadastro_user).to have_text('Santana')
                expect(@cadastro_user).to have_text('+5571999999999')
                expect(@cadastro_user).to have_text('vitor@email.com')

            end
        end

    end

end
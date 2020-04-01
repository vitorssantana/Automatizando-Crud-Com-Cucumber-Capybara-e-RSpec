require_relative '../spec_helper'
require_relative '../../pages/lista_user_page'
require_relative '../../pages/edicao_user_page'

describe EdicaoUserPage do
    
    before (:all) do
        before (:all) do
            #Criar user
            @lista_user = ListaUserPage.new
            @lista_user.load
            @lista_user.clicar_add_novo_user
        
            @cadastro_user = CadastroUserPage.new
            @cadastro_user.preencher_dados_user(      
                campo_first_name: 'Teste',
                campo_last_name: 'Edicao',
                campo_phone: '+5571999999999',
                campo_email: 'testeremocao@email.com')
            @cadastro_user.clicar_save_user  
        end
    end

    before  do
        @lista_user = ListaUserPage.new
        @lista_user.load
        @lista_user.selecionar_user_na_lista('Teste', 'Edicao')
        @lista_user.clicar_edit_novo_user
        @edicao_user = EdicaoUserPage.new
    end

    shared_examples 'o modal continua sendo exibido' do |firstname , lastname, phone, email|
        it 'o modal continua sendo exibido' do
            @edicao_user.preencher_dados_user(
                campo_first_name: firstname,
                campo_last_name: lastname,
                campo_phone: phone,
                campo_email: email
            )
            @edicao_user.clicar_save_user
            expect(@edicao_user).to have_css('#_easyui_textbox_input1')
            expect(@edicao_user).to have_css('#_easyui_textbox_input2')
            expect(@edicao_user).to have_css('#_easyui_textbox_input3')
            expect(@edicao_user).to have_css('#_easyui_textbox_input4')
            expect(@edicao_user).to have_xpath('//div[@id="dlg-buttons"]/a[1]')
            expect(@edicao_user).to have_xpath('//div[@id="dlg-buttons"]/a[2]')
            expect(@edicao_user).to have_text('This field is required.')
        end
    end

    context 'Quando for alterar dados de user' do
        
        context 'quando nao preencher campo firstname' do         
            it_behaves_like 'o modal continua sendo exibido', '', 'Silva', '88888888', 'souzasilva@email.com'      
        end        
         context 'quando nao preencher campo lastname' do
            it_behaves_like 'o modal continua sendo exibido', 'Souza', '', '5571999999999', 'souzasilva@email.com'      
        end
    
        context 'quando nao preencher campo phone' do
            it_behaves_like 'o modal continua sendo exibido', 'Souza', 'Santana', '', 'souzasilva@email.com'      
        end
    
        context 'quando nao preencher campo email' do
            it_behaves_like 'o modal continua sendo exibido', 'Souza', 'Santana', '5571999999999', ''        
        end
    
        context 'quando inserir email invalido' do
            it 'sera indicado que o email esta errado' do
                @edicao_user.preencher_dados_user(
                    campo_first_name: 'Souza',
                    campo_last_name: 'Silva',
                    campo_phone: '88888888',
                    campo_email: 'silvasantana@gmailcom'
                )
                @edicao_user.clicar_save_user
                expect(@edicao_user).to have_css('#_easyui_textbox_input1')
                expect(@edicao_user).to have_css('#_easyui_textbox_input2')
                expect(@edicao_user).to have_css('#_easyui_textbox_input3')
                expect(@edicao_user).to have_css('#_easyui_textbox_input4')
                expect(@edicao_user).to have_xpath('//div[@id="dlg-buttons"]/a[1]')
                expect(@edicao_user).to have_xpath('//div[@id="dlg-buttons"]/a[2]')
                expect(@edicao_user).to have_text('Please enter a valid email address.')
            end       
        end 

        context 'quando inserir email valido' do
            it 'sera indicado que o email esta errado' do
                @edicao_user.preencher_dados_user(
                    campo_first_name: 'Souza',
                    campo_last_name: 'Silva',
                    campo_phone: '88888888',
                    campo_email: 'silvasantana@gmail.com'
                )
                @edicao_user.clicar_save_user
                @lista_user.selecionar_num_paginacao('999')
                @lista_user.selecionar_num_registros('50')
                expect(@edicao_user).to have_text('Souza')
                expect(@edicao_user).to have_text('Silva')
                expect(@edicao_user).to have_text('88888888')
                expect(@edicao_user).to have_text('silvasantana@gmail.com')
            end
        end
        
    end

end
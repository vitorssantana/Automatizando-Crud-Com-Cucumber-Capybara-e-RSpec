# frozen_string_literal: true

class ListaUserPage < SitePrism::Page
    set_url "https://www.jeasyui.com/tutorial/app/crud/index.html"

    element :botao_new_user, :xpath, '//div[@id="toolbar"]/a[1]'
    element :botao_edit_user, :xpath, '//div[@id="toolbar"]/a[2]'
    element :botao_remove_user, :xpath, '//div[@id="toolbar"]/a[3]'
    element :select_num_registros, :xpath, '//select[@class="pagination-page-list"]'
    element :input_num_paginacao, :xpath, '//input[@class="pagination-num"]'

    def clicar_add_novo_user
        botao_new_user.click
    end

    def clicar_edit_novo_user
        botao_edit_user.click
    end

    def clicar_remove_user
        botao_remove_user.click
    end    

    def selecionar_num_registros(option)
        esperar_carregamento_tela
        select_num_registros.select(option)
        select_num_registros.send_keys :enter
        esperar_carregamento_tela
    end

    def selecionar_num_paginacao(option) 
        esperar_carregamento_tela
        input_num_paginacao.set(option)
        input_num_paginacao.send_keys :enter
        esperar_carregamento_tela
    end

    def selecionar_user_na_lista(firstname, lastname)
        all(:xpath, '//tr[contains(@id, "dg_datagrid-row-r1-2-")]').each do |user| 
            if user.find(:css, '.dg_datagrid-cell-c1-firstname').text == firstname && user.find(:css, '.dg_datagrid-cell-c1-lastname').text == lastname
                execute_script('arguments[0].scrollIntoView();', find(:css, '.datagrid-view2 > .datagrid-body'))
                user.find(:css, '.dg_datagrid-cell-c1-firstname').click
                break
            end
        end
    end

    def esperar_carregamento_tela
        while page.has_css?('.datagrid-mask-msg', wait: 0) do
            sleep 0.1
        end
    end

end 
# frozen_string_literal: true

class ListaUserPage < SitePrism::Page
    set_url "https://www.jeasyui.com/tutorial/app/crud/index.html"

    element :botao_new_user, :xpath, '//div[@id="toolbar"]/a[1]'
    element :botao_edit_user, :xpath, '//div[@id="toolbar"]/a[2]'
    element :select_num_registros, :xpath, '//select[@class="pagination-page-list"]'
    element :input_num_paginacao, :xpath, '//input[@class="pagination-num"]'
    elements :lista_users, :xpath, '//tr[contains(@id, "dg_datagrid-row-r1-2-")]'

    def clicar_add_novo_user
        botao_new_user.click
    end

    def clicar_edit_novo_user
        botao_edit_user.click
    end

    def selecionar_num_registros(option)
        select_num_registros.select(option)
    end

    def selecionar_num_paginacao(option) 
        input_num_paginacao.set(option)
    end

    def selecionar_user_na_lista(firstname, lastname, phone, email)
        all(:xpath, '//tr[contains(@id, "dg_datagrid-row-r1-2-")]').each do |user|
            
            if user.find('.dg_datagrid-cell-c1-firstname') == firstname && user.find('.dg_datagrid-cell-c1-lastname') == lastname && user.find('.dg_datagrid-cell-c1-phone') == phone && user.find('.dg_datagrid-cell-c1-email') == email
                user.find('.dg_datagrid-cell-c1-firstname').click
            end
        end
    end

end 
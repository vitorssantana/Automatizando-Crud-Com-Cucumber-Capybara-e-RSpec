# frozen_string_literal: true

class ListaUserPage < SitePrism::Page
    set_url "https://www.jeasyui.com/tutorial/app/crud/index.html"

    element :botao_new_user, :xpath, '//div[@id="toolbar"]/a[1]'
    element :select_num_registros, :xpath, '//select[@class="pagination-page-list"]'
    element :input_num_paginacao, :xpath, '//input[@class="pagination-num"]'

    def clicar_add_novo_user
        botao_new_user.click
    end

    def selecionar_num_registros(option)
        select_num_registros.select(option)
    end

    def selecionar_num_paginacao(option) 
        input_num_paginacao.set(option)
    end

end 
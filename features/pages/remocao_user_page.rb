# frozen_string_literal: true

class RemocaoUserPage < SitePrism::Page
    set_url "https://www.jeasyui.com/tutorial/app/crud/index.html"

    element :botao_ok, :xpath, '//div[@class="dialog-button messager-button"]/a[1]'
    element :botao_cancel, :xpath, '//div[@class="dialog-button messager-button"]/a[2]'

    def clicar_ok 
        botao_ok.click
    end

    def clicar_cancel  
        botao_cancel.click
    end

end 
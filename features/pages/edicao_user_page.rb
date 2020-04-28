# frozen_string_literal: true

class EdicaoUserPage < SitePrism::Page
  element :campo_first_name, '#_easyui_textbox_input1'
  element :campo_last_name, '#_easyui_textbox_input2'
  element :campo_phone, '#_easyui_textbox_input3'
  element :campo_email, '#_easyui_textbox_input4'

  element :botao_save, :xpath, '//div[@id="dlg-buttons"]/a[1]'
  element :botao_cancel, :xpath, '//div[@id="dlg-buttons"]/a[2]'

  def preencher_dados_user (**attrs)
    campo_first_name.set    attrs[:campo_first_name]
    campo_last_name.set    attrs[:campo_last_name]
    campo_phone.set    attrs[:campo_phone]
    campo_email.set    attrs[:campo_email]
  end

  def clicar_save_user
        botao_save.click
  end

end 
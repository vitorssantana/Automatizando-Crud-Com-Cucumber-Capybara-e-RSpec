#language: pt
Funcionalidade: Criar users no jeasyui

    Para que eu possa criar users no sistema da jeasyui
    Sendo um usuario
    Posso entrar no site jeasyuis

    Contexto: 
    Dado que eu acesse o sistema da jeasyui
    
    Cenario: Aviso de dados nao preenchidos  
        Quando tento criar um novo usuario sem preencher os dados
        Entao o sistema nao deve permitir o cadastro
        E os campos obrigatorios terao que estar em vermelho

    Esquema do Cenário: Preenchimento de email invalido
        Quando eu tento criar um novo usuario preenchendo o email <email>
        Entao o sistema nao deve permitir o cadastro
        E me indica que o email esta invalido
        
        Exemplos:
            | email                   |
            | "vitorsantanagmailcom"  |
            | "vitorsantana.gmailcom" |
            | "vitorsantana@gmailcom" |
            | "545454545454545465667" |
    
    Cenario: Cadastrar user com sucesso
        Quando eu informo os seguintes dados do usuario:
            | firstname | "Vitor"                   |
            | lastname  | "Santana"                 |
            | phone     | "993962991"               |
            | email     | "vitorsantana@email.com"  |
        E realizo o cadastro
        Entao o sistema deve me mostrar o usuario na lista  
#language: pt
Funcionalidade: Criar users no jeasyui

    Para que eu possa criar users no sistema da jeasyui
    Sendo um usuario
    Posso entrar no site jeasyuis

    Contexto: 
        Dado que eu acesse o sistema da jeasyui

    Cenario: Nao preenchimento do campo firstname
        Quando eu tento cadastrar um user sem o firstname
        Entao o sistema nao deve permitir o cadastro

    Cenario: Nao preenchimento do campo lastname
        Quando eu tento cadastrar um user sem o lastname
        Entao o sistema nao deve permitir o cadastro

    Cenario: Nao preenchimento do campo phone
        Quando eu tento cadastrar um user sem o phone
        Entao o sistema nao deve permitir o cadastro

    Cenario: Nao preenchimento do campo email
        Quando eu tento cadastrar um user sem o email
        Entao o sistema nao deve permitir o cadastro

    Esquema do Cenário: Preenchimento de email invalido
        Quando eu tento criar um novo usuario preenchendo o email <email>
        Entao sera indicado que o email e invalido
        
        Exemplos:
            | email                   |
            | "vitorsantana@emailcom" |
            | "vitorsantana.emailcom" |
            | "vitorsantana@.com"     |
            | "545454545454545465667" |
    
    Cenario: Cadastrar user com sucesso
        Quando eu informo os seguintes dados do usuario:
            | firstname | Vitor                  |
            | lastname  | Santana                 |
            | phone     | 993962991               |
            | email     | imavvitorsantana@email.com|
        E realizo o cadastro
        Entao o sistema deve me mostrar o usuario na lista  
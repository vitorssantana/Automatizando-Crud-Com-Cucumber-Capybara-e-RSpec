#language: pt
Funcionalidade: Editar user no jeasyui

    Para que eu possa editar user no sistema da jeasyui
    Sendo um usuario
    Posso entrar no site jeasyuis

    Contexto: 
        Dado que eu acesse o sistema da jeasyui

    Cenario: Nao preenchimento do campo firstname
        Quando eu tento editar um user com firstname em branco
        Entao o sistema nao deve permitir a edicao

    Cenario: Nao preenchimento do campo lastname
        Quando eu tento editar um user com lastname em branco
        Entao o sistema nao deve permitir a edicao

    Cenario: Nao preenchimento do campo phone
        Quando eu tento editar um user com phone em branco
        Entao o sistema nao deve permitir a edicao

    Cenario: Nao preenchimento do campo email
        Quando eu tento editar um user com email em branco
        Entao o sistema nao deve permitir a edicao

    Esquema do Cenário: Preenchimento de email invalido
        Quando eu tento editar o user pondo email <email> invalido 
        Entao sera indicado que o email e invalido
        
        Exemplos:
            | email                   |
            | "vitorsantana@emailcom" |
            | "vitorsantana.emailcom" |
            | "vitorsantana@.com"     |
            | "545454545454545465667" |  

    Cenario: Editar user com sucesso
        Quando eu altero os dados do user por estes:
            | firstname | Souza                   |
            | lastname  | Silva                 |
            | phone     | 88888888               |
            | email     | souzasilva@email.com|
        E realizo a alteracao
        Entao o sistema deve me mostrar os novos dados na lista  

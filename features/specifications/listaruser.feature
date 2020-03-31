#language: pt
Funcionalidade: Listar user

    Para que eu possa listar e fazer acooes com users no sistema da jeasyui
    Sendo um usuario
    Posso entrar no site jeasyuis

    Contexto: 
        Dado que eu acesse o sistema da jeasyui

    
    Cenario: Entar na tela de cadastro de user
        Quando eu quiser criar um novo user
        Entao o sistema me exibe o modal de cadastro de user

    # @second_scenario_lista_user
    Cenario: Entrar na tela de editar sem selecionar user
        Quando eu escolho editar user sem seleciona-lo
        Entao o sistema continua exibindo a listagem

    Cenario: Entrar na tela de editar selecionando user
        Quando eu escolho editar user o selecionando antes
        Entao o sistema me exibe o modal de edicao de user

    Cenario: Tentar remover selecionando user
        Quando eu escolho remover user sem seleciona-lo
        Entao o sistema continua exibindo a listagem

    Cenario: Tentar remover nao selecionando user
        Quando eu escolho remover user o selecionando antes
        Entao o sistema solicita a confirmacao de remocao
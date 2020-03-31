#language: pt
Funcionalidade: Criar user no jeasyui

    Para que eu possa remover user no sistema da jeasyui
    Sendo um usuario
    Posso entrar no site jeasyuis

    Contexto: 
        Dado que eu acesse o sistema da jeasyui
        
    @first_scenario
    Cenario: Cancelar a remocao de user
        E selecionei um usuario para remocao
        Quando eu desisto de remover o usuario
        Entao o sistema deve exibir o user na lista

     Cenario: Confirmar a remocao do user   
        E selecionei um usuario para remocao
        Quando eu confirmar a remocao
        Entao o sistema nao deve exibir mais o user na lista
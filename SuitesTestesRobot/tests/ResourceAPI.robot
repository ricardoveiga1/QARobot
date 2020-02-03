*** Settings ***
Documentation   Documentação da API: http://fakerestapi.azurewebsites.net/swagger/ui/index#/Books
Library         RequestsLibrary
Library         Collections

*** Variable ***
${URL_API}      http://fakerestapi.azurewebsites.net/api/

*** Keyword ***
####SETUP E TEARDOWNS
Conectar a minha API
    Create Session      fakeAPI       ${URL_API}



#### Ações 
Requisitar todos os livros
    ${RESPOSTA}     Get Request     fakeAPI     Books
    Log             ${RESPOSTA.text}
    Set Test Variable       ${RESPOSTA}  ##variavel global para atender demais testes

Conferir o status code
    [Arguments]     ${STATUSCODE_DESEJADO}
    Should Be Equal As Strings      ${RESPOSTA.status_code}     ${STATUSCODE_DESEJADO}

Conferir o reason
    [Arguments]     ${REASON_DESEJADO}
    Should Be Equal As Strings      ${RESPOSTA.reason}      ${REASON_DESEJADO}

Conferir se retorna uma lista com "${QTD_BOOKS}" livros
    length Should Be        ${RESPOSTA.json()}      ${QTD_BOOKS} 

Requisitar o livro "${ID_BOOK}"
    ${RESPOSTA}     Get Request     fakeAPI     Books/${ID_BOOK}
    Log             ${RESPOSTA.text}
    Set Test Variable       ${RESPOSTA}
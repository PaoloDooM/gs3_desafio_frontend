## Desafio GS3 Tecnologia (Full stack)

1.  Criar um sistema que gerencie usuários e perfis.
2.  Usuário possui um perfil; um perfil pode ter vários usuários.
3.  O sistema deverá ter um administrador que crie os usuários e atribua ou modifique os perfis.
4.  O perfil usuário comum apenas visualizará suas próprias informações, podendo editá-las,  
    menos o perfil.
5.  Favor não utilizar os plugins do laravel que já trazem pronto esta solução, tipo o spatie/laravel-  
    permission.
6.  Utilizar no frontend a versão mais recente do Flutter.
7.  Utilizar no back o banco de sua preferência, preferencialmente PHP > 8 + Laravel 11.
8.  Será avaliado o código e o sistema rodando, favor encaminhar o link funcional ou as  
    instruções para subir a aplicação.
9.  Prazo para fazer o desafio: 1 semana.

## Requerimentos para compilação/execução do aplicativo android

*   **Flutter:** ^3.19.6
*   **AndroidSdk:** 34

## Instruções de compilação/execução

Para compilar ou executar o aplicativo, basta rodar o comando

```plaintext
flutter pub get
```

para baixar as dependências. Neste ponto, é possível executar o app no emulador com o comando

```plaintext
flutter run
```

e opcionalmente para construir os APKs o próximo comando

```plaintext
flutter build apk --target-platform android-arm,android-arm64,android-x64 --split-per-abi
```

Dependendo do emulador a ser usado, deverá ser ajustada a variável “BASEURL” no arquivo .env

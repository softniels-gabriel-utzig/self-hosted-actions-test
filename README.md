# Configurando Ações Auto-hospedadas (Self-hosted Actions)

## Introdução
Este tutorial auxlia na criação de um workflow simples no github actions.
Para obter instruções detalhadas, consulte o [tutorial oficial](https://docs.github.com/pt/actions/hosting-your-own-runners/managing-self-hosted-runners/adding-self-hosted-runners) fornecido pela GitHub.

## Configuração do Host

Aqui, explicaremos como configurar um host no sistema operacional Windows. É importante notar que você pode ter vários *Runners* em diferentes máquinas, portanto, a configuração deve ser adaptada para cada uma. Neste exemplo, utilizaremos a configuração padrão do GitHub.

**Boa prática**: Configure o runner dentro da pasta `\actions-runner` no repositório escolhido. Para fazer isso, abra o PowerShell, navegue até a pasta do repositório e execute os comandos descritos em: [Adicionar novo runner](https://github.com/`seu-username`/`seu-repositório`/settings/actions/runners/new).

*Dica*: Adicione a pasta `actions-runner` ao arquivo `.gitignore`.

Se você deseja configurar o runner como um serviço, execute-o como superusuário.

## Configurando o Workflow

Com o serviço (ou shell) em execução, é hora de configurar o workflow de acordo com as necessidades do seu projeto. Para isso, é necessário entender a estrutura básica do arquivo de configuração YAML.

Imagine que o seu runner é um _Listener_ que verifica periodicamente (utilizando long polling) o seu repositório no GitHub. Quando um evento (*Action*) configurado em um *workflow* é acionado, o runner recebe a ordem de executar um *job*.

Para adicionar um novo workflow, acesse https://github.com/`seu-username`/`seu-repositório`/actions/new.

Aqui está um exemplo de arquivo YAML para configurar um workflow:

```yaml
# Nome do workflow
name: CI

# Eventos que acionam o workflow
on:
  # Este exemplo executa o workflow sempre que houver um "PUSH" para a branch "main"
  push:
    branches: [ "main" ]

  # Esta linha permite a execução manual do workflow
  workflow_dispatch:

# Definição das jobs
jobs:
    # Nome da job, por exemplo: 'run-bat'
    run-bat:
        # Importante: Aqui é onde você insere o nome do seu runner, onde o workflow será executado.
        # Essas definições podem ser feitas por labels e/ou grupos.
        runs-on: self-hosted # definição padrão do GH
        
        # Sequência de tarefas (steps) da job
        steps:
            - Name: Checkout do código
              uses: actions/checkout@v3

            - Name: Executar um arquivo .bat
              run: ./test.bat

            - Name: Adicionar um log
              run: |
                echo "Action Executada em:" >> log.txt
                echo "- - - $(Get-date)" >> log.txt
                echo "----------------------" >> log.txt
```

Este [artigo](https://docs.github.com/pt/actions/using-workflows/workflow-syntax-for-github-actions) contém informações detalhadas sobre o uso avançado do arquivo de configuração YAML. Para este tutorial, estamos abordando apenas as configurações básicas.

## Próximo passo

Agora você configurou um workflow que será executado em seu host local sempre que houver um push para a branch `main`. Isso permite que você utilize ações auto-hospedadas para automatizar processos em seu repositório GitHub. Este foi o primeiro passo!

Agora podemos seguir na direção de criar uma operação que compile e faça o deploy automatizado em um servidor IIS de uma dll Lazarus ou Delphi  
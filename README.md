# CI/CD Pipeline - HTML e Banco de Dados

## Ferramentas utilizadas no projeto:

- **GitHub Actions:**
Para automatizar os workflows de CI/CD, incluindo o deploy do index.html e as migrações de banco de dados.
- **Azure Static Web Apps:** Para hospedar o index.html (página estática).
- **Supabase PostgreSQL:** Para gerenciar os bancos de dados de desenvolvimento e produção.

## **Como o repositório está configurado:**
O repositório possui dois ambientes: main e develop. Cada um desses ambientes possui seu próprio banco de dados.
Estão ativas regras de proteção das branches main e develop para garantir que apenas PRs sejam aceitos. 
A pasta worflows contém duas pipelines de CI/CD (para cada branch).
Na pasta migrations, contém um comando vazio para teste.

**Variáveis de Ambiente**
- AZURE_STATIC_WEB_APPS_API_TOKEN_HAPPY_TREE_09E76461E
- AZURE_STATIC_WEB_APPS_API_TOKEN_PURPLE_STONE_06C67221E
- SUPABASE_DB_NAME_DEVELOP
- SUPABASE_DB_NAME_MAIN
- SUPABASE_DB_PASSWORD_DEVELOP
- SUPABASE_DB_PASSWORD_MAIN
- SUPABASE_DB_USER_DEVELOP
- SUPABASE_DB_USER_MAIN
- SUPABASE_HOST_DEVELOP
- SUPABASE_HOST_MAIN


## **Como a pipeline funciona para main e develop:**

- Main
Push ou agendamento: A pipeline para main está configurada para rodar de forma agendada todos os dias às 21:00 UTC. A função principal dessa pipeline é fazer o deploy do código (index.html) no Azure Static Web App e rodar as migrações de banco de dados no Supabase para o ambiente de produção.
Código é feito checkout: O código é baixado da branch main para ser usado no processo de deploy.
Atualização do arquivo (opcional): Caso necessário, algum arquivo como index.html pode ser alterado antes do deploy.
Login no Azure: As credenciais do Azure são usadas para realizar o login na plataforma.
Deploy do código: O código é enviado para o Azure Static Web Apps para hospedar o conteúdo estático.
Migrações de banco de dados: As migrações de banco de dados são executadas no banco de dados Supabase de produção.

- Develop
Pull Request para develop: A pipeline é acionada sempre que um PR é aberto ou atualizado para a branch develop.
Checkout do código: O código da branch develop é baixado para a máquina de execução da pipeline.
Alteração no arquivo index.html (se necessário): Se necessário, alguma modificação é feita no arquivo index.html ou em qualquer outro arquivo.
Login no Azure: A pipeline se autentica no Azure usando as credenciais armazenadas no GitHub Secrets.
Deploy no Azure Static Web App: O conteúdo do repositório é enviado para o Azure Static Web Apps.
Migrações no banco de dados Supabase: As migrações SQL são aplicadas ao banco de dados de desenvolvimento no Supabase.

Os deploys são feitos para o Azure Static Web Apps da seguinte forma:
Login no Azure: A pipeline faz login no Azure usando as credenciais armazenadas no GitHub Secrets.
Deploy no Azure Static Web App: Depois de autenticada, a pipeline usa a ação azure/static-web-apps-deploy@v0 para enviar o código do repositório para o Azure Static Web Apps. O código é enviado da pasta especificada em app_location para o Azure, e os arquivos finais a serem publicadas estão na pasta configurada em output_location.
Com isso, sempre que a pipeline for executada para a branch main ou develop (no caso de PRs para develop), ela automaticamente faz o deploy do código atualizado para o Azure Static Web Apps, garantindo que o site está sempre na versão mais recente do código.

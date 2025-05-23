# MobX Restaurant

Sistema de gestão de mesas para restaurantes, desenvolvido em Flutter, utilizando MobX para gerenciamento de estado.

## Sobre

O projeto permite visualizar, adicionar, editar e gerenciar mesas e clientes em um restaurante. Cada mesa pode conter múltiplos clientes, e o gerenciamento é feito de forma reativa com MobX.

## Funcionalidades

- Listagem de mesas com identificação e clientes vinculados
- Adição e edição de mesas via modal
- Gerenciamento de clientes por mesa e cadastro rápido
- Busca de mesas por identificação ou clientes
- Interface responsiva e adaptada para desktop (Windows)

## Tecnologias

- **Flutter** 3.27.x
- **Dart** 3.6.x
- **MobX** para gerenciamento de estado
- **Material Design** customizado

## Como rodar

1. Clone o repositório
2. Instale as dependências:
   ```
   flutter pub get
   ```
3. Gere os arquivos do MobX:
   ```
   dart run build_runner build
   ```
4. Execute o app:
   ```
   flutter run -d windows
   ```

## Estrutura principal

- `main.dart`: inicialização do app, tema e tela principal (`TablesPage`)
- `features/tables`: telas e lógica de mesas
- `themes/`: temas customizados

## Observações

- O projeto já possui componentes reutilizáveis para modais e clientes.
- O gerenciamento de dependências é feito via injeção (`injection_container.dart`).
- O scroll é adaptado para mouse e touch.
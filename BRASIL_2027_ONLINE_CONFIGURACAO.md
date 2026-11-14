# Configuração do modo online — BRASIL 2027 v1.4

## O que está incluído
- Contas por e-mail/senha via Supabase Auth.
- Username público, perfis e avatares.
- Pedidos de amizade, lista de amigos e convites.
- Salas X1 presidencial: cada jogador administra seu país e acompanha os indicadores do adversário.
- Salas Coop: participantes compartilham o mesmo estado de governo; decisões simultâneas podem ser sobrescritas pela última gravação.
- Código de sala e sincronização em tempo real.

## Configurar gratuitamente (com cotas)
1. Crie um projeto no Supabase.
2. Abra SQL Editor e execute todo `BRASIL_2027_online_setup.sql`.
3. Em Project Settings → API, copie Project URL e chave anon/public.
4. O SQL tenta adicionar `brasil2027_rooms` à publicação Realtime automaticamente; confirme essa tabela em Database → Publications/Realtime.
5. Em Authentication → URL Configuration, defina Site URL como o endereço final do GitHub Pages e adicione esse mesmo endereço em Redirect URLs. Isso é importante para links de confirmação de e-mail.
6. Abra o jogo, vá a Modo online e cole a URL e a chave anon/public.
7. Crie uma conta e confirme o e-mail caso solicitado. Seu amigo cria outra conta no aparelho dele.
8. Adicione o username do amigo, aceite o pedido e envie um convite ou compartilhe o código da sala.

## Publicar no GitHub Pages
1. Crie um repositório e envie `BRASIL_2027_v1.4.html` com o nome `index.html` na raiz.
2. Em Settings → Pages, publique pela branch principal e pasta raiz.
3. Abra o endereço `https://SEU-USUARIO.github.io/NOME-DO-REPOSITORIO/`.
4. Use esse endereço como Site URL e Redirect URL no Supabase. Todos os jogadores usam a mesma configuração de projeto Supabase dentro do jogo.

GitHub Pages hospeda os arquivos estáticos; Supabase fornece autenticação, banco e realtime. Não coloque a chave `service_role` no HTML. A chave anon/public é feita para o cliente, desde que as políticas RLS do SQL estejam ativas.

## Limites honestos desta versão
- O modo local funciona sem qualquer conta ou serviço externo.
- O online depende da criação e configuração de um projeto Supabase pelo proprietário; não há credenciais incluídas no pacote.
- Convites diretos reservam a sala ao amigo escolhido; ambos precisam estar autenticados.
- Coop sincroniza gravações em tempo real, mas não tem trava transacional de turno.
- X1 mantém salvamentos separados por jogador e mostra os indicadores sincronizados do adversário.
- Não foi possível testar duas contas reais sem um projeto de backend configurado.

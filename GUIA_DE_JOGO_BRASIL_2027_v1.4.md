# 🇧🇷 BRASIL 2027 — GUIA DE JOGO v1.4

## 1. Visão geral
Simulador fictício de presidência com economia, orçamento, Congresso, ministérios, estados, diplomacia, segurança, opinião pública, crises e eleições. As decisões afetam o histórico e os indicadores.

## 2. Dificuldade ajustável
Na criação de presidência e nas configurações, use o controle deslizante de cinco níveis: Muito fácil, Fácil, Normal, Difícil e Muito difícil. Ele altera situação inicial, volatilidade econômica, frequência de eventos e exigência eleitoral.

## 3. Criar leis sem IA
Em Leis e reformas, abra Criar lei do zero. Escolha a área (saúde, educação, segurança, meio ambiente, infraestrutura, indústria, assistência, gestão pública ou economia), gasto anual adicional, variação de impostos, intensidade, prioridade social, dificuldade de execução e prazo. O sistema determinístico estima custo de implantação, despesa permanente, arrecadação e efeitos nos indicadores. A proposta vai à votação no Congresso e, se aprovada, aguarda sanção. O prazo fica registrado, mas os efeitos são aplicados de uma vez após a sanção, não mês a mês. Não interpreta texto jurídico livre nem verifica constitucionalidade: é um modelo de jogo previsível, sem créditos de IA.

## 4. Orçamento e despesas
Os controles deslizantes permitem redistribuir e aumentar despesas. O limite planejado foi elevado para R$ 4.500 bilhões anuais. Gastos maiores podem elevar serviços e investimentos, mas também ampliar déficit, consumir caixa e aumentar dívida.

## 5. Tesouro e patrimônio
Continuam disponíveis venda parcial de participações em empresas públicas fictícias, leilões de imóveis, concessões, títulos públicos, empréstimos, renegociação e recuperação fiscal. Alertas de caixa negativo permanecem visíveis.

## 6. Impeachment
Mecânica fictícia em etapas: denúncia, Câmara, abertura do Senado e julgamento. Quóruns simplificados para fins de jogo.

## 7. Online: X1, Coop e amigos
Um menu reúne contas por e-mail, username, pedidos de amizade, convites e salas com código. No X1 cada participante administra seu próprio governo e acompanha os indicadores do rival, sem turnos sincronizados ou placar final automático; no Coop os jogadores compartilham o mesmo estado.

Para ativar, crie um projeto Supabase, execute `BRASIL_2027_online_setup.sql`, habilite Realtime para `brasil2027_rooms` e informe Project URL + chave anon/public dentro do jogo. Consulte `BRASIL_2027_ONLINE_CONFIGURACAO.md`. Sem backend configurado, o modo local continua disponível.

Coop ainda não tem bloqueio de turnos simultâneos: a última gravação pode prevalecer. X1 compartilha retratos dos indicadores individuais, sem sincronizar turnos ou definir vencedor automaticamente.

## 8. Hospedagem no GitHub Pages
Envie o HTML como `index.html` para um repositório e ative Pages nas configurações. GitHub Pages hospeda o site estático; Supabase fornece autenticação, banco e tempo real. Não publique a chave `service_role`.

## 9. Sistemas anteriores mantidos
Painel, ministérios, economia, orçamento, Congresso, leis prontas, população/protestos, estados, segurança, diplomacia, notícias, crises, calendário, eleições, salvamento local, exportação/importação, debate local e histórico de governos.

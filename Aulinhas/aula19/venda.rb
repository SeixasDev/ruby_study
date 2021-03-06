require_relative "pagamento.rb"
require_relative "frete.rb"

class Venda
  include Pagamento
  include Frete

  PRODUTOS = {"PS4" => 1300.00, "XBOX" => 1200.00}

  def imprimir_produtos
    puts "--- Produtos ---"
    
    PRODUTOS.each do |k,v|
      puts "#{k} - #{SIMBOLO_MOEDA} #{v}"
    end
    puts "----------"
  end

  def vender
    puts "Olá! Seja bem-vindo!"
    puts "O que deseja comprar?"

    imprimir_produtos

    puts "> Digite o nome do produto..."
    produto = gets.chomp

    puts "Para onde deseja enviar?"

    imprimir_tabela_frete

    puts "> Digite o estado..."
    uf = gets.chomp

    puts "Calculando..."
    valor_final = calcular_valor_final(PRODUTOS[produto], uf)

    puts "Voce deve pagar #{SIMBOLO_MOEDA} #{valor_final} do produto + frete."

    puts "Deseja pagar? (S/N)"
    opcao = gets.chomp

    if opcao == "S"
      pagseguro = Pagamento::Pagseguro.new
      pagar(valor_final)
    else
      puts "Ok! Fica para a proxima!"
    end
  end
end

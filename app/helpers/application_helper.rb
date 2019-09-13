module ApplicationHelper
  def ordenador(coluna, titulo = nil)
    titulo ||= coluna.titleize
    direcao = coluna == ordenar_coluna && ordernar_direcao == "asc" ? "desc" : "asc"
    link_to titulo, :ordenar => coluna, :direcao => direcao
  end
end

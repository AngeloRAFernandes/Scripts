# Criado por Angelo Rodrigo Almeida Fernandes em 10-03-2023.
# Script para exclusão automatica de arquivos dentro de pastas e subpastas
# que tenham data de modificação ou criação acima de 180 dias. 

# Define o caminho da pasta que deseja monitorar
$path = "(caminho da pasta principal)"

# Define a data limite para exclusão (180 dias atrás)
$limit = (Get-Date).AddDays(-180)

# Obtém a lista de arquivos na pasta e em suas subpastas
$files = Get-ChildItem $path -Recurse | Where-Object { $_.LastWriteTime -lt $limit -or $_.CreationTime -lt $limit }

# Define o nome do arquivo de log
$logFile = "(caminho da pasta a ser armazenado o log)\" + (Get-Date -Format "yyyy-MM-dd_HH-mm-ss") + ".txt"

# Abre o arquivo de log para escrita
$stream = [System.IO.StreamWriter] $logFile

# Escreve a quantidade de arquivos excluídos no log
$stream.WriteLine("Foram excluídos " + $files.Count.ToString() + " arquivos.`n`nLista de arquivos excluidos:`n")

# Escreve o nome dos arquivos excluídos no log
foreach ($file in $files) {
    $stream.WriteLine($file.FullName)
}

# Fecha o arquivo de log
$stream.Close()

# Exclui os arquivos
$files | Remove-Item -Force

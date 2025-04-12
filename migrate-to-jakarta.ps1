# Navega a la carpeta del proyecto
cd C:\Users\LFMG9\OneDrive\Documentos\NetBeansProjects\Epe2Hotel

# Busca todos los archivos Java en el proyecto
$javaFiles = Get-ChildItem -Path "src" -Filter "*.java" -Recurse

foreach ($file in $javaFiles) {
    $content = Get-Content -Path $file.FullName -Raw
    
    # Reemplaza los imports de javax por jakarta
    $newContent = $content -replace "import javax\.servlet", "import jakarta.servlet"
    $newContent = $newContent -replace "import javax\.persistence", "import jakarta.persistence"
    $newContent = $newContent -replace "import javax\.ws\.rs", "import jakarta.ws.rs"
    $newContent = $newContent -replace "import javax\.validation", "import jakarta.validation"
    $newContent = $newContent -replace "import javax\.annotation", "import jakarta.annotation"
    $newContent = $newContent -replace "import javax\.ejb", "import jakarta.ejb"
    $newContent = $newContent -replace "import javax\.enterprise", "import jakarta.enterprise"
    $newContent = $newContent -replace "import javax\.faces", "import jakarta.faces"
    $newContent = $newContent -replace "import javax\.inject", "import jakarta.inject"
    $newContent = $newContent -replace "import javax\.json", "import jakarta.json"
    $newContent = $newContent -replace "import javax\.mail", "import jakarta.mail"
    $newContent = $newContent -replace "import javax\.security", "import jakarta.security"
    $newContent = $newContent -replace "import javax\.transaction", "import jakarta.transaction"
    $newContent = $newContent -replace "import javax\.xml", "import jakarta.xml"
    
    # Guarda los cambios
    $newContent | Set-Content -Path $file.FullName
    
    Write-Host "Actualizado: $($file.FullName)"
}

Write-Host "Migración completada. Ahora ejecuta 'mvn clean install' para compilar el proyecto."

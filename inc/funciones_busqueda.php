<?php
/**
 * Procesa los parámetros de búsqueda de $_GET.
 * Revisa si existe $_GET['search'] y construye las cláusulas SQL.
 *
 * @param array $fields Campos de la BD en los que buscar (ej: ['e.nombre', 'r.nombre']).
 * @return array ['where_sql' => string, 'params' => array, 'url_params' => array]
 */
function procesarBusqueda($fields) {
    $where_sql = "";
    $params = [];
    $url_params = [];
    
    if (!empty($_GET['search'])) {
        $searchTerm = $_GET['search'];
        $searchTermWildcard = '%' . $searchTerm . '%';
        $whereParts = [];
        
        // Crea un "LOWER(campo) LIKE ?" por cada campo
        foreach ($fields as $field) {
            $whereParts[] = "LOWER($field) LIKE LOWER(?)";
            $params[] = $searchTermWildcard;
        }
        
        $where_sql = "WHERE (" . implode(" OR ", $whereParts) . ")";
        $url_params['search'] = $searchTerm;
    }

    return [
        'where_sql' => $where_sql,
        'params' => $params,
        'url_params' => $url_params
    ];
}

/**
 * Imprime el HTML del formulario de búsqueda universal.
 *
 * @param string $actionFile El archivo al que el form debe apuntar (ej: 'gempleados.php').
 * @param string $placeholder El texto para el placeholder (ej: 'Buscar empleado...').
 */
function renderSearchForm($actionFile, $placeholder) {
    $currentSearch = isset($_GET['search']) ? htmlspecialchars($_GET['search']) : '';
    
    // Usamos HEREDOC para imprimir el HTML limpiamente
    echo <<<HTML
    <form action="{$actionFile}" method="GET" class="card-body pb-0">
        <div class="input-group mb-3">
            <input type="search" id="buscador" name="search" class="form-control" 
                   placeholder="{$placeholder}" 
                   value="{$currentSearch}">
            <button class="btn btn-primary" type="submit"><i class="bi bi-search"></i></button>
            <a href="{$actionFile}" class="btn btn-secondary"><i class="bi bi-arrow-counterclockwise"></i></a>
        </div>
    </form>
HTML;
}
?>
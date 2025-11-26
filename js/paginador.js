//Paginador universal
// paginador.js
/**
 * Inicializa un paginador del lado del cliente para una tabla.
 * Carga todos los datos y los filtra/pagina usando JavaScript.
 *
 * @param {string} searchInputId - El ID del <input> de búsqueda.
 * @param {string} tableBodyId - El ID del <tbody> de la tabla.
 * @param {string} paginationId - El ID del <ul> del paginador.
 * @param {number} rowsPerPage - Cuántas filas mostrar por página.
 */
function inicializarPaginadorCliente(searchInputId, tableBodyId, paginationId, rowsPerPage = 10) {
    const searchInput = document.getElementById(searchInputId);
    const tableBody = document.getElementById(tableBodyId);
    const pagination = document.getElementById(paginationId);
    let currentPage = 1;
    let allRows = Array.from(tableBody.getElementsByTagName("tr"));

    function getFilteredRows() {
        const filter = searchInput.value.toLowerCase();
        return allRows.filter(row => {
            // Oculta la fila si no hay datos (ej. 'No hay empleados')
            if (row.getElementsByTagName("td").length === 1) {
                row.style.display = "none";
                return false;
            }
            
            // Revisa todas las celdas excepto la última (acciones)
            const cells = Array.from(row.getElementsByTagName("td"));
            let found = false;
            for (let i = 0; i < cells.length - 1; i++) {
                if (cells[i] && cells[i].textContent.toLowerCase().includes(filter)) {
                    found = true;
                    break;
                }
            }
            return found;
        });
    }

    function showPage(page) {
        const filteredRows = getFilteredRows();
        const totalRows = filteredRows.length;
        const start = (page - 1) * rowsPerPage;
        const end = start + rowsPerPage;

        // Oculta todas las filas
        allRows.forEach(row => row.style.display = "none");

        // Muestra solo las filas filtradas y paginadas
        filteredRows.forEach((row, i) => {
            if (i >= start && i < end) {
                row.style.display = ""; // Muestra la fila
            }
        });

        renderPagination(totalRows, page);
    }

    function renderPagination(totalRows, page) {
        const totalPages = Math.max(1, Math.ceil(totalRows / rowsPerPage));
        pagination.innerHTML = ""; // Limpia el paginador

        if (totalPages <= 1) return; // No se necesita paginador

        // Botón Anterior
        let prevClass = page === 1 ? "disabled" : "";
        pagination.innerHTML += `<li class="page-item ${prevClass}">
            <a class="page-link" href="#" onclick="changePage(${page - 1}); return false;">Anterior</a>
        </li>`;

        // Botón Siguiente
        let nextClass = page === totalPages ? "disabled" : "";
        pagination.innerHTML += `<li class="page-item ${nextClass}">
            <a class="page-link" href="#" onclick="changePage(${page + 1}); return false;">Siguiente</a>
        </li>`;
    }

    // Función global (para que los <a> puedan llamarla)
    window.changePage = function(page) {
        const filteredRows = getFilteredRows();
        const totalRows = filteredRows.length;
        const totalPages = Math.max(1, Math.ceil(totalRows / rowsPerPage));
        
        if (page < 1 || page > totalPages) return;
        
        currentPage = page;
        showPage(currentPage);
    }

    function filterTable() {
        currentPage = 1;
        showPage(currentPage);
    }

    // Event listeners
    searchInput.addEventListener("keyup", filterTable);
    
    // Inicialización
    filterTable(); // Muestra la primera página al cargar
}
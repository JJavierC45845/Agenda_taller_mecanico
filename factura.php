<?php
include 'inc/conectar.php';
if (session_status() == PHP_SESSION_NONE) {
    session_start();
}

if (!isset($_SESSION['user_id'])) {
    header('Location: login.php');
    exit();
}

// Supón que recibes el id de la factura por GET
$factura_id = isset($_GET['id']) ? intval($_GET['id']) : 0;

if ($factura_id === 0) {
    die("No se proporcionó un ID de factura válido.");
}

// Consulta principal de factura
// MODIFICADO: Corregido el JOIN en empleados
$stmt = $pdo->prepare("
    SELECT f.numero_factura, f.fecha_emision, f.total, f.estado,
           c.nombre AS cliente, c.telefono,
           m.modelo, m.placa, m.ano,
           e.nombre AS empleado
    FROM facturas f
    JOIN clientes c ON f.cliente_id = c.id
    LEFT JOIN motos m ON f.moto_id = m.id
    LEFT JOIN empleados e ON f.empleado_id = e.id -- CORREGIDO
    WHERE f.id = ?
");
$stmt->execute([$factura_id]);
$factura = $stmt->fetch();

if (!$factura) {
    die("Factura no encontrada.");
}

// Consulta de detalles de factura
$stmt = $pdo->prepare("
    SELECT fd.tipo, fd.descripcion, fd.cantidad, fd.precio_unitario, fd.subtotal
    FROM factura_detalles fd
    WHERE fd.factura_id = ?
");
$stmt->execute([$factura_id]);
$detalles = $stmt->fetchAll();

?>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Factura #<?= htmlspecialchars($factura['numero_factura']) ?></title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css">
    
    <link rel="stylesheet" href="style.css"> 
    
    <style>
        /* Estilos específicos para la factura */
        :root {
            --factura-bg: #FFFFFF;
            --factura-text: #222831;
            --factura-accent: #948979; /* Usamos el color de acento del tema */
            --factura-border: #DFD0B8;
        }

        body { 
            background: var(--color-dark); /* Fondo oscuro exterior */
            color: var(--factura-text);
        }

        .factura-box {
            max-width: 800px;
            margin: 2rem auto;
            padding: 2.5rem;
            background: var(--factura-bg);
            border-radius: 8px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.1);
        }

        .factura-header {
            margin-bottom: 2rem;
            padding-bottom: 1.5rem;
            border-bottom: 2px solid var(--factura-accent);
        }

        .factura-title {
            font-size: 2.5rem;
            color: var(--factura-accent);
            font-weight: 700;
        }

        .info-factura, .info-cliente {
            font-size: 0.95rem;
        }
        
        .info-cliente strong, .info-factura strong {
            color: var(--factura-text);
            font-weight: 600;
            display: inline-block;
            min-width: 80px;
        }
        
        .info-cliente td, .info-factura td {
             padding-bottom: 5px;
        }

        .factura-table thead {
            background-color: var(--color-medium);
            color: var(--text-light);
        }
        
        .factura-table th {
            font-weight: 600;
        }

        .factura-table th, .factura-table td {
            padding: 0.75rem 1rem;
            vertical-align: middle;
        }

        .factura-table tbody tr:nth-of-type(odd) {
            background-color: #f9f9f9;
        }

        .factura-total {
            margin-top: 1.5rem;
        }

        .factura-total .total-label {
            font-size: 1.1rem;
            font-weight: 600;
            text-align: right;
            color: #555;
        }

        .factura-total .total-amount {
            font-size: 1.8rem;
            font-weight: 700;
            color: var(--factura-accent);
            text-align: right;
        }
        
        .factura-footer {
            margin-top: 3rem;
            padding-top: 1rem;
            border-top: 1px solid var(--factura-border);
            font-size: 0.9rem;
            color: #777;
            text-align: center;
        }
        
        .print-button {
            position: fixed;
            bottom: 20px;
            right: 20px;
            z-index: 100;
            box-shadow: 0 4px 10px rgba(0,0,0,0.2);
        }

        @media print {
            body {
                background: #fff;
                color: #000;
            }
            .factura-box {
                margin: 0;
                max-width: 100%;
                box-shadow: none;
                border-radius: 0;
            }
            .print-button {
                display: none;
            }
        }
    </style>
</head>
<body>

<div class="factura-box">
    
    <button class="btn btn-primary print-button" onclick="window.print()">
        <i class="bi bi-printer-fill"></i> Imprimir
    </button>

    <div class="factura-header row">
        <div class="col-sm-7">
            <span class="factura-title">Comprobante de Pago</span><br>
            <span class="text-muted">Mecanico el Pepom</span><br>
            <small class="text-muted">C. Aldama 360, Mexiquito, 47180 Arandas, Jal.</small>
        </div>
        <div class="col-sm-5 text-sm-end">
            <table class="info-factura" style="float: right;">
                <tr>
                    <td><strong>Factura #:</strong></td>
                    <td><?= htmlspecialchars($factura['numero_factura']) ?></td>
                </tr>
                <tr>
                    <td><strong>Fecha:</strong></td>
                    <td><?= htmlspecialchars(date('d/m/Y', strtotime($factura['fecha_emision']))) ?></td>
                </tr>
                 <tr>
                    <td><strong>Estado:</strong></td>
                    <td><?= htmlspecialchars(ucfirst($factura['estado'])) ?></td>
                </tr>
            </table>
        </div>
    </div>
    
    <div class="row mb-4">
        <div class="col-sm-7">
            <h5>Facturar a:</h5>
            <table class="info-cliente">
                <tr>
                    <td><strong>Cliente:</strong></td>
                    <td><?= htmlspecialchars($factura['cliente']) ?></td>
                </tr>
                <tr>
                    <td><strong>Teléfono:</strong></td>
                    <td><?= htmlspecialchars($factura['telefono']) ?></td>
                </tr>
                <?php if (!empty($factura['modelo'])): ?>
                <tr>
                    <td><strong>Vehículo:</strong></td>
                    <td><?= htmlspecialchars($factura['modelo']) ?></td>
                </tr>
                <tr>
                    <td><strong>Placa:</strong></td>
                    <td><?= htmlspecialchars($factura['placa'] ?? 'N/A') ?></td>
                </tr>
                <?php endif; ?>
            </table>
        </div>
         <div class="col-sm-5 text-sm-end">
            <h5>Vendido por:</h5>
            <strong><?= htmlspecialchars($factura['empleado'] ?? 'Sistema') ?></strong>
         </div>
    </div>

    <table class="table factura-table">
        <thead class="table-dark">
            <tr>
                <th scope="col" style="width: 5%;">Cant.</th>
                <th scope="col" style="width: 55%;">Descripción</th>
                <th scope="col" style="width: 20%;" class="text-end">P. Unitario</th>
                <th scope="col" style="width: 20%;" class="text-end">Subtotal</th>
            </tr>
        </thead>
        <tbody>
        <?php
        $subtotal_calculado = 0;
        foreach ($detalles as $d):
            $subtotal_calculado += $d['subtotal'];
        ?>
            <tr>
                <td><?= htmlspecialchars($d['cantidad']) ?></td>
                <td>
                    <strong><?= htmlspecialchars(ucfirst($d['tipo'])) ?></strong><br>
                    <small class="text-muted"><?= htmlspecialchars($d['descripcion']) ?></small>
                </td>
                <td class="text-end">$<?= number_format($d['precio_unitario'], 2) ?></td>
                <td class="text-end">$<?= number_format($d['subtotal'], 2) ?></td>
            </tr>
        <?php endforeach; ?>
        </tbody>
    </table>

    <div class="row factura-total">
        <div class="col-7 offset-5">
            <div class="row mb-2">
                <div class="col-7 total-label">Subtotal:</div>
                <div class="col-5 total-amount">$<?= number_format($subtotal_calculado, 2) ?></div>
            </div>
             <hr style="border-top: 2px solid var(--factura-border);">
            <div class="row">
                <div class="col-7 total-label" style="color: var(--factura-accent);">TOTAL:</div>
                <div class="col-5 total-amount">$<?= number_format($factura['total'], 2) ?></div>
            </div>
        </div>
    </div>

    <div class="factura-footer">
        <p>Gracias por su preferencia.</p>
    </div>
</div>

</body>
</html>
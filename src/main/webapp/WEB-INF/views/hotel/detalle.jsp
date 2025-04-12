<%-- 
    Document   : detalle
    Created on : 12-04-2025, 17:31:23
    Author     : LFMG9
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<jsp:include page="../common/header.jsp" />

<c:if test="${empty hotel}">
    <div class="alert alert-danger">
        El hotel solicitado no existe.
    </div>
</c:if>

<c:if test="${not empty hotel}">
    <div class="card mb-4">
        <div class="card-header">
            <div class="d-flex justify-content-between align-items-center">
                <h2 class="mb-0">${hotel.nombre}</h2>
                <div>
                    <c:forEach begin="1" end="${hotel.estrellas}">
                        <i class="bi bi-star-fill text-warning"></i>
                    </c:forEach>
                </div>
            </div>
        </div>
        <div class="card-body">
            <div class="row">
                <div class="col-md-8">
                    <p><i class="bi bi-geo-alt"></i> <strong>Dirección:</strong> ${hotel.direccion}, ${hotel.ciudad}, ${hotel.pais}</p>
                    <p><strong>Descripción:</strong> ${hotel.descripcion}</p>
                    <p><strong>Servicios:</strong> ${hotel.servicios}</p>
                </div>
                <div class="col-md-4">
                    <!-- Aquí podría ir una imagen del hotel -->
                    <div class="card">
                        <div class="card-body">
                            <h5 class="card-title">Información de Contacto</h5>
                            <p><i class="bi bi-telephone"></i> +56 2 1234 5678</p>
                            <p><i class="bi bi-envelope"></i> info@${hotel.nombre.toLowerCase().replace(' ', '')}.com</p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <h3 class="mb-3">Habitaciones Disponibles</h3>
    
    <c:if test="${not empty param.fechaIngreso && not empty param.fechaSalida}">
        <div class="alert alert-info">
            <p>Mostrando habitaciones disponibles para el período:</p>
            <p><strong>Fecha de ingreso:</strong> ${param.fechaIngreso} | <strong>Fecha de salida:</strong> ${param.fechaSalida}</p>
        </div>
    </c:if>
    
    <c:choose>
        <c:when test="${empty habitaciones}">
            <div class="alert alert-warning">
                No hay habitaciones disponibles para las fechas seleccionadas.
            </div>
        </c:when>
        <c:otherwise>
            <div class="table-responsive">
                <table class="table table-striped">
                    <thead>
                        <tr>
                            <th>Número</th>
                            <th>Tipo</th>
                            <th>Capacidad</th>
                            <th>Precio por Noche</th>
                            <th>Descripción</th>
                            <th>Acciones</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="habitacion" items="${habitaciones}">
                            <tr>
                                <td>${habitacion.numero}</td>
                                <td>${habitacion.tipo}</td>
                                <td>${habitacion.capacidad} personas</td>
                                <td><fmt:formatNumber value="${habitacion.precio}" type="currency" currencySymbol="$" /></td>
                                <td>${habitacion.descripcion}</td>
                                <td>
                                    <a href="${pageContext.request.contextPath}/app/habitaciones?action=detalle&id=${habitacion.id}" 
                                       class="btn btn-sm btn-info">Ver Detalles</a>
                                    <c:if test="${not empty sessionScope.usuario && not empty param.fechaIngreso && not empty param.fechaSalida}">
                                        <a href="${pageContext.request.contextPath}/app/reservas?action=crear&habitacionId=${habitacion.id}&fechaIngreso=${param.fechaIngreso}&fechaSalida=${param.fechaSalida}" 
                                           class="btn btn-sm btn-success">Reservar</a>
                                    </c:if>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </c:otherwise>
    </c:choose>
    
    <c:if test="${empty param.fechaIngreso || empty param.fechaSalida}">
        <div class="card mt-4">
            <div class="card-body">
                <h5 class="card-title">Buscar Disponibilidad</h5>
                <form action="${pageContext.request.contextPath}/app/hoteles" method="get">
                    <input type="hidden" name="action" value="detalle">
                    <input type="hidden" name="id" value="${hotel.id}">
                    
                    <div class="row g-3">
                        <div class="col-md-5">
                            <label for="fechaIngreso" class="form-label">Fecha de Ingreso</label>
                            <input type="date" class="form-control" id="fechaIngreso" name="fechaIngreso" required>
                        </div>
                        
                        <div class="col-md-5">
                            <label for="fechaSalida" class="form-label">Fecha de Salida</label>
                            <input type="date" class="form-control" id="fechaSalida" name="fechaSalida" required>
                        </div>
                        
                        <div class="col-md-2 d-flex align-items-end">
                            <button type="submit" class="btn btn-primary w-100">Buscar</button>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </c:if>
</c:if>

<script>
    document.addEventListener('DOMContentLoaded', function() {
        // Establecer fecha mínima como hoy
        const today = new Date().toISOString().split('T')[0];
        document.getElementById('fechaIngreso').min = today;
        document.getElementById('fechaSalida').min = today;
        
        // Validar que la fecha de salida sea posterior a la de ingreso
        document.getElementById('fechaIngreso').addEventListener('change', function() {
            document.getElementById('fechaSalida').min = this.value;
            
            // Si la fecha de salida es anterior a la nueva fecha de ingreso, actualizarla
            const fechaSalida = document.getElementById('fechaSalida');
            if (fechaSalida.value && fechaSalida.value < this.value) {
                fechaSalida.value = this.value;
            }
        });
    });
</script>

<jsp:include page="../common/footer.jsp" />

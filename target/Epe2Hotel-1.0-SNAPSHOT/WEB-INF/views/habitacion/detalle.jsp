<%-- 
    Document   : detalle
    Created on : 12-04-2025, 17:31:37
    Author     : LFMG9
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<jsp:include page="../common/header.jsp" />

<c:if test="${empty habitacion}">
    <div class="alert alert-danger">
        La habitación solicitada no existe.
    </div>
</c:if>

<c:if test="${not empty habitacion}">
    <div class="card mb-4">
        <div class="card-header">
            <h2 class="mb-0">Habitación ${habitacion.numero} - ${habitacion.hotel.nombre}</h2>
        </div>
        <div class="card-body">
            <div class="row">
                <div class="col-md-8">
                    <h4>${habitacion.tipo}</h4>
                    <p><strong>Capacidad:</strong> ${habitacion.capacidad} personas</p>
                    <p><strong>Precio por noche:</strong> <fmt:formatNumber value="${habitacion.precio}" type="currency" currencySymbol="$" /></p>
                    <p><strong>Descripción:</strong> ${habitacion.descripcion}</p>
                    
                    <h5 class="mt-4">Características de la Habitación</h5>
                    <ul>
                        <li>Aire acondicionado</li>
                        <li>TV de pantalla plana</li>
                        <li>Minibar</li>
                        <li>Caja fuerte</li>
                        <li>Baño privado con ducha</li>
                        <li>WiFi gratuito</li>
                    </ul>
                    
                    <h5 class="mt-4">Información del Hotel</h5>
                    <p><strong>Hotel:</strong> ${habitacion.hotel.nombre} 
                        <c:forEach begin="1" end="${habitacion.hotel.estrellas}">
                            <i class="bi bi-star-fill text-warning"></i>
                        </c:forEach>
                    </p>
                    <p><strong>Dirección:</strong> ${habitacion.hotel.direccion}, ${habitacion.hotel.ciudad}, ${habitacion.hotel.pais}</p>
                    <p><strong>Servicios del hotel:</strong> ${habitacion.hotel.servicios}</p>
                </div>
                <div class="col-md-4">
                    <!-- Aquí podría ir una imagen de la habitación -->
                    <div class="card">
                        <div class="card-body">
                            <h5 class="card-title">Reservar esta habitación</h5>
                            <form action="${pageContext.request.contextPath}/app/reservas" method="get">
                                <input type="hidden" name="action" value="crear">
                                <input type="hidden" name="habitacionId" value="${habitacion.id}">
                                
                                <div class="mb-3">
                                    <label for="fechaIngreso" class="form-label">Fecha de Ingreso</label>
                                    <input type="date" class="form-control" id="fechaIngreso" name="fechaIngreso" required>
                                </div>
                                
                                <div class="mb-3">
                                    <label for="fechaSalida" class="form-label">Fecha de Salida</label>
                                    <input type="date" class="form-control" id="fechaSalida" name="fechaSalida" required>
                                </div>
                                
                                <c:choose>
                                    <c:when test="${empty sessionScope.usuario}">
                                        <div class="alert alert-warning">
                                            Debes <a href="${pageContext.request.contextPath}/app/usuarios?action=login">iniciar sesión</a> para reservar.
                                        </div>
                                    </c:when>
                                    <c:otherwise>
                                        <button type="submit" class="btn btn-success w-100">Reservar Ahora</button>
                                    </c:otherwise>
                                </c:choose>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <div class="d-flex justify-content-between">
        <a href="${pageContext.request.contextPath}/app/hoteles?action=detalle&id=${habitacion.hotel.id}" class="btn btn-secondary">
            <i class="bi bi-arrow-left"></i> Volver al Hotel
        </a>
        <a href="${pageContext.request.contextPath}/app/hoteles" class="btn btn-secondary">
            Ver Todos los Hoteles
        </a>
    </div>
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

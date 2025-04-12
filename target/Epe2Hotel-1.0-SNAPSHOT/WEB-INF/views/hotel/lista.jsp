<%-- 
    Document   : lista
    Created on : 12-04-2025, 17:31:13
    Author     : LFMG9
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<jsp:include page="../common/header.jsp" />

<h2 class="mb-4">Hoteles Disponibles</h2>

<div class="card mb-4">
    <div class="card-body">
        <h5 class="card-title">Buscar Hoteles</h5>
        <form action="${pageContext.request.contextPath}/app/hoteles" method="get">
            <input type="hidden" name="action" value="buscar">
            
            <div class="row g-3">
                <div class="col-md-3">
                    <label for="ciudad" class="form-label">Ciudad</label>
                    <input type="text" class="form-control" id="ciudad" name="ciudad" value="${param.ciudad}">
                </div>
                
                <div class="col-md-2">
                    <label for="estrellas" class="form-label">Estrellas</label>
                    <select class="form-select" id="estrellas" name="estrellas">
                        <option value="">Todas</option>
                        <option value="3" ${param.estrellas == '3' ? 'selected' : ''}>3 estrellas o más</option>
                        <option value="4" ${param.estrellas == '4' ? 'selected' : ''}>4 estrellas o más</option>
                        <option value="5" ${param.estrellas == '5' ? 'selected' : ''}>5 estrellas</option>
                    </select>
                </div>
                
                <div class="col-md-2">
                    <label for="fechaIngreso" class="form-label">Fecha Ingreso</label>
                    <input type="date" class="form-control" id="fechaIngreso" name="fechaIngreso" value="${param.fechaIngreso}">
                </div>
                
                <div class="col-md-2">
                    <label for="fechaSalida" class="form-label">Fecha Salida</label>
                    <input type="date" class="form-control" id="fechaSalida" name="fechaSalida" value="${param.fechaSalida}">
                </div>
                
                <div class="col-md-3 d-flex align-items-end">
                    <button type="submit" class="btn btn-primary w-100">Buscar</button>
                </div>
            </div>
        </form>
    </div>
</div>

<c:choose>
    <c:when test="${empty hoteles}">
        <div class="alert alert-info">
            No se encontraron hoteles que coincidan con tu búsqueda.
        </div>
    </c:when>
    <c:otherwise>
        <div class="row row-cols-1 row-cols-md-3 g-4">
            <c:forEach var="hotel" items="${hoteles}">
                <div class="col">
                    <div class="card h-100">
                        <div class="card-header">
                            <div class="d-flex justify-content-between align-items-center">
                                <h5 class="mb-0">${hotel.nombre}</h5>
                                <div>
                                    <c:forEach begin="1" end="${hotel.estrellas}">
                                        <i class="bi bi-star-fill text-warning"></i>
                                    </c:forEach>
                                </div>
                            </div>
                        </div>
                        <div class="card-body">
                            <p class="card-text"><i class="bi bi-geo-alt"></i> ${hotel.direccion}, ${hotel.ciudad}, ${hotel.pais}</p>
                            <p class="card-text">${hotel.descripcion}</p>
                            <p class="card-text"><strong>Servicios:</strong> ${hotel.servicios}</p>
                            
                            <c:if test="${not empty hotel.habitaciones}">
                                <p class="card-text"><strong>Habitaciones disponibles:</strong> ${hotel.habitaciones.size()}</p>
                                <p class="card-text">
                                    <strong>Desde:</strong> 
                                    <fmt:formatNumber value="${hotel.habitaciones[0].precio}" type="currency" currencySymbol="$" />
                                    por noche
                                </p>
                            </c:if>
                        </div>
                        <div class="card-footer">
                            <a href="${pageContext.request.contextPath}/app/hoteles?action=detalle&id=${hotel.id}" 
                               class="btn btn-primary w-100">Ver Detalles</a>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>
    </c:otherwise>
</c:choose>

<jsp:include page="../common/footer.jsp" />
